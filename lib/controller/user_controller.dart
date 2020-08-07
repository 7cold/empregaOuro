import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<FirebaseUser> firebaseUser = Rx<FirebaseUser>();

  @override
  onInit() async {
    await loadCurrentUser();
    super.onInit();
  }

  RxList interesse = [].obs;
  RxMap userData = {}.obs;
  RxBool loading = false.obs;
  RxInt typeService = 0.obs;
  RxInt stepUser = 0.obs;
  RxInt stepEtp = 0.obs;

  //*************************SYSTEM*************************
  changeTypeService(int value) {
    typeService.value = value;
    print(typeService.value);
  }

  changeStepUser(int value) {
    stepUser.value = value;
    print(stepUser.value);
  }

  changeStepEtp(int value) {
    stepEtp.value = value;
    print(stepEtp.value);
  }

  //*************************AUTH*************************

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) {
    loading.value = true;
    update();
    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((result) async {
      firebaseUser.value = result.user;
      await _createUser(userData, firebaseUser.value.uid);
      onSucess();
      loading.value = false;
      update();
    }).catchError((e) {
      onFail();
      loading.value = false;
      update();
    });
  }

  void login(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    loading.value = true;
    update();
    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((result) async {
      firebaseUser.value = result.user;

      await loadCurrentUser();

      onSuccess();
      loading.value = false;
      update();
    }).catchError((e) {
      onFail();
      loading.value = false;
      update();
    });
  }

  void logout() async {
    await _auth.signOut();

    userData = {}.obs;
    firebaseUser.value = null;
    update();
  }

  //*************************DATA BASE*************************

  Future<Null> loadCurrentUser() async {
    if (firebaseUser.value == null)
      firebaseUser.value = await _auth.currentUser();
    if (firebaseUser.value != null) {
      if (userData['nome'] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection('users')
            .document(firebaseUser.value.uid)
            .get();

        userData.value = docUser.data;
        loadInteresse();
      }
      update();
    }
  }

  updateInfo() async {
    DocumentSnapshot docUser = await Firestore.instance
        .collection('users')
        .document(firebaseUser.value.uid)
        .get();
    userData.value = docUser.data;
    update();
  }

  changeStatus(bool value) async {
    await Firestore.instance
        .collection('users')
        .document(firebaseUser.value.uid)
        .updateData({
      'status': value,
    });
    await updateInfo();
    update();
  }

  Future<Null> _createUser(
      Map<String, dynamic> userData, String firebaseUID) async {
    this.userData = userData.obs;
    await Firestore.instance
        .collection('users')
        .document(firebaseUID)
        .setData(userData);
  }

//-------------Exp-------------

  Future<Null> createWork(
      Map<String, dynamic> workMap, String firebaseUID) async {
    await Firestore.instance
        .collection('users')
        .document(firebaseUID)
        .collection('experiencia')
        .document()
        .setData(workMap);
  }

  void removeWork(String firebaseUID, String docID) {
    Firestore.instance
        .collection('users')
        .document(firebaseUID)
        .collection("experiencia")
        .document(docID)
        .delete();
  }

  void changeWork(bool value, String firebaseUID, String docID) async {
    await Firestore.instance
        .collection('users')
        .document(firebaseUID)
        .collection('experiencia')
        .document(docID)
        .updateData({
      'atual': value,
      'dataFim': value == true ? DateTime(1950, 01, 01) : DateTime.now(),
    });
  }

  //-------------Formacao-------------

  Future<Null> createFormacao(
      Map<String, dynamic> formMap, String firebaseUID) async {
    await Firestore.instance
        .collection('users')
        .document(firebaseUID)
        .collection('formacao')
        .document()
        .setData(formMap);
  }

  void removeFormacao(String firebaseUID, String docID) {
    Firestore.instance
        .collection('users')
        .document(firebaseUID)
        .collection("formacao")
        .document(docID)
        .delete();
  }

  void changeFormacao(bool value, String firebaseUID, String docID) async {
    await Firestore.instance
        .collection('users')
        .document(firebaseUID)
        .collection('formacao')
        .document(docID)
        .updateData({
      'concluido': value,
    });
  }
  //-------------Vaga-------------

  Future<Null> createVaga(
      Map<String, dynamic> formMap, String firebaseUID, String setor) async {
    DocumentReference refOrder = await Firestore.instance
        .collection('setores')
        .document(setor)
        .collection('vagas')
        .add(formMap);

    await Firestore.instance
        .collection("users")
        .document(firebaseUID)
        .collection("vagas")
        .document(refOrder.documentID)
        .setData({
      "setor": setor,
      "vagaId": refOrder.documentID,
    });
  }

  Future<void> removeVaga(
      String firebaseUID, String vagaId, String setor) async {
    await Firestore.instance
        .collection('users')
        .document(firebaseUID)
        .collection("vagas")
        .document(vagaId)
        .delete();

    await Firestore.instance
        .collection('setores')
        .document(setor)
        .collection("vagas")
        .document(vagaId)
        .delete();
  }

  void changeVaga(bool value, String vagaId, String setor) async {
    await Firestore.instance
        .collection('setores')
        .document(setor)
        .collection('vagas')
        .document(vagaId)
        .updateData({
      'disponivel': value,
    });
  }

  //-------------interesse-------------

  void loadInteresse() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(firebaseUser.value.uid)
        .collection("interesse")
        .getDocuments();
    interesse.value = query.documents.map((doc) => doc.documentID).toList();
    update();
  }

  void createInteresse(DocumentSnapshot doc) async {
    loading.value = true;
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.value.uid)
        .collection("interesse")
        .document(doc.documentID)
        .setData({
      'vagaId': doc.documentID,
      'empresaId': doc.data['empresaId'],
      'setor': doc.data['setor'],
      'data': Timestamp.fromDate(DateTime.now()),
    });

    await Firestore.instance
        .collection("users")
        .document(doc.data['empresaId'])
        .collection("vagas")
        .document(doc.documentID)
        .collection("interesse")
        .document(firebaseUser.value.uid)
        .setData({
      'userId': firebaseUser.value.uid,
      'vagaId': doc.documentID,
      'setor': doc.data['setor'],
      'data': Timestamp.fromDate(DateTime.now()),
    });
    interesse.add(doc.documentID);
    update();
    loading.value = false;
  }

  void removeInteresse(DocumentSnapshot doc) async {
    loading.value = true;
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.value.uid)
        .collection("interesse")
        .document(doc.documentID)
        .delete();

    await Firestore.instance
        .collection("users")
        .document(doc.data['empresaId'])
        .collection("vagas")
        .document(doc.documentID)
        .collection("interesse")
        .document(firebaseUser.value.uid)
        .delete();

    interesse.remove(doc.documentID);
    loading.value = false;
    update();
  }
}
