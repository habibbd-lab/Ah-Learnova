import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../main_nav/main_nav_controller.dart';
import 'auth_controller.dart';

class ProfileView extends GetView<AuthController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Account & Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          final user = controller.currentUser.value;
          if (user == null) {
            return Center(
              child: Column(
                children: [
                  const Text('Please sign in to access your profile.'),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Sign In',
                    width: 160,
                    onPressed: () => Get.toNamed('/auth/login'),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // User Info Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(
                        user.avatarUrl ?? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primarySubtle,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  user.role.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(user.email, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
                          if (user.headline != null) ...[
                            const SizedBox(height: 4),
                            Text(user.headline!, style: const TextStyle(color: AppColors.primaryDark, fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Role Switcher / Demo Controls
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Switch Active Role (Demo)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildRoleButton('Student', 'student', user.role),
                        const SizedBox(width: 8),
                        _buildRoleButton('Instructor', 'instructor', user.role),
                        const SizedBox(width: 8),
                        _buildRoleButton('Admin', 'admin', user.role),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Portal Links
              if (user.isAdmin) ...[
                _buildPortalTile(
                  title: 'Admin Control Center',
                  subtitle: 'Course moderation, instructor approvals, metrics',
                  icon: Icons.admin_panel_settings,
                  color: AppColors.danger,
                  onTap: () => Get.toNamed('/admin/dashboard'),
                ),
                const SizedBox(height: 12),
              ],
              if (user.isInstructor || user.isAdmin) ...[
                _buildPortalTile(
                  title: 'Instructor Studio',
                  subtitle: 'Manage courses, build curriculum, payouts & analytics',
                  icon: Icons.video_library_rounded,
                  color: AppColors.primary,
                  onTap: () => Get.toNamed('/instructor/dashboard'),
                ),
                const SizedBox(height: 12),
              ],

              _buildPortalTile(
                title: 'My Enrolled Courses',
                subtitle: 'Active masterclasses, progress & certifications',
                icon: Icons.school_rounded,
                color: AppColors.info,
                onTap: () => Get.toNamed('/learning'),
              ),
              const SizedBox(height: 12),

              _buildPortalTile(
                title: 'Earned Certificates',
                subtitle: 'View, verify, and download credentials',
                icon: Icons.workspace_premium_rounded,
                color: AppColors.warning,
                onTap: () => Get.toNamed('/certificates'),
              ),
              const SizedBox(height: 12),

              _buildPortalTile(
                title: 'Notifications',
                subtitle: 'Course updates, grades & transactions',
                icon: Icons.notifications_outlined,
                color: AppColors.secondary,
                onTap: () => Get.toNamed('/notifications'),
              ),
              const SizedBox(height: 24),

              // Sign Out
              CustomButton(
                text: 'Sign Out',
                isOutlined: true,
                backgroundColor: AppColors.danger,
                textColor: AppColors.danger,
                icon: Icons.logout,
                onPressed: controller.logout,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildRoleButton(String label, String role, String currentRole) {
    final isSelected = role == currentRole;
    return Expanded(
      child: OutlinedButton(
        onPressed: () => controller.switchRole(role),
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primary : Colors.transparent,
          foregroundColor: isSelected ? Colors.white : AppColors.textDark,
          side: BorderSide(color: isSelected ? AppColors.primary : AppColors.borderLight),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPortalTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderLight),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
      ),
    );
  }
}
