import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolUser {
  String id;

  String instituicao;
  Timestamp dataInicio;
  Timestamp dataFim;
  bool concluido;
  String curso;
  String grau;

  SchoolUser.fromDocument(DocumentSnapshot s) {
    id = s.documentID;
    instituicao = s.data['instituicao'];
    dataInicio = s.data['dataInicio'];
    dataFim = s.data['dataFim'];
    concluido = s.data['concluido'];
    curso = s.data['curso'];
    grau = s.data['grau'];
  }
}
