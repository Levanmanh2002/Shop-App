import 'package:get/get.dart';
import 'package:shop/data/repositiory/athu_repo.dart';
import 'package:shop/models/response_model.dart';
import 'package:shop/models/signup_body_model.dart';

class AthuController extends GetxController implements GetxService {
  final AthuRepo athuRepo;
  AthuController({
    required this.athuRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await athuRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      athuRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    athuRepo.getUserToken();
    _isLoading = true;
    update();
    Response response = await athuRepo.login(phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      athuRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumnerAndPassword(String number, String password) {
    athuRepo.saveUserNumnerAndPassword(number, password);
  }

  bool userLoggedIn() {
    return athuRepo.userLoggedIn();
  }

  bool clearShareData() {
    return athuRepo.clearShareData();
  }
}
