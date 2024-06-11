import 'package:cached_network_image/cached_network_image.dart';
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async {
        if (horizontalImage.value) {
          Get.forceAppUpdate();
          return true;
        }else{
          horizontalImage.value = true;
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return false;
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Center(
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    if(imageList != null || userImages){
                      return PageView.builder(
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: !userImages ? imageList!.length : commentList!.length,
                        controller: PageController(initialPage: index == null ?  0 : index!),
                        itemBuilder: (context, index) {
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
                        },
                      );
                    }else{
                      return CachedNetworkImage(imageUrl: image!,
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

                    }
                  },
                ),
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

