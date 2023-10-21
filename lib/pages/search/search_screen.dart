import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/search_controller.dart';
import 'package:uspace_ir/pages/reservation/reservation_screen.dart';
import 'package:uspace_ir/pages/search/filter_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  SearchController searchController = Get.put(SearchController());

  RxInt itemCount = 5.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: false,
          centerTitle: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15.0),
            child: IconButton(
              splashRadius: 20,
              icon: SvgPicture.asset('assets/icons/bell_ic.svg'),
              onPressed: () {
                print(searchController.filterList.length);
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 15.0),
              child: IconButton(
                onPressed: () {},
                splashRadius: 20,
                icon: const Icon(
                  Icons.menu,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 70),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xffF0F2F4),
                  borderRadius: BorderRadius.circular(26)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20.0, top: 3),
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) {
                    },
                    style: Theme.of(Get.context!).textTheme.labelLarge,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: InkWell(
                            child: Hero(
                                tag: 'textfield',
                                child: SvgPicture.asset(
                                  'assets/icons/search_ic.svg',
                                )),
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
        ), //SliverAppBar
        SliverToBoxAdapter(
          child: SizedBox(
            width: Get.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: 25,
                        child: Obx(() => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: searchController.filterList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.only(right: 4, left: 6),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    children: [
                                      Text(
                                          searchController.filterList[index]
                                              ['value']!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(color: Colors.white)),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          searchController.filterList
                                              .removeWhere((element) =>
                                                  element['value'] ==
                                                  searchController
                                                          .filterList[index]
                                                      ['value']);
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )),
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            Get.to(FilterScreen(),
                                transition: Transition.leftToRight);
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(
                                Icons.tune_rounded,
                                size: 24,
                              ),
                              Obx(() => searchController.filterList.isEmpty
                                  ? SizedBox()
                                  : Positioned(
                                      left: Get.width * 0.033,
                                      bottom: Get.width * 0.03,
                                      child: Container(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        width: 14,
                                        height: 14,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.mainColor,
                                        ),
                                        child: Center(
                                            child: Text(
                                                searchController
                                                    .filterList.length
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        color: Colors.white))),
                                      ),
                                    ))
                            ],
                          ),
                        ),
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
                              items: searchController.searchScreenDropDownItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color:
                                                      AppColors.disabledText),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: searchController
                                  .searchScreenDropDownValue.value,
                              onChanged: (value) {
                                searchController.searchScreenDropDownValue
                                    .value = value as String;
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 40,
                                width: Get.width / 3,
                                padding: const EdgeInsets.only(
                                    right: 8, left: 5, top: 5, bottom: 2),
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
                                    thumbVisibility:
                                        MaterialStateProperty.all(true),
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
                          return InkWell(
                            onTap: () {
                              Get.to(ReservationScreen());
                            },
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
                                      'https://minas.uspace.ir/spaces/minas/images/main/minas_uspace_1601187518.jpg',
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                      const Icon(
                                          Icons.broken_image_outlined),
                                    ),
                                  ),
                                ),
                                if (index == 2)
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
                                          child: Text('30%',
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
                                      "هتل سنتی سهروردی",
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
                                              'searchController.liveSearchResult.value!.ecolodges[index].address',
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
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () {
                      itemCount.value += 5;
                    },
                    borderRadius: BorderRadius.circular(2),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('موارد بیشتر',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.blue)),
                    )),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
