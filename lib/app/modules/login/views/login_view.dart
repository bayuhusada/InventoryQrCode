import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inventory_qr_code/app/constant/colors.dart';
import 'package:inventory_qr_code/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LOGIN',style: TextStyle(color: greyColor),), centerTitle: true, backgroundColor: marronColor,),
      body: Center(
        child: ListView(
          
          padding: EdgeInsets.all(10),
          children: [
            TextField(
              autocorrect: false,
              controller: controller.emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            Obx(
              () => TextField(
                autocorrect: false,
                obscureText: controller.isHidden.value,
                controller: controller.passwordC,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isHidden.toggle();
                    },
                    icon: Icon(
                      controller.isHidden.value
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                    ),
                  ),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 15),
        
            Hero(
              tag: 'toProducts',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: redColor,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10)
                  )
                ),
                onPressed: () {
                  Get.toNamed(Routes.PRODUCTS);
                },
                child: Text('Login', style: TextStyle(color: greyColor)
                ,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
