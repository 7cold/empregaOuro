import 'package:cloud_firestore/cloud_firestore.dart';

class WorkUser {
  String id;

  String empresa;
  String cargo;
  Timestamp dataInicio;
  Timestamp dataFim;
  bool atual;

  WorkUser.fromDocument(DocumentSnapshot s) {
    id = s.documentID;
    empresa = s.data['empresa'];
    cargo = s.data['cargo'];
    dataFim = s.data['dataFim'];
    dataInicio = s.data['dataInicio'];
    atual = s.data['atual'];
  }
}
