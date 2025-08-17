import 'package:cloud_firestore/cloud_firestore.dart';
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
FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<Map<String, dynamic>> addProduct (Map<String,dynamic> data) async {
   try {
      var hasil = await firestore.collection('products').add(data);
      await firestore.collection('products').doc(hasil.id).update({
        'productId': hasil.id
      });

      return {
        'error': false,
        'messages':'Berhasil Menambah Product'
      };
    } catch (e) {
      return {
        'error': true,
        'messages':'Tidak Dapat Menambah Product'
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
