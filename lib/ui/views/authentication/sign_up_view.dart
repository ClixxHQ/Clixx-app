import 'package:clixx/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/ui/widgets/calendar_bottom_sheet.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/shared/widgets/app_button.dart';
import 'package:clixx/shared/widgets/app_input.dart';
import 'package:clixx/shared/widgets/app_phone_input.dart';
import 'package:clixx/shared/app_icons.dart';
import 'package:clixx/app/routes/app_routes.dart';
import 'package:clixx/shared/widgets/app_back_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  DateTime? _selectedDate;
  bool _termsAccepted = false;
  String? _phoneNumber;
  String? _countryCode;
  bool _autoValidate = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _referralController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showCalendarPicker() {
    CalendarBottomSheet.show(
      selectedDate: _selectedDate,
      onDateSelected: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
    );
  }

  void _handleSubmit() {
    setState(() {
      _autoValidate = true;
    });
    
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushNamed(
        AppRoutes.otpVerificationView,
        arguments: {
          'phoneNumber': _phoneNumber,
          'email': _emailController.text,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'password': _passwordController.text,
          'birthday': _selectedDate,
          'referralCode': _referralController.text,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(isBorder: false),
        centerTitle: true,
        title: Text(
          'Create your account',
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
                'It will only take a minute to create you account.\nPlease enter your details to get started',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              AppSpacing.v32(),
              AppPhoneInput(
                controller: _phoneController,
                labelText: 'Phone number',
                isRequired: true,
                validator: FormValidators.validatePhoneNumber,
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
              ),
              AppSpacing.v24(),
              AppInput(
                labelText: 'Email address',
                controller: _emailController,
                hintText: 'example@email.com',
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                validator: FormValidators.validateEmail,
                autoValidate: true,
              ),
              AppSpacing.v24(),
              Row(
                children: [
                  Expanded(
                    child: AppInput(
                      labelText: 'First name',
                      controller: _firstNameController,
                      hintText: 'e.g Sam',
                      isRequired: true,
                      validator: FormValidators.validateName,
                      autoValidate: true,
                    ),
                  ),
                  AppSpacing.h16(),
                  Expanded(
                    child: AppInput(
                      labelText: 'Last name',
                      controller: _lastNameController,
                      hintText: 'e.g Smith',
                      isRequired: true,
                      validator: FormValidators.validateName,
                      autoValidate: true,
                    ),
                  ),
                ],
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
                hintText: 'Re-enter your password',
                isRequired: true,
                obscureText: true,
                validator: (value) => FormValidators.checkIfPasswordSame(
                  _passwordController.text,
                  value,
                ),
                autoValidate: true,
                customBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grey100),
                  borderRadius: BorderRadius.circular(12),
                ),
                customBorderRadius: BorderRadius.circular(12),
                customInputColor: AppColors.grey100,
              ),
              AppSpacing.v24(),
              Text(
                'Birthday',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              AppSpacing.v8(),
              InkWell(
                onTap: _showCalendarPicker,
                child: Container(
                  height: 56.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _selectedDate != null
                            ? DateFormat('MMMM d yyyy').format(_selectedDate!)
                            : 'Select birth month and day',
                        style: TextStyle(
                          color: _selectedDate != null
                              ? Colors.black                              : Colors.black54,
                          fontSize: 14.sp,
                        ),
                      ),
                      const Spacer(),
                      AppIcons(
                        icon: AppIconData.calendar,
                        size: 20.w,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.v24(),
              AppInput(
                labelText: 'Referral code',
                controller: _referralController,
                hintText: 'Enter a referral code',
                isRequired: false,
              ),
              AppSpacing.v24(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Transform.scale(
                      scale: 1.0,
                      child: SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: Checkbox(
                          value: _termsAccepted,
                          onChanged: (value) {
                            setState(() {
                              _termsAccepted = value ?? false;
                            });
                          },
                          shape: const CircleBorder(),
                          side: BorderSide(width: 1.w),
                          activeColor: Colors.green,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        children: const [
                          TextSpan(
                            text: 'I confirm that I have read, consented and agree to Clixx ',
                          ),
                          TextSpan(
                            text: 'Terms of Use',
                            style: TextStyle(
                              color: AppColors.primary,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppColors.primary,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.v24(),
              AppButton(
                text: 'Continue',
                onPressed: _termsAccepted ? _handleSubmit : null,
                backgroundColor: _termsAccepted ? AppColors.primary : AppColors.primitiveBlue50,
              ),
              AppSpacing.v32(),
            ],
          ),
        ),
      ),
    );
  }
}