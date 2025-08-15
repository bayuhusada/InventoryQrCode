import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddProductController extends GetxController {
final TextEditingController codeC = TextEditingController();
final TextEditingController nameC = TextEditingController();
final TextEditingController prizeC = TextEditingController();
final TextEditingController qtyC = TextEditingController();

RxBool isLoading = false.obs;

}
class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Hilangkan semua karakter non-angka
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Format jadi ribuan (2.000.000)
    final formatted = NumberFormat.decimalPattern('id').format(int.parse(newText));

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
