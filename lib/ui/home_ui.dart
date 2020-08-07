import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/ui/login_ui.dart';
import 'package:empregaOuro/ui/profile_ui.dart';
import 'package:empregaOuro/widgets/home/widget_desktop.dart';
import 'package:empregaOuro/widgets/home/widget_mobile.dart';
import 'package:empregaOuro/widgets/system/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class HomeUi extends StatelessWidget {
  final UserController c = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    print(w.toString() + "x" + h.toString());
    return Scaffold(
        backgroundColor: Color(corPrincipal),
        drawer: w > 1200
            ? null
            : Drawer(
                elevation: 0,
                child: Container(
                  width: w,
                  color: Color(corDark),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 20, top: 40),
                            child: c.userData['nome'] == null
                                ? Center(
                                    child: CupertinoActivityIndicator(),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(ProfileUi());
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              c.userData['nome'],
                                              style: fontBold16White,
                                            ),
                                            Icon(
                                              Ionicons.ios_arrow_forward,
                                              color: Color(corPrincipal),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        c.userData['enderecoBairro'] +
                                            " - " +
                                            c.userData['enderecoCidade'],
                                        style: fontRegular16Light,
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        c.userData['cel'],
                                        style: fontRegular16Light,
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        c.userData['email'],
                                        style: fontRegular16Light,
                                      ),
                                      SizedBox(height: 30),
                                      InkWell(
                                        onTap: () {
                                          c.logout();
                                          Get.off(LoginUi());
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4),
                                              child: Icon(
                                                Ionicons.ios_log_out,
                                                color: Color(corPrincipal),
                                                size: 16,
                                              ),
                                            ),
                                            Text(
                                              " logout",
                                              style: fontBold16White,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ]),
                ),
              ),
        appBar: w > 1200
            ? null
            : appBarUi(
                "Home",
                null,
                () {},
              ),
        body: w > 1200 ? WidgetDesktop() : WidgetMobile());
  }
}
