import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inventory_qr_code/app/constant/colors.dart';
import 'package:inventory_qr_code/app/data/model/product_model.dart';
import 'package:inventory_qr_code/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  ProductsView({super.key});

  final formatter = NumberFormat.decimalPattern('id');
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'toProducts',
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Products',
            style: TextStyle(color: greyColor),
          ),
          backgroundColor: marronColor,
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamProduct(),
          builder: (context, snapProduct) {
            if (snapProduct.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapProduct.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "Tidak ada Produk",
                  style: TextStyle(color: marronColor),
                ),
              );
            }

            List<ProductModel> allProduct = [];
            for (var element in snapProduct.data!.docs) {
              allProduct.add(ProductModel.fromJson(element.data()));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: allProduct.length,
              itemBuilder: (context, index) {
                ProductModel product = allProduct[index];
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.only(bottom: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_PRODUCT, arguments: product);
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.code,
                                  style: const TextStyle(
                                    color: marronColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${product.name}",
                                  style: TextStyle(
                                    color: redColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Harga: Rp. ${NumberFormat.decimalPattern('id').format(product.prize)}",
                                ),
                                Text("Jumlah: ${product.qty.toString()}"),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: QrImageView(
                              data: product.code,
                              size: 200.0,
                              version: QrVersions.auto,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
