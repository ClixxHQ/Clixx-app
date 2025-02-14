import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';

class AppOtpInput extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(String, int) onChanged;

  const AppOtpInput({
    Key? key,
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: List.generate(
            3,
            (index) => Container(
              width: 24.w,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: _buildTextField(index),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Row(
          children: List.generate(
            3,
            (index) => Container(
              width: 24.w,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: _buildTextField(index + 3),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(int index) {
    return TextFormField(
      controller: controllers[index],
      focusNode: focusNodes[index],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 4.w,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 4.w,
          ),
        ),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) => onChanged(value, index),
    );
  }
} 