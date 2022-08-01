import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop/data/api/api_checker.dart';
import 'package:shop/data/repositiory/location_repo.dart';
import 'package:shop/models/address_model.dart';
import 'package:shop/models/response_model.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({
    required this.locationRepo,
  });

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressKist => _allAddressList;
  late List<String> _addressTypeList = ["home", "office", "other"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  bool _isLoading = false;
  bool get isLading => _isLoading;

  bool _inZone = false;
  bool get inZone => _inZone;

  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  List<Prediction> _predictionList = [];
  
  // Future<AddressModel> getCurrentLocation(bool fromAddress,
  //     {required GoogleMapController mapController,
  //     LatLng? defaultLatLng,
  //     bool notify = true}) async {
  //   _isLoading = true;
  //   if (notify) {
  //     update();
  //   }
  //   AddressModel _addressModel;
  //   late Position _myPosition;
  //   Position _test;

  //   Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best.then((Position position) async {
  //     _myPosition = position;

  //     if (fromAddress) {
  //       _position = _myPosition;
  //     } else {
  //       _pickPosition = _myPosition;
  //     }
  //     mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //         target: LatLng(_myPosition.latitude, _myPosition.longitude))));

  //     Placemark _myPlaceMark;
  //     try{
  //       if(!GetPlatform.isWeb) {
  //         List<Placemark> placemark = await placemarkFromCoordinates(latitude, longitude)
  //         _myPlaceMark = placemark.first;
  //       }
  //       else{
  //         String _address = await getAddressfromGeocode(LatLng(_myPlaceMark, longitude))
  //         _myPlaceMark = Placemark(name: _address, locality: '', postalCode: '');

  //       }
  //     }catch(e){
  //       String _address = await getAddressfromGeocode(LatLng(_myPosition, longitude))
  //       _myPlaceMark = Placemark(name: _address, locality: '', postalCode: '');

  //     }
  //     fromAddress? _placemark = _myPlaceMark : _pickPlacemark = _myPlaceMark;

  //     _addressModel = AddressModel(
  //      latitude: _myPosition.latitude.toString(), longitude: _myPosition.longitude.toString(),

  //      address: '${_myPlaceMark.name?? ''}',
  //        '${_myPlaceMark.locality?? ''}',
  //        '${_myPlaceMark.postalCode?? ''}',
  //         '${_myPlaceMark.country?? ''}',

  //     );
  //     _loading = false;
  //     update();

  //   }).catchError((e) {
  //    _myPosition=Position(longitude: defaultLatLng !=null?defaultLatLng,
  //    latitude: latitude,
  //    timestamp: DateTime.now(),
  //    accuracy: 1,
  //     altitude: 1,
  //     heading: 1,
  //     speed: 1,
  //     speedAccuracy: 1,
  //   );

  //   }),);

  // }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        }

        ResponseModel _responseModel = await getZone(
          position.target.latitude.toString(),
          position.target.longitude.toString(),
          false,
        );
        _buttonDisabled = !_responseModel.isSuccess;

        if (_changeAddress) {
          String _address = await getAddressfromGeocode(
            LatLng(
              position.target.latitude,
              position.target.longitude,
            ),
          );
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address = "Unknown location found";
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    if (response.body["status"] == 'OK') {
      _address = response.body["results"][0]["formatted_address"].toString();
    } else {}
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      String message = response.body("message");
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel =
          ResponseModel(true, response.body["zoned_id"].toString());
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText!);
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    print(response.statusText);
    update();

    return _responseModel;
  }

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Response response = await locationRepo.seachLocation(text);
      if (response.statusCode == 200 && response.body['status'] == 'OK') {
        _predictionList = [];
        response.body['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }

  setLocation(
      String placeID, String address, GoogleMapController mapController) async {
    _loading = true;
    update();
    PlacesDetailsResponse detail;
    Response response = await locationRepo.setLocation(placeID);
    detail = PlacesDetailsResponse.fromJson(response.body);
    _pickPosition = Position(
      latitude: detail.result.geometry!.location.lat,
      longitude: detail.result.geometry!.location.lat,
      timestamp: DateTime.now(),
      heading: 1,
      accuracy: 1,
      altitude: 1,
      speedAccuracy: 1,
      speed: 1,
    );
    _pickPlacemark = Placemark(name: address);
    _changeAddress = false;
    if (!mapController.isNull) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
              detail.result.geometry!.location.lat,
              detail.result.geometry!.location.lng,
            ),
            zoom: 17),
      ));
    }
    _loading = false;
    update();
  }
}
