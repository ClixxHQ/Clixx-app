import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_picker/country_picker.dart';
import 'package:clixx/ui/widgets/calendar_bottom_sheet.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  String _searchQuery = '';
  PhoneNumber? _phoneNumber;
  DateTime? _selectedDate;
  bool _termsAccepted = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneNumber = PhoneNumber(isoCode: 'NG');
  }

  void _showCalendarPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CalendarBottomSheet(
        selectedDate: _selectedDate,
        onDateSelected: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create an account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'It will only take a minute to create you account.\nPlease enter your details to get started',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Country',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone number',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        // This will trigger the country picker
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (country) {
                            setState(() {
                              _phoneNumber = PhoneNumber(
                                isoCode: country.countryCode,
                                phoneNumber: _phoneController.text,
                              );
                            });
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  _phoneNumber?.isoCode == 'NG' ? '🇳🇬' : '🇳🇬',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: '800 000 0000',
                        prefixText: '+234 ',
                        filled: true,
                        fillColor: const Color(0xFFF3F4F6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildTextField(
                label: 'Email address',
                controller: _emailController,
                hintText: 'example@email.com',
                isRequired: true,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'First name',
                      controller: _firstNameController,
                      hintText: 'e.g Sam',
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: 'Last name',
                      controller: _lastNameController,
                      hintText: 'e.g Smith',
                      isRequired: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Birthday',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _showCalendarPicker,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _selectedDate != null
                                ? DateFormat('MMMM d yyyy').format(_selectedDate!)
                                : 'Select birth month and day',
                            style: TextStyle(
                              color: _selectedDate != null
                                  ? Colors.black87
                                  : Colors.black54,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.calendar_today_outlined, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildTextField(
                label: 'Referral code',
                controller: _referralController,
                hintText: 'Enter a referral code',
                isRequired: false,
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value ?? false;
                        });
                      },
                      shape: const CircleBorder(),
                      side: const BorderSide(width: 1.5),
                      activeColor: const Color(0xFF208BFE),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          children: [
                            TextSpan(
                              text: 'I confirm that I have read, consented and agree to Clixx ',
                            ),
                            TextSpan(
                              text: 'Terms of Use',
                              style: TextStyle(
                                color: Color(0xFF208BFE),
                              ),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Color(0xFF208BFE),
                              ),
                            ),
                            TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _termsAccepted ? () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Handle sign up
                    }
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF208BFE),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    disabledBackgroundColor: const Color(0xFF208BFE).withOpacity(0.5),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required bool isRequired,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              const Text(
                '*',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }
}