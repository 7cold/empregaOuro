import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/widgets/system/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

alertAddItemWork(BuildContext context) {
  UserController c = Get.put(UserController());

  TextEditingController empresa = TextEditingController();
  TextEditingController cargo = TextEditingController();

  Rx<DateTime> dateInicio = DateTime.now().obs;
  Rx<DateTime> dateFim = DateTime.now().obs;
  RxBool atual = false.obs;

  Future<Null> _selectDateInicio(BuildContext context) async {
    dateInicio.value = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
    );
  }

  Future<Null> _selectDateFim(BuildContext context) async {
    dateFim.value = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
    );
  }

  showDialog(
      context: context,
      child: AlertDialog(
        title: Text(
          "Nova Experiência",
        ),
        content: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: 420,
            width: 300,
            child: Obx(
              () => Column(
                children: [
                  SizedBox(height: 10),
                  TextFieldUi(
                    passTrue: false,
                    icon: null,
                    textCapitalization: TextCapitalization.words,
                    onChanged: null,
                    inputType: null,
                    label: "empresa",
                    controller: empresa,
                  ),
                  SizedBox(height: 5),
                  TextFieldUi(
                    passTrue: false,
                    icon: null,
                    textCapitalization: TextCapitalization.words,
                    onChanged: null,
                    inputType: null,
                    label: "cargo",
                    controller: cargo,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text("Empresa Atual: "),
                      Transform.scale(
                        scale: 0.7,
                        child: Obx(
                          () => CupertinoSwitch(
                            value: atual.value,
                            onChanged: (bool value) {
                              atual.value = value;
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      dateInicio.value == null
                          ? '${formatDate(DateTime.now(), [
                              dd,
                              '/',
                              mm,
                              '/',
                              yyyy,
                            ])}'
                          : '${formatDate(dateInicio.value, [
                              dd,
                              '/',
                              mm,
                              '/',
                              yyyy,
                            ])}',
                    ),
                  ),
                  SizedBox(
                    height: 33,
                    width: 200,
                    child: CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: CupertinoColors.activeBlue,
                      child: Text("Iniciado em"),
                      onPressed: () => _selectDateInicio(context),
                    ),
                  ),
                  atual.value == true ? SizedBox() : SizedBox(height: 5),
                  atual.value == true ? SizedBox() : Divider(),
                  atual.value == true
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            dateFim.value == null
                                ? '${formatDate(DateTime.now(), [
                                    dd,
                                    '/',
                                    mm,
                                    '/',
                                    yyyy,
                                  ])}'
                                : '${formatDate(dateFim.value, [
                                    dd,
                                    '/',
                                    mm,
                                    '/',
                                    yyyy,
                                  ])}',
                          ),
                        ),
                  atual.value == true
                      ? SizedBox()
                      : SizedBox(
                          height: 33,
                          width: 200,
                          child: CupertinoButton(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: CupertinoColors.activeBlue,
                            child: Text("Finalizado em"),
                            onPressed: () => _selectDateFim(context),
                          ),
                        ),
                  SizedBox(height: 5),
                  Divider(),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Color(corSecundaria2),
                          onPressed: () {
                            c.createWork({
                              'empresa': empresa.value.text,
                              'cargo': cargo.value.text,
                              'atual': atual.value,
                              'dataInicio':
                                  Timestamp.fromDate(dateInicio.value),
                              'dataFim': atual.value == true
                                  ? Timestamp.fromDate(
                                      DateTime(1950, 01, 01, 00, 00))
                                  : Timestamp.fromDate(dateFim.value),
                            }, c.firebaseUser.value.uid).then((value) {
                              Get.back();
                              Get.snackbar('Sucesso 🎉',
                                  'Experiência adicionada com sucesso!',
                                  backgroundColor: CupertinoColors.systemGreen,
                                  margin: EdgeInsets.all(10),
                                  colorText: Colors.white);
                            }).catchError((e) {
                              Get.back();
                              Get.snackbar('Error 😕',
                                  'Verifique seus dados e tente novamente',
                                  backgroundColor: CupertinoColors.systemRed,
                                  margin: EdgeInsets.all(10),
                                  colorText: Colors.white);
                            });
                          },
                          child: Text("Salvar"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
}
