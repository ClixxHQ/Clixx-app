import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/shared/app_icons.dart';
import 'package:clixx/shared/widgets/app_button.dart';
import 'package:clixx/shared/widgets/app_input.dart';
import 'package:clixx/utils/form_validator.dart';
import 'package:clixx/services/navigation_service.dart';
import 'package:clixx/app/routes/app_routes.dart';

class SetupProfileView extends StatefulWidget {
  const SetupProfileView({Key? key}) : super(key: key);

  @override
  State<SetupProfileView> createState() => _SetupProfileViewState();
}

class _SetupProfileViewState extends State<SetupProfileView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _autoValidate = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    setState(() {
      _autoValidate = true;
    });
    
    if (_formKey.currentState?.validate() ?? false) {
      NavigationService.pushReplacementNamed(AppRoutes.homeView);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = _usernameController.text.isNotEmpty && _bioController.text.isNotEmpty;

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
                  'Setup your Profile',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.v8(),
                Text(
                  'Tell us about yourself to get started.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.v48(),
                Stack(
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey100,
                        border: Border.all(
                          color: AppColors.primitiveBlue400,
                          width: 2.w,
                        ),
                      ),
                      child: Center(
                        child: AppIcons(
                          icon: AppIconData.user1,
                          size: 38.w,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: AppIcons(
                        icon: AppIconData.add,
                        size: 28.w,
                      ),
                    ),
                  ],
                ),
                AppSpacing.v32(),
                AppInput(
                  labelText: 'Username',
                  controller: _usernameController,
                  hintText: 'Enter your username',
                  isRequired: true,
                  validator: FormValidators.validateRequired,
                  autoValidate: true,
                  onChanged: (value) => setState(() {}),
                ),
                AppSpacing.v24(),
                AppInput(
                  labelText: 'Bio',
                  controller: _bioController,
                  hintText: 'Tell us about yourself',
                  isRequired: true,
                  validator: FormValidators.validateRequired,
                  autoValidate: true,
                  maxLines: 3,
                  onChanged: (value) => setState(() {}),
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
      ),
    );
  }
} 