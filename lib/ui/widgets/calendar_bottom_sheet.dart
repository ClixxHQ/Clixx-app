import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:intl/intl.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/services/navigation_service.dart';

class CalendarBottomSheet extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarBottomSheet({
    Key? key,
    this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  static void show({
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    showModalBottomSheet(
      context: NavigationService.context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CalendarBottomSheet(
        selectedDate: selectedDate,
        onDateSelected: onDateSelected,
      ),
    );
  }

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  late DateTime _focusedDate;
  bool _showYearPicker = false;

  @override
  void initState() {
    super.initState();
    _focusedDate = widget.selectedDate ?? DateTime.now();
  }

  void _handleYearSelection(int year) {
    setState(() {
      _focusedDate = DateTime(year, _focusedDate.month);
      _showYearPicker = false;
    });
  }

  Widget _buildYearPicker() {
    final currentYear = DateTime.now().year;
    final years = List.generate(100, (index) => currentYear - 50 + index);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          final isSelected = year == _focusedDate.year;

          return InkWell(
            onTap: () => _handleYearSelection(year),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                year.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 16.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  if (!_showYearPicker) {
                    setState(() {
                      _focusedDate = DateTime(
                        _focusedDate.year,
                        _focusedDate.month - 1,
                      );
                    });
                  }
                },
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showYearPicker = !_showYearPicker;
                  });
                },
                child: Text(
                  '${_focusedDate.year} ${_getMonthName(_focusedDate.month)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  if (!_showYearPicker) {
                    setState(() {
                      _focusedDate = DateTime(
                        _focusedDate.year,
                        _focusedDate.month + 1,
                      );
                    });
                  }
                },
              ),
            ],
          ),
          AppSpacing.v16(),
          Expanded(
            child: _showYearPicker
                ? _buildYearPicker()
                : CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      calendarType: CalendarDatePicker2Type.single,
                      selectedDayHighlightColor: AppColors.primary,
                      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
                      weekdayLabelTextStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                      ),
                      controlsTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      dayTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                      selectedDayTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      currentDate: _focusedDate,
                    ),
                    value: widget.selectedDate != null ? [widget.selectedDate!] : [],
                    onValueChanged: (dates) {
                      if (dates.isNotEmpty) {
                        widget.onDateSelected(dates.first!);
                        Navigator.pop(context);
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
} 