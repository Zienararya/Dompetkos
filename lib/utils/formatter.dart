import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class Formatter extends TextInputFormatter {
  final formatter = NumberFormat('#,##0', 'en_US');

  String formatAmount(int amount) {
    return formatter.format(amount);
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    int value = int.parse(newValue.text.replaceAll(',', ''));
    String newText = formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
