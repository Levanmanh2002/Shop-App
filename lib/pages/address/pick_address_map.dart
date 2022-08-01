import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop/base/custom_button.dart';
import 'package:shop/controllers/location_controller.dart';
import 'package:shop/pages/address/widgets/search_location_dialogue_page.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/dimensions.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({
    Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this.googleMapController,
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initalPosition = const LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initalPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _initalPosition,
                        zoom: 17,
                      ),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition) {
                        _cameraPosition = cameraPosition;
                      },
                      onCameraIdle: () {
                        Get.find<LocationController>()
                            .updatePosition(_cameraPosition, false);
                      },
                    ),
                    Center(
                      child: !locationController.loading
                          ? Image.asset(
                              "assets/images/map_pin.jpg",
                              width: 100,
                              height: 100,
                            )
                          : Container(),
                    ),
                    Positioned(
                      top: Dimensions.height45,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: InkWell(
                        onTap: () => Get.dialog(LocationDialogue(
                          mapController: _mapController,
                        )),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10,
                          ),
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF89dad0),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20 / 2),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 25,
                                color: Colors.red,
                              ),
                              Expanded(
                                child: Text(
                                  locationController.pickPlacemark.name ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.font16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.width10,
                              ),
                              const Icon(
                                Icons.search,
                                size: 25,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: locationController.isLading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              buttonText: locationController.inZone
                                  ? widget.fromAddress
                                      ? 'Pick Address'
                                      : 'Pick Location'
                                  : 'Service is not available in your area',
                              onPressed: (locationController.buttonDisabled ||
                                      locationController.loading)
                                  ? null
                                  : () {
                                      if (locationController
                                                  .pickPosition.latitude !=
                                              0 &&
                                          locationController
                                                  .pickPlacemark.name !=
                                              null) {
                                        if (widget.fromAddress) {
                                          if (widget.googleMapController !=
                                              null) {
                                            widget.googleMapController!
                                                .moveCamera(CameraUpdate
                                                    .newCameraPosition(
                                                        CameraPosition(
                                                            target: LatLng(
                                              locationController
                                                  .pickPosition.latitude,
                                              locationController
                                                  .pickPosition.longitude,
                                            ))));
                                            locationController
                                                .setAddAddressData();
                                          }
                                          Get.toNamed(
                                              RouteHelper.getAddressPage());
                                        }
                                      }
                                    },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
