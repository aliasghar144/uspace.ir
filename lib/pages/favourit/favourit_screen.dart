import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/check_currency.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/pages/reservation/reservation_screen.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 20,),
          Text('لیست علاقه مندی ها',style: Theme.of(Get.context!).textTheme.bodyLarge,),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Obx(() => ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userController.favList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final RoomReservationModel room = roomReservationModelFromJson(userController.favList[index]);
                  if(userController.favLoading.value){
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
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
                        ]),
                        width: MediaQuery.of(context).size.width,
                        height: 160,
                      ),
                    );
                  }else{
                    return InkWell(
                      onTap: () {

                        Get.to(ReservationScreen(url:room.data.url));
                      },
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
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
                              ]),
                              width: MediaQuery.of(context).size.width,
                              height: 160,
                              child: CachedNetworkImage(
                                imageUrl: room.data.mainImage,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [
                                    0.50,
                                    30
                                  ], colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(1),
                                  ])),
                              width: MediaQuery.of(context).size.width,
                              height: 160,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: Get.width * 0.08,
                            width: Get.width,
                            child: Container(
                              margin: EdgeInsets.only(right: Get.width * 0.05, left: Get.width * 0.13),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    room.data.title,
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset('assets/icons/location_small_pin_ic.svg', color: Colors.white, width: 18),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          room.data.address,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.elliptical(45, 50), topRight: Radius.elliptical(45, 50))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                              child: Text(
                                room.data.minPrice == 0 ? 'تماس با پشتیبانی' : '${room.data.minPrice.toString().beToman().seRagham()} ${checkCurrency(room.data.currency)}/${room.data.unitPrice}',
                                maxLines: 1,
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }, separatorBuilder: (context, index) {
              return const SizedBox(height: 10,);
            })),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

}
