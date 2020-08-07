import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/ui/home_ui.dart';
import 'package:empregaOuro/ui/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<UserController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.put(UserController()).firebaseUser.value != null)
          ? HomeUi()
          : LoginUi();
    });
  }
}
