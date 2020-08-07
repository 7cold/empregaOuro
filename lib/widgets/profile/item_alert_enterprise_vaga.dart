import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/widgets/system/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

alertAddItemVaga(BuildContext context) {
  UserController c = Get.put(UserController());

  TextEditingController cargo = TextEditingController();
  TextEditingController expediente = TextEditingController();
  TextEditingController atividades = TextEditingController();
  var salarioMasked = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
  TextEditingController grau = TextEditingController();
  TextEditingController setor = TextEditingController();
  TextEditingController beneficiosAdd = TextEditingController();
  RxList beneficios = [].obs;
  RxBool disponivel = false.obs;

  _bottomShowExpediente() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Escolha o Tipo'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Tempo Integral'),
            onPressed: () {
              expediente.text = "Tempo Integral";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Meio Período'),
            onPressed: () {
              expediente.text = "Meio Período";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Temporário'),
            onPressed: () {
              expediente.text = "Temporário";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Estágio'),
            onPressed: () {
              expediente.text = "Estágio";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Voluntário'),
            onPressed: () {
              expediente.text = "Voluntário";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('PJ'),
            onPressed: () {
              expediente.text = "PJ";
              Get.back();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Outro'),
            onPressed: () {
              expediente.text = "Outro";
              Get.back();
            },
          ),
        ],
      ),
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

  _bottomShowSetor() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('setores').getDocuments(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CupertinoActionSheetAction(
                child: CupertinoActivityIndicator(),
                onPressed: () {
                  Get.back();
                },
              );
            default:
              return CupertinoActionSheet(
                title: const Text('Escolha o Tipo'),
                actions: snapshot.data.documents.map((res) {
                  return CupertinoActionSheetAction(
                    child: Text(res['nome']),
                    onPressed: () {
                      setor.text = res.documentID;
                      Get.back();
                    },
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }

  showDialog(
    context: context,
    child: AlertDialog(
      title: Text(
        "Nova Vaga",
      ),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: 300,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFieldUi(
                passTrue: false,
                icon: null,
                textCapitalization: TextCapitalization.words,
                onChanged: null,
                inputType: null,
                label: "vaga",
                controller: cargo,
              ),
              SizedBox(height: 5),
              TextFieldUi(
                passTrue: false,
                icon: null,
                textCapitalization: TextCapitalization.words,
                onChanged: null,
                inputType: null,
                label: "salario",
                controller: salarioMasked,
              ),
              SizedBox(height: 5),
              TextFieldUi(
                onTap: () => _bottomShowExpediente(),
                readOnly: true,
                passTrue: false,
                icon: null,
                textCapitalization: TextCapitalization.words,
                onChanged: null,
                inputType: null,
                label: "expediente",
                controller: expediente,
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
                label: "grau necessário",
                controller: grau,
              ),
              SizedBox(height: 5),
              TextFieldUi(
                onTap: () => _bottomShowSetor(),
                readOnly: true,
                passTrue: false,
                icon: null,
                textCapitalization: TextCapitalization.words,
                onChanged: null,
                inputType: null,
                label: "setor",
                controller: setor,
              ),
              SizedBox(height: 5),
              TextFieldUi(
                passTrue: false,
                icon: null,
                textCapitalization: TextCapitalization.words,
                onChanged: null,
                inputType: null,
                label: "atividade a realizar",
                controller: atividades,
                maxLines: 5,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text("Disponível: "),
                  Transform.scale(
                    scale: 0.7,
                    child: Obx(
                      () => CupertinoSwitch(
                        value: disponivel.value,
                        onChanged: (bool value) {
                          disponivel.value = value;
                        },
                      ),
                    ),
                  )
                ],
              ),
              Divider(),
              SizedBox(height: 5),
              TextFieldUi(
                icon: null,
                passTrue: false,
                textCapitalization: TextCapitalization.words,
                sufixIcon: IconButton(
                    icon: Icon(CupertinoIcons.add),
                    onPressed: () {
                      beneficios.add(beneficiosAdd.text);
                      beneficiosAdd.clear();
                    }),
                onSubmitted: (text) {
                  beneficios.add(beneficiosAdd.text);
                  beneficiosAdd.clear();
                },
                label: "add benefícios",
                controller: beneficiosAdd,
              ),
              SizedBox(height: 5),
              Obx(
                () => Wrap(
                    children: beneficios.value
                        .map(
                          (doc) => Padding(
                            padding:
                                EdgeInsets.only(left: 8, top: 2, bottom: 2),
                            child: GestureDetector(
                              onTap: () {
                                beneficios.remove(doc);
                              },
                              child: Chip(
                                labelStyle: fontRegular16Branco,
                                backgroundColor: CupertinoColors.systemGrey2,
                                label: Text(doc),
                              ),
                            ),
                          ),
                        )
                        .toList()),
              ),
              Divider(),
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
                        c.createVaga({
                          'cargo': cargo.text,
                          'disponivel': disponivel.value,
                          'salario': salarioMasked.numberValue,
                          'expediente': expediente.text,
                          'grau': grau.text,
                          'setor': setor.text,
                          'beneficios': beneficios.value,
                          'atividades': atividades.text,
                          'empresaId': c.firebaseUser.value.uid,
                          'data': Timestamp.fromDate(DateTime.now()),
                        }, c.firebaseUser.value.uid, setor.text).then(
                          (value) {
                            Get.back();
                            Get.snackbar('Sucesso 🎉',
                                'Formação adicionada com sucesso!',
                                backgroundColor: CupertinoColors.systemGreen,
                                margin: EdgeInsets.all(10),
                                colorText: Colors.white);
                          },
                        ).catchError(
                          (e) {
                            Get.back();
                            Get.snackbar('Error 😕',
                                'Verifique seus dados e tente novamente',
                                backgroundColor: CupertinoColors.systemRed,
                                margin: EdgeInsets.all(10),
                                colorText: Colors.white);
                          },
                        );
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
  );
}
