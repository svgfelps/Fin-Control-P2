import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final String type;
  final String description;
  final String userId;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    required this.description,
    required this.userId,
  });

  factory TransactionModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return TransactionModel(
      id: doc.id,
      title: data['title'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      category: data['category'] ?? '',
      type: data['type'] ?? 'expense',
      description: data['description'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'titleLower': title.toLowerCase(),
      'amount': amount,
      'date': Timestamp.fromDate(date),
      'category': category,
      'type': type,
      'description': description,
      'userId': userId,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
