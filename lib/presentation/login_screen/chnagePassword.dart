import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Change Password', style: theme.textTheme.titleLarge!.copyWith(fontSize: 17)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
            vertical: screenHeight * 0.05,
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Change your password",
                    style: theme.textTheme.headlineMedium!.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                  ),
                ),
                SizedBox(height: 30),
                _buildPasswordTextField(
                  label: 'Old Password',
                  controller: oldPasswordController,
                  hintText: 'Enter old password',
                  icon: Icons.password,
                  isPasswordVisible: _isOldPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _isOldPasswordVisible = !_isOldPasswordVisible;
                    });
                  },
                ),
                SizedBox(height: 20),
                _buildPasswordTextField(
                  label: 'New Password',
                  controller: newPasswordController,
                  hintText: 'Enter new password',
                  icon: Icons.password,
                  isPasswordVisible: _isNewPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  },
                ),
                SizedBox(height: 20),
                _buildPasswordTextField(
                  label: 'Retype New Password',
                  controller: confirmPasswordController,
                  hintText: 'Retype new password',
                  icon: Icons.password,
                  isPasswordVisible: _isConfirmPasswordVisible,
                  onVisibilityToggle: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
                SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.60,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle password change logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Change Password',
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isPasswordVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: !isPasswordVisible, // Toggle between obscuring and showing text
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, size: 18),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,size: 18,
              ),
              onPressed: onVisibilityToggle,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
