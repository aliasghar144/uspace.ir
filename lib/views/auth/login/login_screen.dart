import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height/5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width/6),
              width: Get.width/1.5,
              child: Hero(
                tag:'hero',
                child: CachedNetworkImage(
                  imageUrl:
                  "https://www.uspace.ir/public/img/bluesky/logo9.png",
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
