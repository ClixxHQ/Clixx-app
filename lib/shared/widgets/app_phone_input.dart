import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import 'package:clixx/shared/app_colors.dart';

class AppPhoneInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final String? labelText;

  const AppPhoneInput({
    Key? key,
    this.controller,
    this.validator,
    this.onChanged,
    this.isRequired = false,
    this.labelText,
  }) : super(key: key);

  @override
  State<AppPhoneInput> createState() => _AppPhoneInputState();
}

class _AppPhoneInputState extends State<AppPhoneInput> {
  late TextEditingController _controller;
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    // Set Nigeria as default country
    selectedCountry = Country(
      phoneCode: '234',
      countryCode: 'NG',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Nigeria',
      example: '8012345678',
      displayName: 'Nigeria (NG) [+234]',
      displayNameNoCountryCode: 'Nigeria (NG)',
      e164Key: '234-NG-0',
    );
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      useSafeArea: true,
      countryListTheme: CountryListThemeData(
        backgroundColor: Colors.white,
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.6,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          bottom: 24.h,
        ),
        searchTextStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.black87,
        ),
        textStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.black87,
        ),
        flagSize: 24.w,
        inputDecoration: InputDecoration(
          hintText: 'Search country',
          prefixIcon: Icon(Icons.search, size: 20.w, color: Colors.black54),
          filled: true,
          fillColor: AppColors.grey100,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.black54,
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
        });
      },
    );
  }

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
              if (widget.isRequired)
                Text(
                  ' *',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
        Row(
          children: [
            // Country selector
            InkWell(
              onTap: _showCountryPicker,
              child: Container(
                height: 56.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedCountry?.flagEmoji ?? '🇳🇬',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.keyboard_arrow_down, size: 20.w),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.w),
            // Phone number input
            Expanded(
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16.w),
                    Text(
                      '+${selectedCountry?.phoneCode ?? '234'}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: selectedCountry?.example ?? '8012345678',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black54,
                          ),
                        ),
                        validator: widget.validator,
                        onChanged: (value) {
                          if (widget.onChanged != null) {
                            // Include country code in the callback
                            widget.onChanged!('${selectedCountry?.phoneCode ?? '234'}$value');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
} 