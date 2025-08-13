import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inventory_qr_code/app/constant/colors.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'toProducts',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ProductsView', style: TextStyle(color: greyColor),),
          backgroundColor: marronColor,
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'ProductsView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
