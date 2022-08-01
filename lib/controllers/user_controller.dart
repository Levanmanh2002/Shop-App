import 'package:get/get.dart';
import 'package:shop/data/repositiory/user_repo.dart';
import 'package:shop/models/response_model.dart';
import 'package:shop/models/user_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  UserModel? _userModel;

  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}
