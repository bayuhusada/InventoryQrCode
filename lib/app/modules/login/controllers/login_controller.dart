import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailC = TextEditingController(
    text: 'admin@gmail.com'
  );
  final TextEditingController passwordC = TextEditingController(
    text: 'admin123'
  );
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;
}
