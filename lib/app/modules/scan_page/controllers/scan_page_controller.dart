import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPageController extends GetxController {
  var isScanned = false.obs;

  void onDetectBarcode(BarcodeCapture capture) {
    if (isScanned.value) return; // cegah double trigger

    final barcode = capture.barcodes.firstOrNull;
    final rawValue = barcode?.rawValue ?? "";

    if (rawValue.isNotEmpty) {
      isScanned.value = true; // tandai sudah scan

      // navigasi ke hasil
      Get.toNamed('/hasil', arguments: rawValue)?.then((_) {
        // reset flag setelah keluar dari halaman hasil
        isScanned.value = false;
      });
    }
  }
}
