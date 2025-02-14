import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/shared/app_icons.dart';
import 'package:clixx/shared/widgets/app_button.dart';
import 'package:clixx/shared/widgets/app_input.dart';
import 'package:clixx/utils/form_validator.dart';
import 'package:clixx/app/routes/app_routes.dart';
import 'package:clixx/services/navigation_service.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _autoValidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    setState(() {
      _autoValidate = true;
    });
    
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Handle sign in
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppSpacing.v32(),
                Text(
                  'Clixx',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                AppSpacing.v8(),
                Text(
                  'Welcome! Log in to continue',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
                AppSpacing.v32(),
                AppInput(
                  labelText: 'Email address',
                  controller: _emailController,
                  hintText: 'enter your email address',
                  keyboardType: TextInputType.emailAddress,
                  isRequired: true,
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
                AppSpacing.v24(),
                AppInput(
                  labelText: 'Password',
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  isRequired: true,
                  obscureText: true,
                  validator: FormValidators.validatePassword,
                  autoValidate: true,
                  onChanged: (value) => setState(() {}),
                  customBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.grey100),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  customBorderRadius: BorderRadius.circular(12),
                  customInputColor: AppColors.grey100,
                ),
                AppSpacing.v24(),
                AppButton(
                  text: 'Log in',
                  onPressed: isFormValid ? _handleSubmit : null,
                  backgroundColor: isFormValid ? AppColors.primary : AppColors.primitiveBlue50,
                  textColor: Colors.white,
                ),
                AppSpacing.v16(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => NavigationService.pushNamed(
                        AppRoutes.signUpView,
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        NavigationService.pushReplacementNamed(
                          AppRoutes.forgotPasswordView,
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.v24(),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: AppColors.grey500,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey500,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: AppColors.grey500,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                AppSpacing.v24(),
                OutlinedButton(
                  onPressed: () {
                    // TODO: Handle Google sign in
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcons(
                        icon: AppIconData.google,
                        size: 24.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Login With Google',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.v16(),
                OutlinedButton(
                  onPressed: () {
                    // TODO: Handle Apple sign in
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcons(
                        icon: AppIconData.apple,
                        size: 24.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Login With Apple',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.v32(),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 