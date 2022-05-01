import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/const/app_strings.dart';
import 'package:places/ui/res/theme_extension.dart';

/// Диалог выбора даты и времени, адаптированный к платформе.
abstract class DateTimePicker {
  static Future<DateTime?> show(
    BuildContext context, {
    DateTime? initial,
  }) async {
    return Platform.isIOS
        ? _pickDateTimeIOS(context, initial: initial)
        : _pickDateTimeAndroid(
            context,
            initial: initial,
          );
  }

  static Future<DateTime?> _pickDateTimeAndroid(
    BuildContext context, {
    DateTime? initial,
  }) async {
    final theme = Theme.of(context);
    final pickerTheme = theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: theme.colorScheme.green,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: theme.colorScheme.green),
      ),
    );

    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
      helpText:
          initial == null ? AppStrings.scheduleDate : AppStrings.rescheduleDate,
      builder: (context, child) => Theme(
        data: pickerTheme,
        child: child!,
      ),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initial ?? now),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: pickerTheme,
            child: child!,
          ),
        ),
      );

      if (time != null) {
        return DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      }
    }

    return null;
  }

  static Future<DateTime?> _pickDateTimeIOS(
    BuildContext context, {
    DateTime? initial,
  }) async {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final init = initial ?? now;

    DateTime? result;
    final picker = CupertinoDatePicker(
      initialDateTime: init,
      minimumDate: now,
      maximumDate: now.add(const Duration(days: 30)),
      use24hFormat: true,
      backgroundColor: theme.colorScheme.background,
      dateOrder: DatePickerDateOrder.dmy,
      onDateTimeChanged: (value) {
        result = value;
      },
    );

    final wrapper = CupertinoActionSheet(
      cancelButton: GestureDetector(
        onTap: () => Navigator.of(context).pop(result),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: Center(
            child: Text(
              initial == null ? AppStrings.schedule : AppStrings.reschedule,
              style: theme.buttonGreen,
            ),
          ),
        ),
      ),
      actions: [SizedBox(height: 200.0, child: picker)],
    );

    return showCupertinoModalPopup<DateTime?>(
      context: context,
      builder: (context) => wrapper,
    );
  }
}
