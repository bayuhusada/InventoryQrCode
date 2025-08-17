import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inventory_qr_code/app/constant/colors.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddProductView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.codeC,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: 'Kode Produk',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.nameC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Nama Produk',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            inputFormatters: [CurrencyFormatter()],
            autocorrect: false,
            controller: controller.prizeC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Harga',
              prefixText: 'Rp.',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.qtyC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: redColor,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (controller.codeC.text.isNotEmpty &&
                    controller.nameC.text.isNotEmpty &&
                    controller.prizeC.text.isNotEmpty &&
                    controller.qtyC.text.isNotEmpty) {
                  controller.isLoading(true);
                  String hargaUntukDB = controller.prizeC.text.replaceAll(
                    '.',
                    '',
                  );
                  int hargaInt = int.tryParse(hargaUntukDB) ?? 0;
                  Map<String, dynamic> hasil = await controller.addProduct({
                    'code': controller.codeC.text,
                    'name': controller.nameC.text,
                    'prize': hargaInt,
                    'qty': int.tryParse(controller.qtyC.text) ?? 0,
                  });
                  controller.isLoading(false);
                  Get.back();
                  Get.snackbar(
                    hasil['error'] == true ? "Error" : 'Success',
                    hasil['messages'],
                  );
                } else {
                  Get.snackbar("Error", 'Data tidak boleh kosong!');
                }
              }
            },
            child: Obx(
              () => Text(
                controller.isLoading.isFalse ? 'Tambah Produk' : 'Loading...',
                style: TextStyle(color: greyColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
