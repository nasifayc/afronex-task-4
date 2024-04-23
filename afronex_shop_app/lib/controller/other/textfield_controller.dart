import 'package:get/get.dart';

class TextFieldController extends GetxController {
  final RxBool obscureText = true.obs;

  void obscureToggler() {
    obscureText.value = !obscureText.value;
    update();
  }
}
