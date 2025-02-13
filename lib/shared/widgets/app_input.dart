import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';

class AppInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final bool readOnly;
  final bool autoValidate;
  final bool isPassword;
  final bool isRequired;
  final int? maxLength;
  final VoidCallback? onTap;
  final Color color;
  final double height;
  final Widget? suffix;
  final int? maxLines;
  final Color inputColor;
  final BorderRadius? customBorderRadius;
  final double? customHeight;
  final InputBorder? customBorder;
  final Color? customInputColor;
  final FocusNode? focusNode;

  const AppInput({
    super.key,
    this.controller,
    this.initialValue,
    this.validator,
    this.labelText,
    this.hintText,
    this.obscureText,
    this.onChanged,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.isRequired = false,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.color = AppColors.grey100,
    this.height = 56,
    this.suffix,
    this.textInputAction,
    this.autoValidate = false,
    this.maxLines,
    this.inputColor = AppColors.grey100,
    this.customBorderRadius,
    this.customHeight,
    this.customBorder,
    this.customInputColor,
    this.focusNode,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool obscuring = false;
  final formFieldKey = GlobalKey<FormFieldState>();
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    obscuring = widget.obscureText ?? false;
    controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void toggleObscuring() {
    setState(() {
      obscuring = !obscuring;
    });
  }

  late TextEditingController controller;
  String? errorText;
  bool hasError = false;
  int numberOfLines = 1;

  int? get getMaxLines => widget.maxLines != null
      ? (numberOfLines > widget.maxLines! ? widget.maxLines : numberOfLines)
      : numberOfLines;

  double? get getHeight => (numberOfLines <= 1 && !hasError)
      ? widget.customHeight ?? widget.height.h
      : (numberOfLines <= 1 && hasError)
          ? 80
          : null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Row(
            children: [
              Text(
                widget.labelText!,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
              ),
              if (widget.isRequired) ...[
                Text(
                  ' *',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red,
                  ),
                ),
              ],
            ],
          ),
          AppSpacing.v8(),
        ],
        SizedBox(
          height: getHeight,
          child: TextFormField(
            key: formFieldKey,
            focusNode: focusNode,
            maxLines: getMaxLines,
            controller: controller,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLength: widget.maxLength,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText != null ? obscuring : false,
            onFieldSubmitted: (value) {
              _calculateLinesOnSubmitted();
              widget.onFieldSubmitted?.call(value);
            },
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            validator: (val) {
              if (widget.isRequired && (val == null || val.isEmpty)) {
                return 'This field is required';
              }
              final response = widget.validator?.call(val);
              errorText = response;
              setState(() {});
              return response;
            },
            onChanged: (val) {
              if (widget.autoValidate) {
                formFieldKey.currentState!.validate();
              }
              widget.onChanged?.call(val);
              _calculateLineOnChanged(val, context);
              // Clear error when user types
              if (errorText != null) {
                setState(() {
                  errorText = null;
                });
              }
            },
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: widget.customInputColor ?? widget.inputColor,
              hintText: widget.hintText,
              errorStyle: const TextStyle(fontSize: 0),
              counterText: '',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              counterStyle: const TextStyle(fontSize: 0),
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
              suffixIcon: widget.suffix ??
                  (widget.obscureText != null
                      ? IconButton(
                          onPressed: toggleObscuring,
                          icon: Icon(
                            obscuring
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.grey800,
                          ),
                        )
                      : null),
              border: widget.customBorder ??
                  OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: widget.customBorderRadius ??
                        BorderRadius.circular(12),
                  ),
              enabledBorder: widget.customBorder ??
                  OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: widget.customBorderRadius ??
                        BorderRadius.circular(12),
                  ),
            ),
          ),
        ),
        if (errorText != null) AppSpacing.v8(),
        if (errorText != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.red,
                  size: 16.w,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    errorText!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }

  void _calculateLineOnChanged(String val, BuildContext context) {
    if (widget.keyboardType == TextInputType.multiline) {
      final count = val.split('\n').length;
      int lines = (val.length /
              (MediaQuery.of(context).size.width *
                  (numberOfLines == 1 ? 0.079 : 0.088).w))
          .round();
      setState(() {
        numberOfLines = (lines == 0 ? 1 : lines) + (count == 1 ? 0 : count - 1);
      });
    }
  }

  void _calculateLinesOnSubmitted() {
    if (widget.keyboardType == TextInputType.multiline && numberOfLines == 1) {
      numberOfLines += 1;
      controller.text += '\n';
      focusNode.requestFocus();
      setState(() {});
    }
  }
} 