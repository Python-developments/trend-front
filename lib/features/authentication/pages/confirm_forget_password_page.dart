import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/authentication/providers/auth_controller.dart';
import 'package:trend/features/authentication/widgets/custom_button.dart';
import 'package:trend/features/authentication/widgets/custom_textfield.dart';
import 'package:trend/utils/validation.dart';

class ConfirmForgetPasswordPage extends StatefulWidget {
  const ConfirmForgetPasswordPage({
    super.key,
  });

  @override
  State<ConfirmForgetPasswordPage> createState() =>
      _ConfirmForgetPasswordPageState();
}

class _ConfirmForgetPasswordPageState extends State<ConfirmForgetPasswordPage> {
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Change password"),
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Container(
      constraints: BoxConstraints(maxWidth: 600.sp),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(15.sp),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextfield(
                name: "New password",
                isPassword: true,
                controller: _passwordController,
                validator: (value) =>
                    Validation.validatePassword(value, context),
              ),
              SizedBox(height: 10.sp),
              CustomTextfield(
                name: "Confirm password",
                controller: _password2Controller,
                isPassword: true,
                validator: (value) => Validation.validateConfirmedPassword(
                    _passwordController.text.trim(), value, context),
              ),
              SizedBox(height: 30.sp),
              SizedBox(
                width: Get.width,
                child: CustomButton(
                  text: 'Submit',
                  onPressed: _onSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      if (!Get.isRegistered<AuthController>()) {
        Get.put<AuthController>(AuthController());
      }
      Get.find<AuthController>().changePassword();
    }
  }
}
