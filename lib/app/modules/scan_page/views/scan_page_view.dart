import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../controllers/scan_page_controller.dart';

class ScanPageView extends GetView<ScanPageController> {
  const ScanPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR")),
      body: MobileScanner(
        controller: MobileScannerController(),
        onDetect: (capture) {
          controller.onDetectBarcode(capture); 
        },
      ),
    );
  }
}
