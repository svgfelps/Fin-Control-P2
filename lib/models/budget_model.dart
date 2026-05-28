class BudgetModel {
  String? id;
  String name;
  double limitAmount;
  double spentAmount;
  String month;
  String userId;

  BudgetModel({
    this.id,
    required this.name,
    required this.limitAmount,
    required this.spentAmount,
    required this.month,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'limitAmount': limitAmount,
      'spentAmount': spentAmount,
      'month': month,
      'userId': userId,
    };
  }

  factory BudgetModel.fromMap(
    String id,
    Map<String, dynamic> data,
  ) {
    return BudgetModel(
      id: id,
      name: data['name'] ?? '',
      limitAmount:
          (data['limitAmount'] ?? 0)
              .toDouble(),

      spentAmount:
          (data['spentAmount'] ?? 0)
              .toDouble(),

      month: data['month'] ?? '',
      userId: data['userId'] ?? '',
    );
  }
}