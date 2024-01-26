import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class SingleImageView extends StatelessWidget {
  SingleImageView({Key? key}) : super(key: key);

  final RxBool horizontalImage = false.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async {
        if (!horizontalImage.value) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
        Get.back();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Center(
                child: OrientationBuilder(
                  builder: (context, orientation) => CachedNetworkImage(imageUrl: Get.arguments['image'],imageBuilder: (context, imageProvider) {
                    return AspectRatio(
                      aspectRatio: 16/9,
                      child: PhotoView(
                        imageProvider: imageProvider,
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      ),
                    );
                  },),
                ),
              ),
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
                    icon: const Icon(Icons.arrow_back),
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
    );
  }
}

