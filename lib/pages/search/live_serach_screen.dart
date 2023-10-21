import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/live_search_controller.dart';

class LiveSearchScreen extends StatelessWidget {
  LiveSearchScreen({Key? key}) : super(key: key);

  LiveSearchController liveSearchController = Get.put(LiveSearchController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        liveSearchController.liveTextFieldController.clear();
        liveSearchController.liveSearchEcolodgesResult.clear();
        liveSearchController.liveSearchPlacesResult.clear();
        liveSearchController.liveSearchLandingPagesResult.clear();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                  margin: const EdgeInsets.only(left: 20,top: 20,right: 20),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xffF0F2F4),
                      borderRadius: BorderRadius.circular(26)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20.0, top: 3),
                      child: Hero(
                        tag:'SearchBar',
                        child: Material(
                          color: Colors.transparent,
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              liveSearchController.liveSearch(value);
                            },
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            autofocus: true,
                            controller: liveSearchController.liveTextFieldController,
                            onTap: () {
                              if (liveSearchController.liveTextFieldController.selection ==
                                  TextSelection.fromPosition(TextPosition(
                                      offset:
                                      liveSearchController.liveTextFieldController.text.length -
                                          1))) {
                                liveSearchController.liveTextFieldController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:liveSearchController.liveTextFieldController.text.length));
                              }
                            },
                            onChanged: (value) {
                              liveSearchController.liveSearch(value);
                            },
                            style: Theme.of(Get.context!).textTheme.labelLarge,
                            decoration: InputDecoration(
                                hintTextDirection: TextDirection.rtl,
                                border: InputBorder.none,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                                  child: InkWell(
                                    child: SvgPicture.asset(
                                      'assets/icons/search_ic.svg',
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                                hintText: "جستجوی نام اقامتگاه،شهر،روستا",
                                hintStyle: Theme.of(Get.context!)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: AppColors.disabledIcon)),
                          ),
                        ),
                      ),
                    ),
                  ),
                    ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: Get.width,
                    child: Center(
                      child: Obx(() => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: liveSearchController.liveSearchEcolodgesResult.isEmpty && !liveSearchController.loading.value ? [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 35.0),
                            child: Text(liveSearchController.firstOpen.value ? '' : 'موردی یافت نشد',style: Theme.of(context).textTheme.headlineSmall,),
                          )
                        ] : [
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 25,
                                      );
                                    },
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: liveSearchController.liveSearchEcolodgesResult.isEmpty ? 5 : liveSearchController.liveSearchEcolodgesResult.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: 15, top: 15),
                                    itemBuilder: (context, index) =>
                                        Obx((){
                                          if(liveSearchController.loading.value){
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey.shade100,
                                              child: Container(
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(25),
                                                    boxShadow: [
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
                                                width:
                                                MediaQuery.of(context).size.width,
                                                height: 160,
                                              ),
                                            );
                                          }else{
                                            return InkWell(
                                              onTap: () {
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
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(25),
                                                          boxShadow: [
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
                                                      width:
                                                      MediaQuery.of(context).size.width,
                                                      height: 160,
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                        liveSearchController.liveSearchEcolodgesResult[index].image,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context, url, error) =>
                                                        const Icon(
                                                            Icons.broken_image_outlined),
                                                      ),
                                                    ),
                                                  ),
                                                  if (liveSearchController.liveSearchEcolodgesResult[index].maxDiscountPercent != 0)
                                                    Positioned(
                                                      right: Get.width * 0.10,
                                                      top: 0,
                                                      child: Container(
                                                        height: 25,
                                                        width: 40,
                                                        decoration: const BoxDecoration(
                                                            color: Color(0xffEA213B),
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft:
                                                                Radius.circular(12),
                                                                bottomRight:
                                                                Radius.circular(12))),
                                                        child: Center(
                                                            child: Text('${liveSearchController.liveSearchEcolodgesResult[index].maxDiscountPercent}%',
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                    color:
                                                                    Colors.white))),
                                                      ),
                                                    )
                                                  else
                                                    const SizedBox(),
                                                  Positioned(
                                                      right: Get.width * 0.05,
                                                      bottom: Get.width * 0.13,
                                                      child: Text(
                                                        liveSearchController.liveSearchEcolodgesResult[index].title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium!
                                                            .copyWith(color: Colors.white),
                                                      )),
                                                  Positioned(
                                                      right: 0,
                                                      bottom: Get.width * 0.08,
                                                      width: Get.width,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: Get.width * 0.05,
                                                            left: Get.width * 0.13),
                                                        width: Get.width,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                          children: [
                                                            SvgPicture.asset(
                                                                'assets/icons/location_small_pin_ic.svg',
                                                                color: Colors.white,
                                                                width: 18),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                liveSearchController.liveSearchEcolodgesResult[index].address,
                                                                maxLines: 1,
                                                                overflow:
                                                                TextOverflow.ellipsis,
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                    color: Colors.white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Positioned(
                                                    bottom: -Get.width * 0.03,
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
                                                          borderRadius:
                                                          BorderRadius.circular(12)),
                                                      child: Row(
                                                        children: [
                                                          const Spacer(),
                                                          Text('241',
                                                              style: Theme.of(Get.context!)
                                                                  .textTheme
                                                                  .labelLarge),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                          InkWell(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              Icons.favorite_outline_rounded,
                                                              color: AppColors.mainColor,
                                                              size: 17,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text('26',
                                                              style: Theme.of(Get.context!)
                                                                  .textTheme
                                                                  .labelLarge),
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
                                        })
                                ),),
                            ),
                          ),
                          const Divider(height: 35,thickness: 1,),
                          places(),
                          const SizedBox(height:20),
                        ],
                      )),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget places(){
    return Column(
      children:[
        Text('no title',style:Theme.of(Get.context!).textTheme.bodyMedium),
        const SizedBox(height:20),
        SizedBox(
          width: MediaQuery.of(Get.context!).size.width,
          height: 220,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Obx(() => ListView.separated(
              scrollDirection:
              axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: liveSearchController.liveSearchPlacesResult.isEmpty ? 3 : liveSearchController.liveSearchPlacesResult.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 15);
              },
              itemBuilder: (context, index) {
                if(liveSearchController.liveSearchPlacesResult.isEmpty){
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      clipBehavior: Clip.none,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color:Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width / 2.4,
                    ),
                  );
                }else{
                  return CachedNetworkImage(
                    imageUrl:
                    liveSearchController.liveSearchPlacesResult[index].image,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width / 2.0,
                        ),
                        clipBehavior: Clip.none,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(22)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal:12),
                              child: Text(
                                liveSearchController.liveSearchPlacesResult[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    errorWidget: (context, url, error) =>
                        Container(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width / 2.0,
                          ),
                          clipBehavior: Clip.none,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage('https://demofree.sirv.com/nope-not-here.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(22)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal:12),
                                child: Text(
                                  liveSearchController.liveSearchPlacesResult[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                  );
                }
              },
            )),
          ),
        ),
      ]
    );
  }

}
