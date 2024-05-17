// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/check_currency.dart';
import 'package:uspace_ir/controllers/search_controller.dart';
import 'package:uspace_ir/pages/reservation/reservation_screen.dart';
import 'package:uspace_ir/pages/search/filter_screen.dart';
import 'package:uspace_ir/routes/route.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Center(
        child: Obx(() => Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 25,
                      child: Obx(() => ListView(
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true, children: [
                            if (searchController.specialPlaceTitle.value != '') ...[
                              Container(
                                padding: const EdgeInsets.only(right: 4, left: 6),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                  children: [
                                    Text(searchController.specialPlaceTitle.value, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white)),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        searchController.specialPlaceTitle.value = '';
                                        searchController.specialPlaceUrl.value = '';
                                        searchController.searchWithFilter(searchController.searchTextFieldController.text);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ] else ...[
                              searchController.categoryTitle.value != ''
                                  ? Container(
                                      padding: const EdgeInsets.only(right: 4, left: 6),
                                      margin: const EdgeInsets.symmetric(horizontal: 3),
                                      decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(6)),
                                      child: Row(
                                        children: [
                                          Text(searchController.categoryTitle.value, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white)),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              searchController.categoryTitle.value = '';
                                              searchController.categoryId.value = '';
                                              searchController.searchWithFilter(searchController.searchTextFieldController.text);
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              searchController.cityTitle.value != ''
                                  ? Container(
                                      padding: const EdgeInsets.only(right: 4, left: 6),
                                      margin: const EdgeInsets.symmetric(horizontal: 3),
                                      decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(6)),
                                      child: Row(
                                        children: [
                                          Text(searchController.cityTitle.value, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white)),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              searchController.cityTitle.value = '';
                                              searchController.cityUrl.value = '';
                                              searchController.searchWithFilter(searchController.searchTextFieldController.text);
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              searchController.rangeStart.value != 0 || searchController.rangeEnd.value != 100 ?
                              Container(
                                padding: const EdgeInsets.only(right: 4, left: 6),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                  children: [
                                    Text('قیمت', style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white)),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        searchController.rangeStart.value = 0;
                                        searchController.rangeEnd.value = 100;
                                        searchController.searchWithFilter(searchController.searchTextFieldController.text);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  : const SizedBox(),
                            ]
                          ])),
                    )),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          splashRadius: 20,
                          icon: const Icon(Icons.tune_rounded),
                          onPressed: () {
                            searchController.fetchAllPlaces();
                            Get.to(() => FilterScreen())?.then((value) {
                              if (searchController.needSearchAgain.value) {
                                searchController.searchWithFilter(searchController.searchTextFieldController.text);
                              }
                              searchController.needSearchAgain.value = false;
                            });
                          },
                        ),
                        Obx(() => searchController.cityTitle.value == '' && searchController.categoryTitle.value == ''
                            ? const SizedBox()
                            : Positioned(
                                left: Get.width * 0.033,
                                top: Get.width * 0.03,
                                child: Container(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero,
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ))
                      ],
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Obx(
                      () => Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            items: searchController.sortByItems
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: AppColors.disabledText),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: searchController.sortByValue.value,
                            onChanged: (value) {
                              searchController.sortByValue.value = value as String;
                              searchController.searchWithFilter(searchController.searchTextFieldController.text);
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 40,
                              width: Get.width / 3,
                              padding: const EdgeInsets.only(right: 8, left: 5, top: 5, bottom: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                              iconEnabledColor: AppColors.disabledIcon,
                            ),
                            dropdownStyleData: DropdownStyleData(
                                elevation: 3,
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all(6),
                                  thumbVisibility: MaterialStateProperty.all(true),
                                )),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (searchController.loading.value) ...[
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
                          itemCount: 5,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 15, top: 15),
                          itemBuilder: (context, index) {
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
                          }),
                    ),
                  ),
                ),
              ] else if (searchController.searchEcolodgesResult.isEmpty && searchController.searchError.value) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          searchController.searchWithFilter(searchController.searchTextFieldController.text);
                        },
                        icon: const Icon(Icons.refresh)),
                    const Text('عدم اتصال به اینترنت'),
                  ],
                )
              ] else if (searchController.searchEcolodgesResult.isEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35.0),
                  child: Text(
                    searchController.firstOpen.value ? '' : '',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black),
                  ),
                )
              ] else ...[
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
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 15, top: 15),
                          itemCount: searchController.searchEcolodgesResult.isEmpty ? 5 : searchController.searchEcolodgesResult.length + 1,
                          itemBuilder: (context, index) {
                            if (!searchController.loadMore.value && index < searchController.searchEcolodgesResult.length) {
                              return InkWell(
                                onTap: () {

                                  Get.to(ReservationScreen(url:searchController.searchEcolodgesResult[index].url));
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
                                          imageUrl: searchController.searchEcolodgesResult[index].image,
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
                                    if (searchController.searchEcolodgesResult[index].maxDiscountPercent != null && searchController.searchEcolodgesResult[index].maxDiscountPercent! > 0)
                                      Positioned(
                                        right: Get.width * 0.10,
                                        top: 0,
                                        child: Container(
                                          height: 25,
                                          width: 40,
                                          decoration: const BoxDecoration(color: Color(0xffEA213B), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                                          child: Center(child: Text('${searchController.searchEcolodgesResult[index].maxDiscountPercent}%', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white))),
                                        ),
                                      )
                                    else
                                      const SizedBox(),
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
                                              searchController.searchEcolodgesResult[index].title,
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
                                                    searchController.searchEcolodgesResult[index].address,
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
                                          searchController.searchEcolodgesResult[index].minPrice == 0 ? 'تماس با پشتیبانی' : '${searchController.searchEcolodgesResult[index].minPrice?.toString().beToman().seRagham()} ${checkCurrency(searchController.searchEcolodgesResult[index].currency)}/${searchController.searchEcolodgesResult[index].unitPrice}',
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.mainColor),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            if (!searchController.loadMore.value && searchController.nextLink.value == 'null') {
                              return const SizedBox();
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ]
            ])),
      ),
    );
  }

}
