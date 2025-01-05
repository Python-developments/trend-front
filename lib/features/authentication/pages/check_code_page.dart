import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/authentication/providers/auth_controller.dart';
import 'package:trend/features/authentication/widgets/custom_button.dart';
import 'package:trend/features/authentication/widgets/custom_textfield.dart';
import 'package:trend/utils/validation.dart';
import 'package:trend/utils/widgets/labeled_widget.dart';

class CheckCodePage extends StatefulWidget {
  const CheckCodePage({super.key});

  @override
  State<CheckCodePage> createState() => _CheckCodePageState();
}

class _CheckCodePageState extends State<CheckCodePage> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Forget password"),
      ),
      body: _buildFormWidget(context),
    );
  }

  SingleChildScrollView _buildFormWidget(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15.sp),
      child: Container(
        constraints: BoxConstraints(maxWidth: 500.sp),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Please check your mail inbox for confirmation code",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).textTheme.displayLarge!.color),
              ),
              SizedBox(height: 10.sp),
              LabeledWidget(
                title: "Email",
                child: Text(
                  Get.arguments ?? '',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color),
                ),
              ),
              SizedBox(height: 20.sp),
              CustomTextfield(
                name: "Code",
                isPassword: false,
                controller: _codeController,
                validator: (value) =>
                    Validation.validateMandatoryField(value, context),
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

      Get.find<AuthController>().checkCode();
    }
  }
}
