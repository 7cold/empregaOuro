import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/ui/home_ui.dart';
import 'package:empregaOuro/widgets/system/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ItemUserSignUp extends StatelessWidget {
  final UserController c = Get.put(UserController());
  //User
  TextEditingController _nomeCtr = TextEditingController();
  TextEditingController _emailCtr = TextEditingController();
  TextEditingController _senhaCtr = TextEditingController();
  final _telCtr = MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController _enderecoCtr = TextEditingController();
  TextEditingController _enderecoNumCtr = TextEditingController();
  TextEditingController _enderecoBairroCtr = TextEditingController();
  TextEditingController _enderecoCidadeCtr = TextEditingController();
  DateTime _dataNasc;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stepper(
          onStepTapped: (i) {
            c.changeStepUser(i);
          },
          physics: BouncingScrollPhysics(),
          currentStep: c.stepUser.value,
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                c.stepUser.value != 2
                    ? Container(
                        margin: EdgeInsets.only(right: 10, top: 20),
                        height: 30,
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          color: CupertinoColors.systemGreen,
                          onPressed: onStepContinue,
                          child: const Text('Continuar'),
                        ),
                      )
                    : SizedBox(),
                c.stepUser.value <= 2
                    ? Container(
                        margin: EdgeInsets.only(right: 10, top: 20),
                        height: 30,
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          color: CupertinoColors.systemGrey2,
                          onPressed:
                              c.stepUser.value == 0 ? null : onStepCancel,
                          child: const Text('Voltar'),
                        ),
                      )
                    : SizedBox(),
              ],
            );
          },
          onStepContinue: () {
            if (c.stepUser.value >= 2) return;
            c.stepUser.value += 1;
          },
          onStepCancel: () {
            if (c.stepUser.value <= 0) return;
            c.stepUser.value -= 1;
          },
          steps: <Step>[
            Step(
              state: _nomeCtr.text.isLengthEqualTo(0) ||
                      _emailCtr.text.isLengthEqualTo(0) ||
                      _senhaCtr.text.isLengthEqualTo(0)
                  ? StepState.indexed
                  : StepState.complete,
              isActive: c.stepUser.value == 0 ||
                  !_nomeCtr.text.isLengthEqualTo(0) ||
                  !_emailCtr.text.isLengthEqualTo(0) ||
                  !_senhaCtr.text.isLengthEqualTo(0),
              title: Text('Dados Pessoais'),
              content: Column(
                children: [
                  SizedBox(height: 10),
                  TextFieldUi(
                    //inputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    controller: _nomeCtr,
                    icon: Ionicons.ios_person,
                    label: "nome completo",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.none,
                    controller: _telCtr,
                    icon: Ionicons.ios_phone_portrait,
                    label: "celular",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.none,
                    controller: _emailCtr,
                    icon: Ionicons.ios_mail,
                    label: "email",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.none,
                    controller: _senhaCtr,
                    icon: Ionicons.ios_lock,
                    label: "senha",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    height: 60,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (dateTime) {
                          _dataNasc = dateTime;
                        }),
                  ),
                ],
              ),
            ),
            Step(
              state: _enderecoCtr.text.isLengthEqualTo(0) ||
                      _enderecoNumCtr.text.isLengthEqualTo(0) ||
                      _enderecoBairroCtr.text.isLengthEqualTo(0) ||
                      _enderecoCidadeCtr.text.isLengthEqualTo(0)
                  ? StepState.indexed
                  : StepState.complete,
              isActive: c.stepUser.value == 1 ||
                  !_enderecoCtr.text.isLengthEqualTo(0) ||
                  !_enderecoBairroCtr.text.isLengthEqualTo(0) ||
                  !_enderecoNumCtr.text.isLengthEqualTo(0) ||
                  !_enderecoCidadeCtr.text.isLengthEqualTo(0),
              title: Text("Endereço"),
              content: Column(
                children: [
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.words,
                    controller: _enderecoCtr,
                    icon: Ionicons.ios_home,
                    label: "Endereço",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.none,
                    controller: _enderecoNumCtr,
                    icon: Ionicons.ios_navigate,
                    label: "numero",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.words,
                    controller: _enderecoBairroCtr,
                    icon: Ionicons.ios_navigate,
                    label: "bairro",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.words,
                    controller: _enderecoCidadeCtr,
                    icon: Ionicons.ios_navigate,
                    label: "cidade",
                    passTrue: false,
                  ),
                ],
              ),
            ),
            Step(
              isActive: c.stepUser.value == 2,
              title: Text("Finalizar"),
              content: Column(
                children: [
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: CupertinoButton(
                      padding: EdgeInsets.all(0),
                      color: Color(corSecundaria2),
                      child: Text("Salvar"),
                      onPressed: _nomeCtr.text.isLengthEqualTo(0) ||
                              _emailCtr.text.isLengthEqualTo(0) ||
                              !_emailCtr.text.contains("@") ||
                              _senhaCtr.text.isLengthEqualTo(0) ||
                              _enderecoCtr.text.isLengthEqualTo(0) ||
                              _enderecoNumCtr.text.isLengthEqualTo(0) ||
                              _enderecoBairroCtr.text.isLengthEqualTo(0) ||
                              _enderecoCidadeCtr.text.isLengthEqualTo(0)
                          ? null
                          : () {
                              c.signUp(
                                userData: {
                                  'tipo': "user",
                                  'nome': _nomeCtr.text,
                                  'email': _emailCtr.text,
                                  'cel': _telCtr.text,
                                  'dataNasc': Timestamp.fromDate(_dataNasc),
                                  'endereco': _enderecoCtr.text,
                                  'enderecoNum': _enderecoNumCtr.text,
                                  'enderecoBairro': _enderecoBairroCtr.text,
                                  'enderecoCidade': _enderecoCidadeCtr.text,
                                  'status': true
                                },
                                pass: _senhaCtr.text,
                                onSucess: () {
                                  Get.to(HomeUi());
                                  Get.snackbar('Sucesso 🎉',
                                      'Aguarde que você será redirecionado',
                                      backgroundColor:
                                          CupertinoColors.systemGreen,
                                      margin: EdgeInsets.all(10),
                                      colorText: Colors.white);
                                },
                                onFail: () {
                                  Get.snackbar('Error 😕',
                                      'Verifique seus dados e tente novamente',
                                      backgroundColor:
                                          CupertinoColors.systemRed,
                                      margin: EdgeInsets.all(10),
                                      colorText: Colors.white);
                                },
                              );
                            },
                    ),
                  )
                ],
              ),
            ),
          ]),
    );
  }
}
