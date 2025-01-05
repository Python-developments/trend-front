import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/authentication/providers/auth_controller.dart';
import 'package:trend/features/authentication/widgets/custom_button.dart';
import 'package:trend/features/authentication/widgets/custom_textfield.dart';
import 'package:trend/utils/validation.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});
  TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Check if the keyboard is open
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 270.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Align with LoginPage
                        SizedBox(height: 200.h),

                        SizedBox(height: 30.h),
                        Text(
                          'Reset Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        CustomTextfield(
                          name: 'Email Address',
                          isPassword: false,
                          controller: _emailController,
                          validator: (value) =>
                              Validation.validateEmail(value, context),
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: Get.width,
                          child: CustomButton(
                            text: 'Send Reset Link',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Get.find<AuthController>()
                                    .resetPassword(_emailController.text);
                              } else {
                                // If validation fails
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fix the errors')),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
              // Hide "Back to Login" when the keyboard is open
              if (!isKeyboardOpen)
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      // Navigate back to Login Page
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (!isKeyboardOpen) SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
