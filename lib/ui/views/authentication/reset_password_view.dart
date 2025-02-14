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

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _autoValidate = false;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validateForm);
    _confirmPasswordController.removeListener(_validateForm);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _passwordError = FormValidators.validatePassword(_passwordController.text);
      _confirmPasswordError = FormValidators.checkIfPasswordSame(
        _passwordController.text,
        _confirmPasswordController.text,
      );
    });
  }

  void _handleSubmit() {
    setState(() {
      _autoValidate = true;
    });
    
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement password reset API call
      NavigationService.pushReplacementNamed(
        AppRoutes.passwordResetSuccessView,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = _passwordController.text.isNotEmpty && 
        _confirmPasswordController.text.isNotEmpty &&
        _passwordError == null &&
        _confirmPasswordError == null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(isBorder: false),
        centerTitle: true,
        title: Text(
          'Reset Password',
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
                'Create a new password for your account.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              AppSpacing.v32(),
              AppInput(
                labelText: 'New Password',
                controller: _passwordController,
                hintText: 'Enter your new password',
                isRequired: true,
                obscureText: true,
                validator: FormValidators.validatePassword,
                autoValidate: true,
                onChanged: (value) {
                  _validateForm();
                  setState(() {});
                },
                customBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grey100),
                  borderRadius: BorderRadius.circular(12),
                ),
                customBorderRadius: BorderRadius.circular(12),
                customInputColor: AppColors.grey100,
              ),
              AppSpacing.v24(),
              AppInput(
                labelText: 'Confirm Password',
                controller: _confirmPasswordController,
                hintText: 'Re-enter your new password',
                isRequired: true,
                obscureText: true,
                validator: (value) => FormValidators.checkIfPasswordSame(
                  _passwordController.text,
                  value,
                ),
                autoValidate: true,
                onChanged: (value) {
                  _validateForm();
                  setState(() {});
                },
                customBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grey100),
                  borderRadius: BorderRadius.circular(12),
                ),
                customBorderRadius: BorderRadius.circular(12),
                customInputColor: AppColors.grey100,
              ),
              AppSpacing.v32(),
              AppButton(
                text: 'Reset Password',
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