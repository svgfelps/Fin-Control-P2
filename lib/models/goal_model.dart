import 'package:cloud_firestore/cloud_firestore.dart';

class GoalModel {
  final String id;
  final String title;
  final double targetAmount;
  final double currentAmount;
  final DateTime deadline;
  final String priority;
  final String userId;

  GoalModel({
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.currentAmount,
    required this.deadline,
    required this.priority,
    required this.userId,
  });

  factory GoalModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return GoalModel(
      id: doc.id,
      title: data['title'] ?? '',
      targetAmount: (data['targetAmount'] ?? 0).toDouble(),
      currentAmount: (data['currentAmount'] ?? 0).toDouble(),
      deadline: (data['deadline'] as Timestamp?)?.toDate() ?? DateTime.now(),
      priority: data['priority'] ?? 'Média',
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'titleLower': title.toLowerCase(),
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'deadline': Timestamp.fromDate(deadline),
      'priority': priority,
      'userId': userId,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
