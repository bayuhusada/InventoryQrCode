import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inventory_qr_code/app/constant/colors.dart';
import 'package:inventory_qr_code/app/data/model/product_model.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({super.key});

  final ProductModel product = Get.arguments;
  final formatter = NumberFormat.decimalPattern('id');
  @override
  Widget build(BuildContext context) {
    controller.codeC.text = product.code;
    controller.nameC.text = product.name;
    controller.prizeC.text = NumberFormat.decimalPattern(
      'id',
    ).format(product.prize);
    controller.qtyC.text = "${product.qty}";

    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailProduct', style: TextStyle(color: greyColor),),
        backgroundColor: marronColor,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImageView(
                  data: product.code,
                  size: 200.0,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            autocorrect: false,
            controller: controller.codeC,
            keyboardType: TextInputType.number,
            readOnly: true,
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
          TextButton(

            onPressed: () {},
            child: Text('Hapus', style: TextStyle(color: marronColor),),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: marronColor,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (controller.nameC.text.isNotEmpty &&
                    controller.prizeC.text.isNotEmpty &&
                    controller.qtyC.text.isNotEmpty) {
                  controller.isLoading(true);
                  String hargaUntukDB = controller.prizeC.text.replaceAll(
                    '.',
                    '',
                  );
                  int hargaInt = int.tryParse(hargaUntukDB) ?? 0;
                  Map<String, dynamic> hasil = await controller.editProduct({
                    'id': product.productId,
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
                  controller.isLoading(false);
                } else {
                  Get.snackbar('Error', 'Data tidak boleh kosong');
                }
              }
            },
            child: Obx(
              () => Text(
                controller.isLoading.isFalse ? 'Edit Produk' : 'Loading...',
                style: TextStyle(color: greyColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
