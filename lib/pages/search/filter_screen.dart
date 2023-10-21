import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/format_amount.dart';
import 'package:uspace_ir/controllers/search_controller.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key? key}) : super(key: key);

  final _customTileExpanded1 = false.obs;
  final _customTileExpanded2 = false.obs;
  final _customTileExpanded3 = false.obs;
  final _showMore1 = false.obs;
  final _showMore2 = false.obs;
  final _showMore3 = false.obs;

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
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: Text(
                  'اعمال فیلتر',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/bell_ic.svg'),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu,
                            color: AppColors.disabledIcon),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Color(0xffF8F9FD)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, right: 15.0, left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Material(
                                child: IconButton(
                                    splashRadius: 20,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.close,
                                      color: AppColors.disabledIcon,
                                    )),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {},
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: AppColors.borderColor,
                                              width: 1)),
                                      child: Text('پاک کردن همه',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color:
                                                      AppColors.disabledText))),
                                ),
                              ),
                              const Spacer(),
                              Text('فیتلر',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.disabledText)),
                              const SizedBox(
                                width: 2,
                              ),
                              const Icon(Icons.tune_rounded,
                                  color: AppColors.disabledIcon),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xffF0F2F4),
                              borderRadius: BorderRadius.circular(26)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20.0, top: 3),
                              child: TextField(
                                style: Theme.of(context).textTheme.labelLarge,
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                    hintTextDirection: TextDirection.rtl,
                                    border: InputBorder.none,
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: InkWell(
                                        child: SvgPicture.asset(
                                          'assets/icons/search_ic.svg',
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                    hintText: "جستجوی نام اقامتگاه،شهر،روستا",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: AppColors.disabledIcon)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 18),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              color: Color(0xffEEF1FF),
                              borderRadius: BorderRadius.circular(14)),
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
                                    values: RangeValues(
                                        searchController.rangeStart.value,
                                        searchController.rangeEnd.value),
                                    labels: RangeLabels(
                                        '${formatAmount(searchController.rangeStart.value.round() * 500000)}تومان',
                                        '${formatAmount(searchController.rangeEnd.value.round() * 500000)}تومان'),
                                    onChanged: (value) {
                                      setRange(value.start, value.end);
                                    },
                                    min: 0,
                                    max: 100,
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() => Text(
                                        '${formatAmount(searchController.rangeStart.value.round() * 500000)} تومان',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge)),
                                    Obx(() => Text(
                                        '${formatAmount(searchController.rangeEnd.value.round() * 500000)} تومان',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() => Directionality(
                              textDirection: TextDirection.rtl,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  backgroundColor: Colors.transparent,
                                  collapsedBackgroundColor: Colors.transparent,
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "دسته بندی",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Color(0xff051726)),
                                      ),
                                    ],
                                  ),
                                  childrenPadding: const EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                    top: 0,
                                  ),
                                  trailing: Icon(
                                    _customTileExpanded1.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: const Color(0xff051726),
                                    size: 30,
                                  ),
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 12,
                                          );
                                        },
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _showMore1.value
                                            ? searchController
                                                    .categoryList.length +
                                                1
                                            : searchController
                                                        .categoryList.length ~/
                                                    2 +
                                                1,
                                        itemBuilder: (context, index) {
                                          if (index ==
                                                  searchController.categoryList
                                                          .length ~/
                                                      2 &&
                                              _showMore1.value == false) {
                                            return Row(
                                              children: [
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                TextButton.icon(
                                                  onPressed: () {
                                                    _showMore1.toggle();
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: AppColors.mainColor,
                                                    size: 20,
                                                  ),
                                                  label: Text('موارد بیشتر',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mainColor)),
                                                )
                                              ],
                                            );
                                          } else if (index ==
                                                  searchController
                                                      .categoryList.length &&
                                              _showMore1.value == true) {
                                            return Row(
                                              children: [
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                TextButton.icon(
                                                  onPressed: () {
                                                    _showMore1.toggle();
                                                  },
                                                  icon: Icon(
                                                    Icons.minimize_rounded,
                                                    color: AppColors.mainColor,
                                                    size: 20,
                                                  ),
                                                  label: Text('موارد کمتر',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mainColor)),
                                                )
                                              ],
                                            );
                                          } else {
                                            return SizedBox(
                                              height: 25,
                                              child: Row(children: [
                                                Obx(() => Checkbox(
                                                      value: searchController
                                                          .categoryList[index]
                                                              ['value']
                                                          .value,
                                                      shape:
                                                          ContinuousRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                      onChanged: (value) {
                                                        if (value == true) {
                                                          searchController
                                                              .filterList.add({
                                                            'type':'category',
                                                            'value': searchController
                                                                .categoryList[
                                                            index]['name']
                                                          });
                                                        } else {
                                                          searchController
                                                              .filterList.removeWhere((element) => element['value'] == searchController
                                                              .categoryList[
                                                          index]['name']
                                                          );
                                                        }
                                                        searchController
                                                            .categoryList[index]
                                                                ['value']
                                                            .value = value;
                                                      },
                                                      activeColor:
                                                          AppColors.mainColor,
                                                      // Change the color of the checkbox when it is checked
                                                      side: const BorderSide(
                                                          width: 2,
                                                          color: Color.fromRGBO(
                                                              82,
                                                              110,
                                                              255,
                                                              0.24)),
                                                    )),
                                                InkWell(
                                                  onTap: () {
                                                    if (searchController
                                                            .categoryList[index]
                                                                ['value']
                                                            .value ==
                                                        true) {
                                                      searchController
                                                          .categoryList[index]
                                                              ['value']
                                                          .value = false;
                                                      searchController
                                                          .filterList
                                                          .removeWhere((element) => element['value']==searchController
                                                          .categoryList[
                                                      index]['name']
                                                      );
                                                    } else {
                                                      searchController
                                                          .categoryList[index]
                                                              ['value']
                                                          .value = true;
                                                      searchController
                                                          .filterList.add({
                                                        'type':'category',
                                                        'value':searchController
                                                            .categoryList[
                                                        index]['name']
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                      searchController
                                                              .categoryList[
                                                          index]['name'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryTextColor)),
                                                ),
                                              ]),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    _showMore1.value
                                        ? const SizedBox(
                                            height: 12,
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                  onExpansionChanged: (ex) {
                                    _customTileExpanded1.value = ex;
                                  },
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(() => Directionality(
                              textDirection: TextDirection.rtl,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  backgroundColor: Colors.transparent,
                                  collapsedBackgroundColor: Colors.transparent,
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "نظرات اقامتگاه ها",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: const Color(0xff051726)),
                                      ),
                                    ],
                                  ),
                                  childrenPadding: const EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                    top: 0,
                                  ),
                                  trailing: Icon(
                                    _customTileExpanded2.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: const Color(0xff051726),
                                    size: 30,
                                  ),
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 10,
                                          );
                                        },
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _showMore2.value
                                            ? searchController
                                                    .commentList.length +
                                                1
                                            : searchController
                                                        .commentList.length ~/
                                                    2 +
                                                1,
                                        itemBuilder: (context, index) {
                                          if (index ==
                                              searchController
                                                  .commentList.length ~/2 && _showMore2.value == false){
                                            return Row(
                                              children: [
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                TextButton.icon(
                                                  onPressed: () {
                                                    _showMore2.toggle();
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: AppColors.mainColor,
                                                    size: 20,
                                                  ),
                                                  label: Text('موارد بیشتر',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mainColor)),
                                                ),
                                              ],
                                            );
                                          }else if(
                                          index == searchController.commentList.length && _showMore2.value == true
                                          ){
                                            return Row(
                                              children: [
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                TextButton.icon(
                                                  onPressed: () {
                                                    _showMore2.toggle();
                                                  },
                                                  icon: const Icon(
                                                    Icons.minimize_rounded,
                                                    color: AppColors.mainColor,
                                                    size: 20,
                                                  ),
                                                  label: Text('موارد کمتر',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                          color: AppColors
                                                              .mainColor)),
                                                ),
                                              ],
                                            );
                                          }else{
                                            return SizedBox(
                                            height: 25,
                                            child: Row(children: [
                                              Obx(() => Checkbox(
                                                value: searchController
                                                    .commentList[index]
                                                ['value']
                                                    .value,
                                                shape:
                                                ContinuousRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        4)),
                                                onChanged: (value) {
                                                  if(value == true){
                                                    searchController
                                                        .filterList.add({
                                                      'type':'comment',
                                                      'value': searchController
                                                          .commentList[
                                                      index]['name']
                                                    });
                                                  }else{
                                                    searchController
                                                        .filterList.removeWhere((element) => element['value'] == searchController
                                                        .commentList[
                                                    index]['name']
                                                    );
                                                  }
                                                  searchController
                                                      .commentList[index]
                                                  ['value']
                                                      .value = value;
                                                },
                                                activeColor:
                                                AppColors.mainColor,
                                                // Change the color of the checkbox when it is checked
                                                side: const BorderSide(
                                                    width: 2,
                                                    color: Color.fromRGBO(
                                                        82,
                                                        110,
                                                        255,
                                                        0.24)),
                                              )),
                                              InkWell(
                                                onTap: () {
                                                  if (searchController
                                                      .commentList[index]
                                                  ['value']
                                                      .value ==
                                                      true) {
                                                    searchController
                                                        .commentList[index]
                                                    ['value']
                                                        .value = false;
                                                    searchController
                                                        .filterList
                                                        .removeWhere((element) => element['value']==searchController
                                                        .commentList[
                                                    index]['name']
                                                    );
                                                  } else {
                                                    searchController
                                                        .commentList[index]
                                                    ['value']
                                                        .value = true;
                                                    searchController
                                                        .filterList.add({
                                                      'type':'comment',
                                                      'value':searchController
                                                          .commentList[
                                                      index]['name']
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                    searchController
                                                        .commentList[index]
                                                    ['name'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .copyWith(
                                                        color: AppColors
                                                            .primaryTextColor)),
                                              ),
                                            ]),
                                          );
                                          }
                                        },
                                      ),
                                    ),
                                    _showMore2.value
                                        ? const SizedBox(
                                            height: 12,
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                  onExpansionChanged: (ex) {
                                    _customTileExpanded2.value = ex;
                                  },
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(() => Directionality(
                              textDirection: TextDirection.rtl,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  backgroundColor: Colors.transparent,
                                  collapsedBackgroundColor: Colors.transparent,
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "شهر",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Color(0xff051726)),
                                      ),
                                    ],
                                  ),
                                  childrenPadding: const EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                    top: 0,
                                  ),
                                  trailing: Icon(
                                    _customTileExpanded3.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: const Color(0xff051726),
                                    size: 30,
                                  ),
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 10,
                                          );
                                        },
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _showMore3.value
                                            ? searchController.cityList.length +
                                                1
                                            : searchController.cityList.length ~/2+1,
                                        itemBuilder: (context, index) {
                                          if (index ==
                                              searchController
                                                  .cityList.length~/2&&_showMore3.value == false){
                                            return Row(
                                              children: [
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                TextButton.icon(
                                                  onPressed: () {
                                                    _showMore3.toggle();
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: AppColors.mainColor,
                                                    size: 20,
                                                  ),
                                                  label: Text('موارد بیشتر',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mainColor)),
                                                ),
                                              ],
                                            );
                                          }else if (
                                          index == searchController.cityList.length && _showMore3.value == true
                                          ){
                                            return Row(
                                              children: [
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                TextButton.icon(
                                                  onPressed: () {
                                                    _showMore3.toggle();
                                                  },
                                                  icon: const Icon(
                                                    Icons.minimize_rounded,
                                                    color: AppColors.mainColor,
                                                    size: 20,
                                                  ),
                                                  label: Text('موارد کمتر',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall!
                                                          .copyWith(
                                                          color: AppColors
                                                              .mainColor)),
                                                ),
                                              ],
                                            );
                                          }else{
                                            return SizedBox(
                                              height: 25,
                                              child: Row(children: [
                                                Obx(() => Checkbox(
                                                  value: searchController
                                                      .cityList[index]
                                                  ['value']
                                                      .value,
                                                  shape:
                                                  ContinuousRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          4)),
                                                  onChanged: (value) {
                                                    if(value == true){
                                                      searchController
                                                          .filterList.add({
                                                        'type':'city',
                                                        'value': searchController
                                                            .cityList[
                                                        index]['name']
                                                      });
                                                    } else{
                                                      searchController
                                                          .filterList.removeWhere((element) => element['value'] == searchController
                                                          .cityList[
                                                      index]['name']
                                                      );
                                                    }
                                                    searchController
                                                        .cityList[index]
                                                    ['value']
                                                        .value = value;
                                                  },
                                                  activeColor:
                                                  AppColors.mainColor,
                                                  // Change the color of the checkbox when it is checked
                                                  side: const BorderSide(
                                                      width: 2,
                                                      color: Color.fromRGBO(
                                                          82,
                                                          110,
                                                          255,
                                                          0.24)),
                                                )),
                                                InkWell(
                                                  onTap: () {
                                                    if (searchController
                                                        .cityList[index]
                                                    ['value']
                                                        .value ==
                                                        true) {
                                                      searchController
                                                          .categoryList[index]
                                                      ['value']
                                                          .value = false;
                                                      searchController
                                                          .filterList
                                                          .removeWhere((element) => element['value']==searchController
                                                          .cityList[
                                                      index]['name']
                                                      );
                                                    } else {
                                                      searchController
                                                          .categoryList[index]
                                                      ['value']
                                                          .value = true;
                                                      searchController
                                                          .filterList.add({
                                                        'type':'city',
                                                        'value':searchController
                                                            .cityList[
                                                        index]['name']
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                      searchController
                                                          .cityList[index]
                                                      ['name'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                          color: AppColors
                                                              .primaryTextColor)),
                                                ),
                                              ]),
                                            );
                                          }},
                                      ),
                                    ),
                                    _showMore3.value
                                        ? const SizedBox(
                                            height: 15,
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                  onExpansionChanged: (ex) {
                                    _customTileExpanded3.value = ex;
                                  },
                                ),
                              ),
                            )),
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
    searchController.rangeStart.value =
        start; //updating the value of Rx Variable.
    searchController.rangeEnd.value = end; //updating the value of Rx Variable.
  }
}
