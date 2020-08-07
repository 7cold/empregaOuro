import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/widgets/system/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

alertAddItemSchool(BuildContext context) {
  UserController c = Get.put(UserController());

  TextEditingController instituicao = TextEditingController();
  TextEditingController curso = TextEditingController();
  TextEditingController grau = TextEditingController();
  Rx<DateTime> dateInicio = DateTime.now().obs;
  Rx<DateTime> dateFim = DateTime.now().obs;
  RxBool concluido = false.obs;

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

  _bottomShowGrau() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Escolha o Tipo'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Ensino Médio Incompleto'),
            onPressed: () {
              grau.text = "Ensino Médio Incompleto";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Ensino Médio Completo'),
            onPressed: () {
              grau.text = "Ensino Médio Completo";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Escola Técnica'),
            onPressed: () {
              grau.text = "Escola Técnica";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Escola Técnica + Ens. Médio'),
            onPressed: () {
              grau.text = "Escola Técnica + Ens. Médio";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Graduação'),
            onPressed: () {
              grau.text = "Graduação";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Pós-Graduação'),
            onPressed: () {
              grau.text = "Pós-Graduação";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Mestrado'),
            onPressed: () {
              grau.text = "Mestrado";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Doutorado'),
            onPressed: () {
              grau.text = "Doutorado";
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  showDialog(
      context: context,
      child: AlertDialog(
        title: Text(
          "Nova Formação",
        ),
        content: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
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
                    label: "instituicao/escola",
                    controller: instituicao,
                  ),
                  SizedBox(height: 5),
                  TextFieldUi(
                    passTrue: false,
                    icon: null,
                    textCapitalization: TextCapitalization.words,
                    onChanged: null,
                    inputType: null,
                    label: "curso",
                    controller: curso,
                  ),
                  SizedBox(height: 5),
                  TextFieldUi(
                    onTap: () => _bottomShowGrau(),
                    readOnly: true,
                    passTrue: false,
                    icon: null,
                    textCapitalization: TextCapitalization.words,
                    onChanged: null,
                    inputType: null,
                    label: "grau",
                    controller: grau,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text("Concluído: "),
                      Transform.scale(
                        scale: 0.7,
                        child: Obx(
                          () => CupertinoSwitch(
                            value: concluido.value,
                            onChanged: (bool value) {
                              concluido.value = value;
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
                      '${formatDate(dateInicio.value, [
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
                  SizedBox(height: 5),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      '${formatDate(dateFim.value, [
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
                            c.createFormacao({
                              'instituicao': instituicao.value.text,
                              'curso': curso.value.text,
                              'grau': grau.value.text,
                              'concluido': concluido.value,
                              'dataInicio':
                                  Timestamp.fromDate(dateInicio.value),
                              'dataFim': Timestamp.fromDate(dateFim.value),
                            }, c.firebaseUser.value.uid).then((value) {
                              Get.back();
                              Get.snackbar('Sucesso 🎉',
                                  'Formação adicionada com sucesso!',
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
