import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  UserModel? _currentUser;
  bool _loading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _auth.currentUser != null;
  bool get loading => _loading;

  Future<void> loadCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return;
    final doc = await _db.collection('usuarios').doc(user.uid).get();
    if (doc.exists) {
      _currentUser = UserModel.fromMap(doc.id, doc.data()!);
      notifyListeners();
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await loadCurrentUser();
      return null;
    } on FirebaseAuthException catch (e) {
      return _message(e.code);
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> register({
    required String name,
    required String email,
    required String phone,
    required String city,
    required String password,
  }) async {
    try {
      _setLoading(true);
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final uid = credential.user!.uid;
      await _db.collection('usuarios').doc(uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'city': city,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _currentUser = UserModel(id: uid, name: name, email: email, phone: phone, city: city);
      return null;
    } on FirebaseAuthException catch (e) {
      return _message(e.code);
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> forgotPassword(String email) async {
    try {
      _setLoading(true);
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return _message(e.code);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String _message(String code) {
    switch (code) {
      case 'invalid-email': return 'E-mail inválido.';
      case 'user-not-found': return 'Usuário não encontrado.';
      case 'wrong-password': return 'Senha incorreta.';
      case 'email-already-in-use': return 'Este e-mail já está em uso.';
      case 'weak-password': return 'A senha é fraca.';
      default: return 'Erro: $code';
    }
  }
}
