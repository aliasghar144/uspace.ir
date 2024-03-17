import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  // final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return signed();
  }


  signed(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Profile Screen',style: Theme.of(Get.context!).textTheme.headlineMedium,)
      ],
    );
  }
}
