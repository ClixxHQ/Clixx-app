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
              child: _buildTextField(index, context),
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
              child: _buildTextField(index + 3, context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(int index, BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent && 
            event.logicalKey == LogicalKeyboardKey.backspace && 
            controllers[index].text.isEmpty && 
            index > 0) {
          controllers[index - 1].clear();
          focusNodes[index - 1].requestFocus();
          return;
        }
      },
      child: TextFormField(
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
        onChanged: (value) {
          if (value.isNotEmpty) {
            onChanged(value, index);
            if (index < 5) {
              focusNodes[index + 1].requestFocus();
            }
          } else if (index > 0) {
            // When text is deleted, move to previous field
            focusNodes[index - 1].requestFocus();
          }
        },
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }
} 