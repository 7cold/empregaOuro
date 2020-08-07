import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/widgets/signup/item_enterprise_signup.dart';
import 'package:empregaOuro/widgets/signup/item_user_signup.dart';
import 'package:empregaOuro/widgets/system/appBar.dart';
import 'package:empregaOuro/widgets/system/appBarBackButton.dart';
import 'package:empregaOuro/widgets/system/loading_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpUi extends StatelessWidget {
  final UserController c = Get.put(UserController());

  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Procurar"),
    1: Text("Oferecer")
  };

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Obx(
      () => c.loading.value == true
          ? LoadingUi()
          : Scaffold(
              backgroundColor: Color(corPrincipal),
              appBar: appBarUi("Cadastro", AppBarBackButton(
                function: () {
                  Get.back();
                },
              ), null),
              body: Obx(
                () => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      w > 1000 ? w / 3 : 20,
                      20,
                      w > 1000 ? w / 3 : 20,
                      20,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Meu interesse é:",
                            style: fontBold18Dark,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: w,
                          child: CupertinoSlidingSegmentedControl(
                              groupValue: c.typeService.value,
                              children: myTabs,
                              onValueChanged: (i) {
                                c.changeTypeService(i);
                              }),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 10),
                        Material(
                          elevation: 4,
                          shadowColor: CupertinoColors.systemFill,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                            width: w,
                            height: 160,
                            child: c.typeService.value == 0
                                ? Image.asset(
                                    "assets/illustration/add-user.png",
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/illustration/search-user.png",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        c.typeService.value == 0
                            ? ItemUserSignUp()
                            : ItemEnterpriseSignUp()
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
