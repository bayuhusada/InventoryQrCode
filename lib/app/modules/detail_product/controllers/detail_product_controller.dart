import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class DetailProductController extends GetxController {
final TextEditingController codeC = TextEditingController();
final TextEditingController nameC = TextEditingController();
final TextEditingController prizeC = TextEditingController();
final TextEditingController qtyC = TextEditingController();

RxBool isLoading = false.obs;

FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<Map<String, dynamic>> editProduct (Map<String,dynamic> data) async {
   try {
      await firestore.collection('products').doc(data['id']).update({
        'name': data['name'],
        'prize': data['prize'],
        'qty': data['qty'],
      });

      return {
        'error': false,
        'messages':'Berhasil Update Product'
      };
    } catch (e) {
      return {
        'error': true,
        'messages':'Gagal Update Product'
      };
    }
} 


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
