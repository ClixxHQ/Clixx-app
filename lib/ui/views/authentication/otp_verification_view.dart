import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/shared/widgets/app_button.dart';
import 'package:clixx/shared/widgets/app_toast.dart';
import 'package:clixx/shared/widgets/app_back_button.dart';
import 'package:clixx/shared/widgets/app_otp_input.dart';

class OtpVerificationView extends StatefulWidget {
  final String phoneNumber;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime? birthday;
  final String? referralCode;

  const OtpVerificationView({
    Key? key,
    required this.phoneNumber,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.birthday,
    this.referralCode,
  }) : super(key: key);

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  Timer? _timer;
  int _timeLeft = 60;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    _timeLeft = 60;
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_timeLeft == 0) {
          timer.cancel();
        } else {
          setState(() {
            _timeLeft--;
          });
        }
      },
    );
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  String get _otpCode {
    return _controllers.map((controller) => controller.text).join();
  }

  void _resendCode() {
    if (_timeLeft == 0) {
      startTimer();
      AppToast.show(
        context: context,
        message: 'OTP re-sent successfully',
      );
    }
  }

  void _verifyOtp() {
    if (_otpCode.length == 6) {
      setState(() {
        _isVerifying = true;
      });
      // TODO: Implement OTP verification
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isVerifying = false;
        });
        // Navigate to next screen
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOtpComplete = _otpCode.length == 6;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(isBorder: false),
        centerTitle: true,
        title: Text(
          'Verify your number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            AppSpacing.v16(),
            Text(
              "We've sent you a 6-digit code to +${widget.phoneNumber}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
            ),
            AppSpacing.v64(),
            AppOtpInput(
              controllers: _controllers,
              focusNodes: _focusNodes,
              onChanged: _onChanged,
            ),
            AppSpacing.v64(),
            AppButton(
              text: 'Verify',
              onPressed: isOtpComplete ? _verifyOtp : null,
              loading: _isVerifying,
              backgroundColor: isOtpComplete ? AppColors.primary : AppColors.primitiveBlue50,
              textColor: Colors.black87,
            ),
            AppSpacing.v16(),
            Text(
              "Didn't receive any code?",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _resendCode,
                  child: Text(
                    'Resend code in ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  '${_timeLeft}s',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primitiveBlue400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 