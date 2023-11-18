import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/pages/reservation/reservation_screen.dart';



// set after get api
class ResidenceSection extends StatelessWidget {
  final String label;
  final String location;
  final String picture;
  final PageController? pageController;
  final int like;
  final int comment;
  final int? index;
  final int? length;
  // final bool? discounted;
  final int? discountAmount;
  final bool hasCarouse;

   const ResidenceSection(
      {Key? key,
      required this.label,
        required this.location,
      required this.picture,
      required this.like,
      required this.comment,
      required this.hasCarouse,
      this.pageController,
      // this.discounted,
      this.discountAmount,
      this.index,
      this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(ReservationScreen());
      },
      child: Stack(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 5,
            width: Get.width,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(
                    1.0,
                    2.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ], borderRadius: BorderRadius.circular(22)),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: CachedNetworkImage(
                imageUrl: picture,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image_outlined),
              ),
            ),
          ),
          hasCarouse ? Positioned(
            left: 10,
            top: Get.width * 0.20,
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1.2,
                          blurRadius: 2.75,
                          offset: Offset(-1.5, 0)),
                      BoxShadow(
                          color: AppColors.mainColor.withOpacity(0.1),
                          spreadRadius: 1.2,
                          blurRadius: 2.75,
                          offset: const Offset(-1.5, 0))
                    ],
                    shape: BoxShape.circle),
                child: Center(
                    child: IconButton(
                  splashRadius: 18,
                  onPressed: () {
                    if (index != length) {
                      pageController?.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.mainColor,
                    size: 18,
                  ),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                ))),
          ) : const SizedBox(),
          hasCarouse ? Positioned(
            right: 10,
            top: Get.width * 0.20,
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1.2,
                          blurRadius: 2.75,
                          offset: Offset(1.5, 0)),
                      BoxShadow(
                          color: AppColors.mainColor.withOpacity(0.1),
                          spreadRadius: 1.2,
                          blurRadius: 2.75,
                          offset: const Offset(1.5, 0))
                    ],
                    shape: BoxShape.circle),
                child: IconButton(
                    splashRadius: 18,
                    onPressed: () {
                      if (index != 0) {
                        pageController?.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      }
                    },
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: AppColors.mainColor,
                      size: 18,
                    ))),
          ) : const SizedBox(),
          Positioned(
              right: Get.width * 0.10,
              bottom: Get.width * 0.21,
              child: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.white),
              )),
          if (discountAmount != null)
            Positioned(
              right: Get.width * 0.10,
              top: 0,
              child: Container(
                height: 25,
                width: 40,
                decoration: const BoxDecoration(
                    color: Color(0xffEA213B),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                child: Center(
                    child: Text(discountAmount.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white))),
              ),
            )
          else
            const SizedBox(),
          Positioned(
              bottom: Get.width * 0.150,
              right: Get.width * 0.01,
              width: Get.width,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 35),
                width: Get.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/location_small_pin_ic.svg',
                        color: Colors.white, width: 18),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            bottom: Get.width * 0.03,
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(
                        1.0,
                        2.0,
                      ),
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Spacer(),
                  Text(like.toString(), style: Theme.of(Get.context!).textTheme.labelLarge),
                  const SizedBox(
                    width: 2,
                  ),
                  const Icon(
                    Icons.favorite_outline_rounded,
                    color: AppColors.mainColor,
                    size: 17,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(comment.toString(), style: Theme.of(Get.context!).textTheme.labelLarge),
                  const SizedBox(
                    width: 3,
                  ),
                  SvgPicture.asset(
                    'assets/icons/comment_count_ic.svg',
                    color: AppColors.mainColor,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
