class UserModel {
  final int id;
  final String name;
  final String email;
  final String role; // student, instructor, admin
  final String? headline;
  final String? bio;
  final String? avatarUrl;
  final String status; // active, pending, suspended
  final double totalEarnings;
  final double currentBalance;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.headline,
    this.bio,
    this.avatarUrl,
    this.status = 'active',
    this.totalEarnings = 0.0,
    this.currentBalance = 0.0,
  });

  bool get isAdmin => role == 'admin';
  bool get isInstructor => role == 'instructor';
  bool get isStudent => role == 'student';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      headline: json['headline'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      status: json['status'] as String? ?? 'active',
      totalEarnings: (json['total_earnings'] as num?)?.toDouble() ?? 0.0,
      currentBalance: (json['current_balance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'headline': headline,
      'bio': bio,
      'avatar_url': avatarUrl,
      'status': status,
      'total_earnings': totalEarnings,
      'current_balance': currentBalance,
    };
  }
}
