import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SingleImageView extends StatelessWidget {
  SingleImageView({Key? key}) : super(key: key);

  final RxBool horizontalImage = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: OrientationBuilder(
            builder: (context, orientation) => Stack(
              alignment: Alignment.bottomRight,
              children: [
                CachedNetworkImage(imageUrl: Get.arguments),
                Positioned(
                    left: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        if (!horizontalImage.value) {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown,
                          ]);
                        }
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () async {
                      horizontalImage.toggle();
                      if (horizontalImage.value) {
                        await SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                        ]);
                      } else {
                        await SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.landscapeRight,
                        ]);
                      }
                    },
                    icon: const Icon(
                      Icons.screen_rotation_alt,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
