import '../models/user_model.dart';
import '../static/static_data.dart';

class AuthRepository {
  UserModel? _currentUser = StaticData.studentJohn;

  UserModel? get currentUser => _currentUser;

  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (email.contains('admin')) {
      _currentUser = StaticData.adminUser;
    } else if (email.contains('alex') || email.contains('sarah')) {
      _currentUser = StaticData.instructorSarah;
    } else {
      _currentUser = StaticData.studentJohn;
    }
    return _currentUser!;
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  void switchUserRole(String role) {
    if (role == 'admin') {
      _currentUser = StaticData.adminUser;
    } else if (role == 'instructor') {
      _currentUser = StaticData.instructorSarah;
    } else {
      _currentUser = StaticData.studentJohn;
    }
  }
}
