import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/services/navigation_service.dart';
import 'package:clixx/shared/widgets/app_bottom_sheet.dart';

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
    AppBottomSheet.showBottomSheet(
      isScrollControlled: true,
      showDragIndicator: true,
      height: MediaQuery.of(NavigationService.context).size.height * 0.5,
      child: CalendarBottomSheet(
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
  late DateTime _selectedDate;
  bool _showYearPicker = false;
  bool _showMonthPicker = false;

  @override
  void initState() {
    super.initState();
    _focusedDate = widget.selectedDate ?? DateTime.now();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  void _handleYearSelection(int year) {
    setState(() {
      _focusedDate = DateTime(year, _focusedDate.month);
      _showYearPicker = false;
    });
  }

  void _handleMonthSelection(int month) {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, month);
      _showMonthPicker = false;
    });
  }

  Widget _buildYearPicker() {
    final currentYear = DateTime.now().year;
    final years = List.generate(100, (index) => currentYear - 50 + index);

    return SizedBox(
      height: 300.h,
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
              child: Text(
                year.toString(),
                style: TextStyle(
                  color: isSelected ? AppColors.primary : Colors.black,
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

  Widget _buildMonthPicker() {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    return SizedBox(
      height: 300.h,
      child: ListView.builder(
        itemCount: months.length,
        itemBuilder: (context, index) {
          final month = index + 1;
          final isSelected = month == _focusedDate.month;

          return InkWell(
            onTap: () => _handleMonthSelection(month),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              alignment: Alignment.center,
              child: Text(
                months[index],
                style: TextStyle(
                  color: isSelected ? AppColors.primary : Colors.black,
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

  Widget _buildCalendar() {
    final daysInMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final prevMonthDays = (firstWeekday + 6) % 7;

    final days = <Widget>[];
    
    const weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    for (var day in weekdays) {
      days.add(
        Container(
          height: 40.h,
          alignment: Alignment.center,
          child: Text(
            day,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    for (var i = 0; i < prevMonthDays; i++) {
      final prevDate = firstDayOfMonth.subtract(Duration(days: prevMonthDays - i));
      days.add(
        Container(
          height: 40.h,
          alignment: Alignment.center,
          child: Text(
            '${prevDate.day}',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black38,
            ),
          ),
        ),
      );
    }

    for (var i = 1; i <= daysInMonth; i++) {
      final currentDate = DateTime(_focusedDate.year, _focusedDate.month, i);
      final isSelected = currentDate.year == _selectedDate.year &&
          currentDate.month == _selectedDate.month &&
          currentDate.day == _selectedDate.day;

      days.add(
        InkWell(
          onTap: () {
            setState(() {
              _selectedDate = currentDate;
            });
            widget.onDateSelected(currentDate);
            Navigator.pop(context);
          },
          child: Container(
            height: 40.h,
            alignment: Alignment.center,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: isSelected
                  ? const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    )
                  : null,
              alignment: Alignment.center,
              child: Text(
                '$i',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    final remainingDays = 42 - (prevMonthDays + daysInMonth);
    for (var i = 1; i <= remainingDays; i++) {
      days.add(
        Container(
          height: 40.h,
          alignment: Alignment.center,
          child: Text(
            '$i',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black38,
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: days,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSpacing.v16(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  if (!_showYearPicker && !_showMonthPicker) {
                    setState(() {
                      _focusedDate = DateTime(
                        _focusedDate.year,
                        _focusedDate.month - 1,
                      );
                    });
                  }
                },
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showYearPicker = true;
                        _showMonthPicker = false;
                      });
                    },
                    child: Text(
                      _focusedDate.year.toString(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    ' ',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showMonthPicker = true;
                        _showYearPicker = false;
                      });
                    },
                    child: Text(
                      DateFormat('MMMM').format(_focusedDate),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  if (!_showYearPicker && !_showMonthPicker) {
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
        ),
        AppSpacing.v16(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _showYearPicker 
                  ? _buildYearPicker() 
                  : _showMonthPicker 
                      ? _buildMonthPicker() 
                      : _buildCalendar(),
            ),
          ),
        ),
        AppSpacing.v16(),
      ],
    );
  }
} 