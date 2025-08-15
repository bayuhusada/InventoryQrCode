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
          SizedBox(height: 20,),
            TextField(
            autocorrect: false,
            controller: controller.nameC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Nama Produk',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20,),
            TextField(
              inputFormatters: [
                CurrencyFormatter()
              ],
            autocorrect: false,
            controller: controller.prizeC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Harga',
            prefixText: 'Rp.',
              border: OutlineInputBorder(),
            ),
          ),
           SizedBox(height: 20,),
            TextField(
            autocorrect: false,
            controller: controller.qtyC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: redColor,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                onPressed: () async {
                  // if (controller.isLoading.isFalse) {
                  //   controller.isLoading(true);
                  //   // Map<String, dynamic>  hasil = await authC.login(controller.emailC.text, controller.passwordC.text);
                  //   controller.isLoading(false);

                  // }
                },
                child: Obx(
                  () => Text(
                    controller.isLoading.isFalse ?'Tambah Produk' : 'Loading...',
                    style: TextStyle(color: greyColor),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
