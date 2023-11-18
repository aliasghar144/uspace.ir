import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/format_amount.dart';
import 'package:uspace_ir/controllers/search_controller.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key? key}) : super(key: key);

  /// how handle chose city
  ///
  ///

  RxBool customTileExpanded1 = false.obs;
  RxBool customTileExpanded2 = false.obs;
  RxBool customTileExpanded3 = false.obs;

  RxBool showMore1 = false.obs;
  RxBool showMore2 = false.obs;
  RxBool cityShowMore = false.obs;

  RxInt cityShowCount = 5.obs;


  SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SizedBox(
          height: 80,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                child: Text(
                  'اعمال فیلتر',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                )),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/bell_ic.svg'),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu, color: AppColors.disabledIcon),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: Color(0xffF8F9FD)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25, right: 20.0, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    searchController.rangeStart.value = 0.0;
                                    searchController.rangeEnd.value = 100.0;
                                    searchController.categoryFilter.value = '';
                                    searchController.cityFilter.value = '';
                                    searchController.specialPlacesFlag.value = false;
                                  },
                                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.borderColor, width: 1)), child: Text('پاک کردن همه', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.disabledText))),
                                ),
                              ),
                              const Spacer(),
                              Text('فیتلر', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.disabledText)),
                              const SizedBox(
                                width: 2,
                              ),
                              const Icon(Icons.tune_rounded, color: AppColors.disabledIcon),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 18),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color: const Color(0xffEEF1FF), borderRadius: BorderRadius.circular(14)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  'قیمت هر شب',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Obx(() => RangeSlider(
                                    divisions: 100,
                                    values: RangeValues(searchController.rangeStart.value, searchController.rangeEnd.value),
                                    labels: RangeLabels('${formatAmount(searchController.rangeStart.value.round() * 500000)}تومان', '${formatAmount(searchController.rangeEnd.value.round() * 500000)}تومان'),
                                    onChanged: (value) {
                                      setRange(value.start, value.end);
                                    },
                                    min: 0,
                                    max: 100,
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() => Text('${formatAmount(searchController.rangeStart.value.round() * 500000)} تومان', style: Theme.of(context).textTheme.labelLarge)),
                                    Obx(() => Text('${formatAmount(searchController.rangeEnd.value.round() * 500000)} تومان', style: Theme.of(context).textTheme.labelLarge)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        category(),
                        const SizedBox(
                          height: 5,
                        ),
                        cities(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void setRange(double start, double end) {
    searchController.needSearchAgain.value = true;
    searchController.rangeStart.value = start; //updating the value of Rx Variable.
    searchController.rangeEnd.value = end; //updating the value of Rx Variable.
  }

  Widget category() {
    return Obx(() => Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "دسته بندی",
                style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Color(0xff051726)),
              ),
            ],
          ),
          childrenPadding: const EdgeInsets.only(
            right: 15,
            left: 15,
            top: 0,
          ),
          trailing: Icon(
            customTileExpanded1.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: const Color(0xff051726),
            size: 30,
          ),
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 12,
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:searchController.categoryList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 25,
                    child: InkWell(
                      onTap: (){
                        searchController.needSearchAgain.value = true;
                        searchController.specialPlacesFlag.value = false;
                        if(searchController.categoryFilter.value == searchController.categoryList[index]['name']){
                          searchController.categoryFilter.value = '';
                        }else{
                          searchController.categoryFilter.value = searchController.categoryList[index]['name'];
                          searchController.categoryIdFilter.value = searchController.categoryList[index]['id'];
                        }
                      },
                      child: Row(children: [
                        Obx(() => Checkbox(
                          value: searchController.categoryFilter.value == searchController.categoryList[index]['name'] ? true : false,
                          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            searchController.needSearchAgain.value = true;
                            searchController.specialPlacesFlag.value = false;
                            if(searchController.categoryFilter.value == searchController.categoryList[index]['name']){
                              searchController.categoryFilter.value = '';
                            }else{
                              searchController.categoryFilter.value = searchController.categoryList[index]['name'];
                              searchController.categoryIdFilter.value = searchController.categoryList[index]['id'];
                            }
                          },
                          activeColor: AppColors.mainColor,
                          // Change the color of the checkbox when it is checked
                          side: const BorderSide(width: 2, color: Color.fromRGBO(82, 110, 255, 0.24)),
                        )),
                        Text(searchController.categoryList[index]['name'], style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.primaryTextColor)),
                      ]),
                    ),
                  );
                },
              ),
            ),
            showMore1.value
                ? const SizedBox(
              height: 12,
            )
                : const SizedBox(),
            const SizedBox(
              height: 15,
            ),
          ],
          onExpansionChanged: (ex) {
            customTileExpanded1.value = ex;
          },
        ),
      ),
    ));

  }

  Widget cities() {
    return Obx(() => Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "شهر",
                style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Color(0xff051726)),
              ),
            ],
          ),
          childrenPadding: const EdgeInsets.only(
            right: 15,
            left: 15,
            top: 0,
          ),
          trailing: Icon(
            customTileExpanded3.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: const Color(0xff051726),
            size: 30,
          ),
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Obx(() => ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: searchController.loading.value ? 5 : cityShowCount.value,
                itemBuilder: (context, index) {
                  if(searchController.loading.value){
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),
                          width: Get.width/5,
                          height: 15,
                        ),
                      ),
                    );
                  }
                  if (index+1 < cityShowCount.value) {
                    return SizedBox(
                      height: 25,
                      child: InkWell(
                        onTap:(){
                          searchController.needSearchAgain.value = true;
                          searchController.specialPlacesFlag.value = false;
                          if(searchController.cityFilter.value == searchController.cityList.value!.data[index].title){
                            searchController.cityFilter.value = '';
                            searchController.cityUrlFilter.value = '';
                          }else{
                            searchController.cityFilter.value = searchController.cityList.value!.data[index].title;
                            searchController.cityUrlFilter.value = searchController.cityList.value!.data[index].url;
                          }
                        },
                        child: Row(children: [
                          Obx(() => Checkbox(
                            value: searchController.cityFilter.value == searchController.cityList.value!.data[index].title ? true : false,
                            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            onChanged: (value) {
                              searchController.needSearchAgain.value = true;
                              searchController.specialPlacesFlag.value = false;
                              if(searchController.cityFilter.value == searchController.cityList.value!.data[index].title){
                                searchController.cityFilter.value = '';
                                searchController.cityUrlFilter.value = '';
                              }else{
                                searchController.cityFilter.value = searchController.cityList.value!.data[index].title;
                                searchController.cityUrlFilter.value = searchController.cityList.value!.data[index].url;
                              }
                            },
                            activeColor: AppColors.mainColor,
                            // Change the color of the checkbox when it is checked
                            side: const BorderSide(width: 2, color: Color.fromRGBO(82, 110, 255, 0.24)),
                          )),
                          Text(searchController.cityList.value?.data[index].title ?? '', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.primaryTextColor)),
                        ]),
                      ),
                    );
                  }
                  if (index+1 == searchController.cityList.value?.data.length || index >= searchController.cityList.value!.data.length) {
                    return Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton.icon(
                          onPressed: () {
                            cityShowCount.value = 5;
                          },
                          icon: const Icon(
                            Icons.add,
                            color: AppColors.mainColor,
                            size: 20,
                          ),
                          label: Text('موارد کمتر', style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.mainColor)),
                        ),
                      ],
                    );
                  }else{
                    return Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton.icon(
                          onPressed: () {
                            cityShowCount.value += 5;
                          },
                          icon: const Icon(
                            Icons.add,
                            color: AppColors.mainColor,
                            size: 20,
                          ),
                          label: Text('موارد بیشتر', style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.mainColor)),
                        ),
                      ],
                    );
                  }
                  // if (index ==
                  //     searchController.cityList.value!.data!.length ~/
                  //             2 &&
                  //     cityShowMore.value == false) {
                  //   return Row(
                  //     children: [
                  //       const SizedBox(
                  //         width: 8,
                  //       ),
                  //       TextButton.icon(
                  //         onPressed: () {
                  //           cityShowMore.toggle();
                  //         },
                  //         icon: const Icon(
                  //           Icons.add,
                  //           color: AppColors.mainColor,
                  //           size: 20,
                  //         ),
                  //         label: Text('موارد بیشتر',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .labelSmall!
                  //                 .copyWith(
                  //                     color: AppColors
                  //                         .mainColor)),
                  //       ),
                  //     ],
                  //   );
                  // } else if (index ==
                  //     searchController.cityList.value!.data!.length &&
                  //     cityShowMore.value == true) {
                  //   return Row(
                  //     children: [
                  //       const SizedBox(
                  //         width: 8,
                  //       ),
                  //       TextButton.icon(
                  //         onPressed: () {
                  //           cityShowMore.toggle();
                  //         },
                  //         icon: const Icon(
                  //           Icons.minimize_rounded,
                  //           color: AppColors.mainColor,
                  //           size: 20,
                  //         ),
                  //         label: Text('موارد کمتر',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .labelSmall!
                  //                 .copyWith(
                  //                     color: AppColors
                  //                         .mainColor)),
                  //       ),
                  //     ],
                  //   );
                  // } else {
                  //   return SizedBox(
                  //     height: 25,
                  //     child: Row(children: [
                  //       Obx(() => Checkbox(
                  //             value: searchController.cityIndex.value  == index ? true : false,
                  //             shape:
                  //                 ContinuousRectangleBorder(
                  //                     borderRadius:
                  //                         BorderRadius
                  //                             .circular(
                  //                                 4)),
                  //             onChanged: (value) {
                  //               value: searchController.cityIndex.value = index;
                  //
                  //             },
                  //             activeColor:
                  //                 AppColors.mainColor,
                  //             // Change the color of the checkbox when it is checked
                  //             side: const BorderSide(
                  //                 width: 2,
                  //                 color: Color.fromRGBO(
                  //                     82,
                  //                     110,
                  //                     255,
                  //                     0.24)),
                  //           )),
                  //       InkWell(
                  //         onTap: () {
                  //          searchController.cityIndex.value = index;
                  //         },
                  //         child: Text(
                  //             searchController
                  //                     .cityList.value!.data![index]
                  //                 .title??'',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .labelMedium!
                  //                 .copyWith(
                  //                     color: AppColors
                  //                         .primaryTextColor)),
                  //       ),
                  //     ]),
                  //   );
                  // }
                },
              )),
            ),
            cityShowMore.value
                ? const SizedBox(
              height: 15,
            )
                : const SizedBox(),
            const SizedBox(
              height: 15,
            ),
          ],
          onExpansionChanged: (ex) {
            customTileExpanded3.value = ex;
          },
        ),
      ),
    ));
  }
}
