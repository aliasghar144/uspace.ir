import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/controllers/home_controller.dart';

class TestScreen extends StatelessWidget {
  TestScreen({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      Text(
      homeController.mainGallery[0]['caption'],
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.red),
      ),
          IconButton(onPressed: (){
            homeController.fetchMainGallery();
          }, icon: Icon(Icons.add))
        ],
      ),
    );
  }


}
