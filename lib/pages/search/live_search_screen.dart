import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/base_controller.dart';
import 'package:uspace_ir/controllers/search_controller.dart';
import 'package:uspace_ir/pages/reservation/reservation_screen.dart';

class LiveSearchScreen extends StatelessWidget {
  LiveSearchScreen({Key? key}) : super(key: key);

  final SearchController liveSearchController = Get.find();
  final BaseController baseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        liveSearchController.searchTextFieldController.clear();
        liveSearchController.liveSearchEcolodgesResult.clear();
        liveSearchController.searchPlacesResult.clear();
        liveSearchController.liveSearchLandingPagesResult.clear();
        return true;
      },
      child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: Get.width/15,),
                    Container(
                    margin: const EdgeInsets.only(left: 20,top: 20,right: 20),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xffF0F2F4),
                        borderRadius: BorderRadius.circular(26)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20.0, top: 3),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            liveSearchController.liveSearch(value);
                          },
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          autofocus: true,
                          controller: liveSearchController.searchTextFieldController,
                          onTap: () {
                            if (liveSearchController.searchTextFieldController.selection ==
                                TextSelection.fromPosition(TextPosition(
                                    offset:
                                    liveSearchController.searchTextFieldController.text.length -
                                        1))) {
                              liveSearchController.searchTextFieldController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:liveSearchController.searchTextFieldController.text.length));
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
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: Get.width,
                  child: Center(
                    child: Obx(() => Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                        liveSearchController.liveSearchEcolodgesResult.isEmpty && !liveSearchController.loading.value ? [
                                                  const SizedBox()
                                                ] :
                        [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 25,
                                  );
                                },
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: liveSearchController.liveSearchEcolodgesResult.isEmpty ? 5 : liveSearchController.liveSearchEcolodgesResult.length,
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
                                            height: MediaQuery.of(context).size.width / 4.5,
                                          ),
                                        );
                                      }else{
                                        return InkWell(
                                          onTap: () {
                                            Get.to(ReservationScreen(url:liveSearchController.liveSearchEcolodgesResult[index].url));
                                          },
                                          borderRadius: BorderRadius.circular(12),
                                          child: Container(
                                            height: MediaQuery.of(context).size.width / 4.5,
                                            width: Get.width/2,
                                            padding :const EdgeInsets.all(
                                              5
                                            ),
                                            decoration:BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.borderColor
                                              ),
                                              borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: ClipRRect(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(12),
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
                                                    MediaQuery.of(context).size.width / 5,
                                                    height: MediaQuery.of(context).size.width / 5,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                      liveSearchController.liveSearchEcolodgesResult[index].image,
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context, url, error) =>
                                                      const Icon(
                                                          Icons.broken_image_outlined),
                                                    ),
                                                  ),
                                                  const SizedBox(width:10),
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          liveSearchController.liveSearchEcolodgesResult[index].title,
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .displayMedium,
                                                          ),
                                                        Text(
                                                          liveSearchController.liveSearchEcolodgesResult[index].address,
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                          color: AppColors.disabledText),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    })
                            ),),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(45),
                          onTap: (){
                            liveSearchController.searchWithFilter(liveSearchController.searchTextFieldController.text);
                            baseController.pageIndex.value = 2;
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: MediaQuery.of(context).size.width / 8,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              border: Border.all(
                                width:2,
                                color: Colors.red,
                              ),
                            ),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('مشاهده نتایج بیشتر',style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.red),),
                              ],
                            )
                          ),
                        ),
                        const SizedBox(height:20),
                      ],
                    )),
                  ),
                ),
              )
            ],
          )),
    );
  }

  // if (liveSearchController.liveSearchEcolodgesResult[index].maxDiscountPercent != 0)
  // Container(
  // height: 25,
  // width: 40,
  // decoration: const BoxDecoration(
  // color: Color(0xffEA213B),
  // borderRadius: BorderRadius.only(
  // bottomLeft:
  // Radius.circular(12),
  // bottomRight:
  // Radius.circular(12))),
  // child: Center(
  // child: Text('${liveSearchController.liveSearchEcolodgesResult[index].maxDiscountPercent}%',
  // style: Theme.of(context)
  //     .textTheme
  //     .bodySmall!
  //     .copyWith(
  // color:
  // Colors.white))),
  // )
  // else
  // const SizedBox(),
  // Text(
  // liveSearchController.liveSearchEcolodgesResult[index].title,
  // style: Theme.of(context)
  //     .textTheme
  //     .displayMedium!
  //     .copyWith(color: Colors.white),
  // ),
  // Container(
  // margin: EdgeInsets.only(
  // right: Get.width * 0.05,
  // left: Get.width * 0.13),
  // width: Get.width,
  // child: Row(
  // crossAxisAlignment:
  // CrossAxisAlignment.end,
  // children: [
  // SvgPicture.asset(
  // 'assets/icons/location_small_pin_ic.svg',
  // color: Colors.white,
  // width: 18),
  // const SizedBox(
  // width: 5,
  // ),
  // Expanded(
  // child: Text(
  // liveSearchController.liveSearchEcolodgesResult[index].address,
  // maxLines: 1,
  // overflow:
  // TextOverflow.ellipsis,
  // style: Theme.of(context)
  //     .textTheme
  //     .bodySmall!
  //     .copyWith(
  // color: Colors.white),
  // ),
  // ),
  // ],
  // ),
  // ),
  // Container(
  // height: 40,
  // width: 100,
  // decoration: BoxDecoration(
  // color: Colors.white,
  // boxShadow: [
  // BoxShadow(
  // color: Colors.grey.shade300,
  // offset: const Offset(
  // 1.0,
  // 2.0,
  // ),
  // blurRadius: 4.0,
  // spreadRadius: 0.0,
  // ), //BoxShadow
  // const BoxShadow(
  // color: Colors.white,
  // offset: Offset(0.0, 0.0),
  // blurRadius: 0.0,
  // spreadRadius: 0.0,
  // ),
  // ],
  // borderRadius:
  // BorderRadius.circular(12)),
  // child: Row(
  // children: [
  // const Spacer(),
  // Text('241',
  // style: Theme.of(Get.context!)
  //     .textTheme
  //     .labelLarge),
  // const SizedBox(
  // width: 2,
  // ),
  // InkWell(
  // onTap: () {},
  // child: const Icon(
  // Icons.favorite_outline_rounded,
  // color: AppColors.mainColor,
  // size: 17,
  // ),
  // ),
  // const SizedBox(
  // width: 10,
  // ),
  // Text('26',
  // style: Theme.of(Get.context!)
  //     .textTheme
  //     .labelLarge),
  // const SizedBox(
  // width: 3,
  // ),
  // SvgPicture.asset(
  // 'assets/icons/comment_count_ic.svg',
  // color: AppColors.mainColor,
  // ),
  // const Spacer(),
  // ],
  // ),
  // )


}
