import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/shared/widgets/app_button.dart';
import 'package:clixx/shared/widgets/app_input.dart';
import 'package:clixx/shared/widgets/app_back_button.dart';
import 'package:clixx/utils/form_validator.dart';
import 'package:clixx/app/routes/app_routes.dart';
import 'package:clixx/services/navigation_service.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    setState(() {
      _autoValidate = true;
    });
    
    if (_formKey.currentState?.validate() ?? false) {
      NavigationService.pushReplacementNamed(
        AppRoutes.otpVerificationView,
        arguments: {
          'email': _emailController.text,
          'isPasswordReset': true,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = _emailController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(isBorder: false),
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(16.h),
          child: Container(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your email address and we will send you a verification code to reset your password.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              AppSpacing.v32(),
              AppInput(
                labelText: 'Email address',
                controller: _emailController,
                hintText: 'example@email.com',
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                validator: FormValidators.validateEmail,
                autoValidate: true,
                onChanged: (value) => setState(() {}),
                customBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grey100),
                  borderRadius: BorderRadius.circular(12),
                ),
                customBorderRadius: BorderRadius.circular(12),
                customInputColor: AppColors.grey100,
              ),
              AppSpacing.v32(),
              AppButton(
                text: 'Continue',
                onPressed: isFormValid ? _handleSubmit : null,
                backgroundColor: isFormValid ? AppColors.primary : AppColors.primitiveBlue50,
                textColor: Colors.white,
              ),
              AppSpacing.v32(),
            ],
          ),
        ),
      ),
    );
  }
} 