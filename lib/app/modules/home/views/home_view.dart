import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inventory_qr_code/app/constant/colors.dart';
import 'package:inventory_qr_code/app/controllers/auth_controller.dart';
import 'package:inventory_qr_code/app/modules/scan_page/scan_page.dart';
import 'package:inventory_qr_code/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final AuthController authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: greyColor),
        ),
        centerTitle: true,
        backgroundColor: redColor,
        actions: [
          IconButton(
            onPressed: () async {
              Map<String, dynamic> hasil = await authC.logOut();
              if (hasil['error'] == false) {
                Get.offAllNamed(Routes.LOGIN);
              } else {
                Get.snackbar('Error', hasil['error']);
              }
            },
            icon: Icon(
              Icons.logout_outlined,
              color: greyColor,
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(15),

        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          String tittle;
          IconData icon;
          late VoidCallback onTap;

          switch (index) {
            case 0:
              tittle = 'Tambah Product';
              icon = Icons.add_box_rounded;
              onTap = () => Get.toNamed(Routes.ADD_PRODUCT);
              break;
            case 1:
              tittle = 'Products';
              icon = Icons.list_alt_rounded;
              onTap = () => Get.toNamed(Routes.PRODUCTS);
              break;
            case 2:
              tittle = 'Scan QR';
              icon = Icons.qr_code_scanner_rounded;
              onTap = () async {
                // buka halaman scanner
                final barcode = await Get.to(() => const ScanPage());

                if (barcode != null) {
                  Map<String, dynamic> hasil = await controller.getProductById(
                    barcode,
                  );

                  if (hasil['error'] == false) {
                    Get.toNamed(
                      Routes.DETAIL_PRODUCT,
                      arguments: hasil['data'],
                    );
                  } else {
                    Get.snackbar(
                      'Error',
                      hasil['messages'],
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                } else {
                  Get.snackbar(
                    'Info',
                    'Scan dibatalkan',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              };
              break;
            case 3:
              tittle = 'Catalog';
              icon = Icons.print_rounded;
              onTap = () {
                controller.downloadCatalog();
              };
              break;
            default:
              tittle = 'Unknown';
              icon = Icons.help_outline;
          }
          return Material(
            color: peachColor,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(
                        icon,
                        size: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(tittle),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
