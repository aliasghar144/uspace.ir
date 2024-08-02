import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';

class ImageView extends StatelessWidget {
  final int? index;
  final bool userImages;
  final String url;
  final String? image;
  final List<ImageList>? imageList;
  final List<CommentsFile>? commentList;
  ImageView({
    this.index,
    required this.url,
    this.image,
    this.userImages = true,
    this.imageList,
    this.commentList,
    Key? key,}) : super(key: key);

  final RxBool horizontalImage = true.obs;
  final RxInt rotate = 0.obs;
  final RxDouble width = Get.width.obs;
  final RxDouble height = (Get.height/3).obs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Center(
              child: Obx(() => RotatedBox(
                quarterTurns: rotate.value,
                child: SizedBox(
                  width: width.value,
                  height: height.value,
                  child: CarouselSlider.builder(
                      itemCount: !userImages ? imageList!.length : commentList!.length,
                      itemBuilder: (context, index, realIndex) {
                    return CachedNetworkImage(
                      imageUrl: !userImages ? 'https://www.uspace.ir/spaces/$url/images/main/${imageList![index].fullImage}' : commentList![index].fileName,
                      errorWidget: (context, url, error) {
                        return Container(
                          clipBehavior: Clip.none,
                          width: Get.width / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            'assets/images/image_not_available.png',
                            fit: BoxFit.scaleDown,
                          ),
                        );
                      },
                      imageBuilder: (context, imageProvider) {
                        return AspectRatio(
                          aspectRatio: 16/9,
                          child: PhotoView(
                            imageProvider: imageProvider,
                            minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered * 2,
                          ),
                        );
                      },);
                  }, options: CarouselOptions(
                    initialPage: index ?? 0,
                    height: height.value,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                  )),
                ),
              )),
            ),
            Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                  onPressed: () {
                    if (horizontalImage.value) {
                      Get.forceAppUpdate();
                      Get.back();
                    }else{
                      horizontalImage.value = true;
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                )),
            IconButton(
                onPressed: (){
                  if(rotate.value == 0){
                    rotate.value = 1;
                    width.value = Get.height;
                    height.value = Get.width;
                  }else{
                    rotate.value =0;
                    width.value = Get.width;
                    height.value = Get.height/3;
                  }
                  // horizontalImage.toggle();
                  // if (horizontalImage.value) {
                  //   await SystemChrome.setPreferredOrientations([
                  //     DeviceOrientation.portraitUp,
                  //     DeviceOrientation.portraitDown,
                  //   ]);
                  // } else {
                  //   await SystemChrome.setPreferredOrientations([
                  //     DeviceOrientation.landscapeLeft,
                  //     DeviceOrientation.landscapeRight,
                  //   ]);
                  // }
                },
                icon: const Icon(
                  Icons.screen_rotation_alt,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}

