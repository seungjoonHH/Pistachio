import 'package:pistachio/model/enum/enum.dart';
import 'package:pistachio/presenter/firebase/auth/auth.dart';

class LoginPresenter {
  static void loginButtonPressed(LoginType type) async {
    await AuthPresenter.pLogin(type);
  }

  static void appleLoginButtonPressed() {}
}