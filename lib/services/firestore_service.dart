import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/goal_model.dart';
import '../models/transaction_model.dart';
import '../models/budget_model.dart';
import '../models/category_model.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  final _db = FirebaseFirestore.instance;
  String get uid => FirebaseAuth.instance.currentUser!.uid;

  Stream<List<TransactionModel>> streamTransactions() {
    return _db
        .collection('transactions')
        .where('userId', isEqualTo: uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map((s) => s.docs.map(TransactionModel.fromDoc).toList());
  }

  Stream<List<GoalModel>> streamGoals() {
    return _db
        .collection('goals')
        .where('userId', isEqualTo: uid)
        .orderBy('deadline')
        .snapshots()
        .map((s) => s.docs.map(GoalModel.fromDoc).toList());
  }

  Stream<List<BudgetModel>> streamBudgets() {
    return _db
        .collection('budgets')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((s) => s.docs
            .map((doc) => BudgetModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  Stream<List<CategoryModel>> streamCategories() {
    return _db
        .collection('categories')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((s) => s.docs
            .map((doc) => CategoryModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<void> addTransaction(TransactionModel item) async {
    await _db.collection('transactions').add({
      ...item.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTransaction(TransactionModel item) async {
    await _db.collection('transactions').doc(item.id).update(item.toMap());
  }

  Future<void> deleteTransaction(String id) async {
    await _db.collection('transactions').doc(id).delete();
  }

  Future<void> addGoal(GoalModel item) async {
    await _db.collection('goals').add({
      ...item.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateGoal(GoalModel item) async {
    await _db.collection('goals').doc(item.id).update(item.toMap());
  }

  Future<void> deleteGoal(String id) async {
    await _db.collection('goals').doc(id).delete();
  }

  Future<void> addBudget(BudgetModel item) async {
    await _db.collection('budgets').add({
      ...item.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateBudget(BudgetModel item) async {
    await _db.collection('budgets').doc(item.id).update(item.toMap());
  }

  Future<void> deleteBudget(String id) async {
    await _db.collection('budgets').doc(id).delete();
  }

  Future<void> addCategory(CategoryModel item) async {
    await _db.collection('categories').add({
      ...item.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateCategory(CategoryModel item) async {
    await _db.collection('categories').doc(item.id).update(item.toMap());
  }

  Future<void> deleteCategory(String id) async {
    await _db.collection('categories').doc(id).delete();
  }

  Future<List<TransactionModel>> searchTransactions({
    required String term,
    required String orderBy,
  }) async {
    final normalized = term.trim().toLowerCase();

    Query<Map<String, dynamic>> query = _db
        .collection('transactions')
        .where('userId', isEqualTo: uid);

    if (normalized.isNotEmpty) {
      query = query
          .where('titleLower', isGreaterThanOrEqualTo: normalized)
          .where('titleLower', isLessThan: '$normalized\uf8ff');
    }

    query = query.orderBy(
      normalized.isEmpty ? orderBy : 'titleLower',
      descending: orderBy == 'date',
    );

    final result = await query.get();
    var list = result.docs.map(TransactionModel.fromDoc).toList();

    if (orderBy == 'amount') {
      list.sort((a, b) => b.amount.compareTo(a.amount));
    }

    return list;
  }
}