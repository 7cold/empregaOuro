import 'package:cloud_firestore/cloud_firestore.dart';

class EnterpriseVagaData {
  String id;

  String cargo;
  double salario;
  String expediente;
  String grau;
  Timestamp data;
  bool disponivel;
  List beneficios;
  String atividades;
  String empresaId;

  EnterpriseVagaData.fromDocument(DocumentSnapshot s) {
    id = s.documentID;
    cargo = s.data['cargo'];
    salario = s.data['salario'] + 0.0;
    expediente = s.data['expediente'];
    grau = s.data['grau'];
    data = s.data['data'];
    disponivel = s.data['disponivel'];
    beneficios = s.data['beneficios'];
    atividades = s.data['atividades'];
    empresaId = s.data['empresaId'];
  }
}
