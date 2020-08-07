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
class ItemEnterpriseSignUp extends StatelessWidget {
  final UserController c = Get.put(UserController());
  //User
  final TextEditingController _nomeEtpCtr = TextEditingController();
  final TextEditingController _setorEtpCtr = TextEditingController();
  final TextEditingController _enderecoEtpCtr = TextEditingController();
  final TextEditingController _enderecoNumEtpCtr = TextEditingController();
  final TextEditingController _enderecoBairroEtpCtr = TextEditingController();
  final TextEditingController _enderecoCidadeEtpCtr = TextEditingController();
  var _telEtpCtr = MaskedTextController(mask: '(00) 00000-0000');
  final TextEditingController _emailEtpCtr = TextEditingController();
  final TextEditingController _senhaEtpCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stepper(
          onStepTapped: (i) {
            c.changeStepEtp(i);
          },
          physics: BouncingScrollPhysics(),
          currentStep: c.stepEtp.value,
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                c.stepEtp.value != 3
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
                c.stepEtp.value <= 2
                    ? Container(
                        margin: EdgeInsets.only(right: 10, top: 20),
                        height: 30,
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          color: CupertinoColors.systemGrey2,
                          onPressed: c.stepEtp.value == 0 ? null : onStepCancel,
                          child: const Text('Voltar'),
                        ),
                      )
                    : SizedBox(),
              ],
            );
          },
          onStepContinue: () {
            if (c.stepEtp.value >= 3) return;
            c.stepEtp.value += 1;
          },
          onStepCancel: () {
            if (c.stepEtp.value <= 0) return;
            c.stepEtp.value -= 1;
          },
          steps: <Step>[
            Step(
              state: _emailEtpCtr.text.isLengthEqualTo(0) ||
                      _senhaEtpCtr.text.isLengthEqualTo(0)
                  ? StepState.indexed
                  : StepState.complete,
              isActive: c.stepEtp.value == 0 ||
                  !_emailEtpCtr.text.isLengthEqualTo(0) ||
                  !_senhaEtpCtr.text.isLengthEqualTo(0),
              title: Text('Dados para login'),
              content: Column(
                children: [
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.none,
                    controller: _emailEtpCtr,
                    icon: Ionicons.ios_mail,
                    label: "email",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.none,
                    controller: _senhaEtpCtr,
                    icon: Ionicons.ios_lock,
                    label: "senha",
                    passTrue: false,
                  ),
                ],
              ),
            ),
            Step(
              state: _nomeEtpCtr.text.isLengthEqualTo(0) ||
                      _telEtpCtr.text.isLengthEqualTo(0) ||
                      _setorEtpCtr.text.isLengthEqualTo(0)
                  ? StepState.indexed
                  : StepState.complete,
              isActive: c.stepEtp.value == 1 ||
                  !_nomeEtpCtr.text.isLengthEqualTo(0) ||
                  !_telEtpCtr.text.isLengthEqualTo(0) ||
                  !_setorEtpCtr.text.isLengthEqualTo(0),
              title: Text('Dados para contato'),
              content: Column(
                children: [
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.words,
                    controller: _nomeEtpCtr,
                    icon: Ionicons.ios_person,
                    label: "nome da empresa",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.none,
                    controller: _telEtpCtr,
                    icon: Ionicons.ios_phone_portrait,
                    label: "telefone",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.none,
                    controller: _setorEtpCtr,
                    icon: Ionicons.ios_list_box,
                    label: "setor de atuação",
                    passTrue: false,
                  ),
                ],
              ),
            ),
            Step(
              state: _enderecoEtpCtr.text.isLengthEqualTo(0) ||
                      _enderecoNumEtpCtr.text.isLengthEqualTo(0) ||
                      _enderecoBairroEtpCtr.text.isLengthEqualTo(0) ||
                      _enderecoCidadeEtpCtr.text.isLengthEqualTo(0)
                  ? StepState.indexed
                  : StepState.complete,
              isActive: c.stepEtp.value == 2 ||
                  !_enderecoEtpCtr.text.isLengthEqualTo(0) ||
                  !_enderecoNumEtpCtr.text.isLengthEqualTo(0) ||
                  !_enderecoBairroEtpCtr.text.isLengthEqualTo(0) ||
                  !_enderecoCidadeEtpCtr.text.isLengthEqualTo(0),
              title: Text("Endereço"),
              content: Column(
                children: [
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.words,
                    controller: _enderecoEtpCtr,
                    icon: Ionicons.ios_home,
                    label: "Endereço",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.none,
                    controller: _enderecoNumEtpCtr,
                    icon: Ionicons.ios_navigate,
                    label: "numero",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.words,
                    controller: _enderecoBairroEtpCtr,
                    icon: Ionicons.ios_navigate,
                    label: "bairro",
                    passTrue: false,
                  ),
                  SizedBox(height: 10),
                  TextFieldUi(
                    textCapitalization: TextCapitalization.words,
                    controller: _enderecoCidadeEtpCtr,
                    icon: Ionicons.ios_navigate,
                    label: "cidade",
                    passTrue: false,
                  ),
                ],
              ),
            ),
            Step(
              isActive: c.stepEtp.value == 3,
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
                      onPressed: _nomeEtpCtr.text.isLengthEqualTo(0) ||
                              _emailEtpCtr.text.isLengthEqualTo(0) ||
                              _senhaEtpCtr.text.isLengthEqualTo(0) ||
                              _setorEtpCtr.text.isLengthEqualTo(0) ||
                              _telEtpCtr.text.isLengthEqualTo(0) ||
                              _enderecoEtpCtr.text.isLengthEqualTo(0) ||
                              _enderecoNumEtpCtr.text.isLengthEqualTo(0) ||
                              _enderecoBairroEtpCtr.text.isLengthEqualTo(0) ||
                              _enderecoCidadeEtpCtr.text.isLengthEqualTo(0)
                          ? null
                          : () {
                              c.signUp(
                                userData: {
                                  'tipo': "enterprise",
                                  'nome': _nomeEtpCtr.text,
                                  'email': _emailEtpCtr.text,
                                  'cel': _telEtpCtr.text,
                                  'setor': _setorEtpCtr.text,
                                  'endereco': _enderecoEtpCtr.text,
                                  'enderecoNum': _enderecoNumEtpCtr.text,
                                  'enderecoBairro': _enderecoBairroEtpCtr.text,
                                  'enderecoCidade': _enderecoCidadeEtpCtr.text,
                                },
                                pass: _senhaEtpCtr.text,
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
