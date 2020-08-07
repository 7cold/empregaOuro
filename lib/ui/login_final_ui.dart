import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/ui/home_ui.dart';
import 'package:empregaOuro/widgets/system/appBar.dart';
import 'package:empregaOuro/widgets/system/appBarBackButton.dart';
import 'package:empregaOuro/widgets/system/loading_ui.dart';
import 'package:empregaOuro/widgets/system/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginFinalUi extends StatelessWidget {
  TextEditingController _emailCtr = TextEditingController();
  TextEditingController _senhaCtr = TextEditingController();

  final UserController c = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Obx(
      () => c.loading.value == true
          ? LoadingUi()
          : Scaffold(
              backgroundColor: Color(corPrincipal),
              appBar: appBarUi("Login", AppBarBackButton(function: () {
                Navigator.pop(context);
              }), () {}),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  color: Color(corPrincipal),
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          w > 1000 ? w / 4 : 20,
                          0,
                          w > 1000 ? w / 4 : 20,
                          0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFieldUi(
                              controller: _emailCtr,
                              icon: Ionicons.ios_mail,
                              label: "email",
                              passTrue: false,
                              textCapitalization: TextCapitalization.none,
                            ),
                            SizedBox(height: 10),
                            TextFieldUi(
                              controller: _senhaCtr,
                              icon: Ionicons.ios_lock,
                              label: "senha",
                              passTrue: true,
                              textCapitalization: TextCapitalization.none,
                            ),
                            SizedBox(height: 30),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              child: CupertinoButton(
                                color: Color(corSecundaria2),
                                child: Text("Login"),
                                onPressed: () {
                                  c.login(
                                      email: _emailCtr.text,
                                      pass: _senhaCtr.text,
                                      onSuccess: () {
                                        Get.to(HomeUi());
                                      },
                                      onFail: () {
                                        Get.snackbar('Error 😕',
                                            'Verifique seus dados e tente novamente',
                                            backgroundColor:
                                                CupertinoColors.systemRed,
                                            margin: EdgeInsets.all(10),
                                            colorText: Colors.white);
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
