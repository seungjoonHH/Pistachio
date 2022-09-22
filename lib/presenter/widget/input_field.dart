import 'package:get/get.dart';

class InputFieldPresenter extends GetxController {
  bool invalid = false;

  void validate(bool invalid) async {
    this.invalid = invalid;
    update();
    if (invalid == true) {
      await Future.delayed(const Duration(milliseconds: 1000), () {
        this.invalid = false;
        update();
      });
    }
  }
}