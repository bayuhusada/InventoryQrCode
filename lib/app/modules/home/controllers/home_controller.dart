import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:inventory_qr_code/app/data/model/product_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<ProductModel> allProducts = List<ProductModel>.empty().obs;

  void downloadCatalog() async {
    final pdf = pw.Document();

    var getData = await firestore.collection('products').get();

    allProducts([]);
    getData.docs.forEach((element) {
      allProducts.add(ProductModel.fromJson(element.data()));
    });

    print(allProducts);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          List<pw.TableRow> allData = List.generate(
            allProducts.length,
            (index) {
              ProductModel product = allProducts[index];
              return pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Text(
                      '${index + 1}',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Text(
                      product.code,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Text(
                      product.name,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Text(
                      product.prize.toString(),
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Text(
                      product.qty.toString(),
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.BarcodeWidget(
                      color: PdfColor.fromHex('#000000'),
                      data: product.code,
                      barcode: pw.Barcode.qrCode(),
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              );
            },
          );

          return [
            pw.Center(
              child: pw.Text(
                'Catalog',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 24),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(
                color: PdfColor.fromHex('#000000'),
                width: 2,
              ),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text(
                        'No',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text(
                        'Product Code',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text(
                        'Nama',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text(
                        'Harga',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text(
                        'Quantity',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text(
                        'QrCode',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ...allData,
              ],
            ),
          ];
        },
      ),
    );

    // simpan  pdf
    Uint8List bytes = await pdf.save();

    // membuat file kosong di direktory
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/Mydocument.pdf');

    // menulis data pdf ke file
    await file.writeAsBytes(bytes);

    //open file
    await OpenFile.open(file.path);
  }
}
