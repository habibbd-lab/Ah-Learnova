import 'course_model.dart';

class OrderItemModel {
  final int id;
  final int courseId;
  final CourseModel? course;
  final double price;

  OrderItemModel({
    required this.id,
    required this.courseId,
    this.course,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as int,
      courseId: json['course_id'] as int? ?? 1,
      course: json['course'] != null ? CourseModel.fromJson(json['course'] as Map<String, dynamic>) : null,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class OrderModel {
  final int id;
  final String orderNumber;
  final double subtotal;
  final double discountAmount;
  final double totalAmount;
  final String paymentStatus; // paid, pending, failed
  final String? paymentMethod;
  final DateTime createdAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.subtotal,
    this.discountAmount = 0.0,
    required this.totalAmount,
    this.paymentStatus = 'paid',
    this.paymentMethod = 'card',
    required this.createdAt,
    this.items = const [],
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      orderNumber: json['order_number'] as String,
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discount_amount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      paymentStatus: json['payment_status'] as String? ?? 'paid',
      paymentMethod: json['payment_method'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : DateTime.now(),
      items: (json['items'] as List<dynamic>?)?.map((i) => OrderItemModel.fromJson(i as Map<String, dynamic>)).toList() ?? [],
    );
  }
}
