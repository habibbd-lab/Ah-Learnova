class EarningsRecordModel {
  final int id;
  final String courseTitle;
  final double orderAmount;
  final double netAmount;
  final double commissionRate;
  final DateTime createdAt;

  EarningsRecordModel({
    required this.id,
    required this.courseTitle,
    required this.orderAmount,
    required this.netAmount,
    this.commissionRate = 0.10,
    required this.createdAt,
  });
}

class WithdrawalModel {
  final int id;
  final double amount;
  final String method;
  final String status; // pending, approved, rejected
  final DateTime createdAt;

  WithdrawalModel({
    required this.id,
    required this.amount,
    required this.method,
    this.status = 'pending',
    required this.createdAt,
  });
}
