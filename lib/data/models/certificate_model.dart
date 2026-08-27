class CertificateModel {
  final int id;
  final String certificateNumber;
  final String verificationCode;
  final String studentName;
  final String courseTitle;
  final String instructorName;
  final DateTime issuedAt;
  final String qrCodeUrl;

  CertificateModel({
    required this.id,
    required this.certificateNumber,
    required this.verificationCode,
    required this.studentName,
    required this.courseTitle,
    required this.instructorName,
    required this.issuedAt,
    required this.qrCodeUrl,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      id: json['id'] as int,
      certificateNumber: json['certificate_number'] as String,
      verificationCode: json['verification_code'] as String,
      studentName: json['student_name'] as String,
      courseTitle: json['course_title'] as String,
      instructorName: json['instructor_name'] as String,
      issuedAt: json['issued_at'] != null ? DateTime.parse(json['issued_at'] as String) : DateTime.now(),
      qrCodeUrl: json['qr_code_url'] as String? ?? '',
    );
  }
}
