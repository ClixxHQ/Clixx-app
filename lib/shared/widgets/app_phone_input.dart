import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/shared/widgets/app_bottom_sheet.dart';
import 'package:clixx/utils/form_validator.dart';

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
  String? errorText;

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

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _showCountryPicker() {
    AppBottomSheet.showBottomSheet(
      isScrollControlled: true,
      height: MediaQuery.of(context).size.height * 0.6,
      showDragIndicator: true,
      child: CountryListView(
        onSelect: (Country country) {
          setState(() {
            selectedCountry = country;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country label
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Country',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
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
                          Container(
                            width: 32.w,
                            height: 32.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              selectedCountry?.flagEmoji ?? '🇳🇬',
                              style: TextStyle(fontSize: 24.sp),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.keyboard_arrow_down, size: 20.w),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Phone number section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Phone number',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
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
                  Container(
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
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: selectedCountry?.example ?? '8012345678',
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black54,
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.only(right: 16.w),
                              errorStyle: const TextStyle(height: 0, fontSize: 0),
                            ),
                            validator: (value) {
                              final error = widget.validator?.call(value) ?? 
                                  FormValidators.validatePhoneNumber(value);
                              setState(() {
                                errorText = error;
                              });
                              return error;
                            },
                            onChanged: (value) {
                              if (widget.onChanged != null) {
                                widget.onChanged!('${selectedCountry?.phoneCode ?? '234'}$value');
                              }
                              // Clear error when user types
                              if (errorText != null) {
                                setState(() {
                                  errorText = null;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (errorText != null) ...[
                    AppSpacing.v8(),
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
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CountryListView extends StatefulWidget {
  final Function(Country) onSelect;

  const CountryListView({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  late TextEditingController _searchController;
  List<Country> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredCountries = CountryService().getAll();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredCountries = CountryService().getAll();
      });
      return;
    }

    setState(() {
      _filteredCountries = CountryService().getAll()
          .where((country) =>
              country.name.toLowerCase().contains(query.toLowerCase()) ||
              country.phoneCode.contains(query) ||
              country.countryCode.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 20.w, color: Colors.black54),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search country',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black54,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                    onChanged: _filterCountries,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: _filteredCountries.map((country) => ListTile(
                leading: Text(
                  country.flagEmoji,
                  style: TextStyle(fontSize: 24.sp),
                ),
                title: Text(
                  '+${country.phoneCode} ${country.name}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
                onTap: () => widget.onSelect(country),
              )).toList(),
            ),
          ),
        ),
      ],
    );
  }
} 