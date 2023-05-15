import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/views/search/filter_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var dropDownValue = 'همه'.obs;

  var dropDownItems = [
    'همه',
    'بهترین ها',
    'محبوبترین ها',
    'پربازدیدترین ها',
    'جدیدترین',
    'تخفیف ها',
  ];
  PageController secondPageController = PageController();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0,right: 20,left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: SizedBox(
                  height: 25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(right: 4,left: 6),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color:AppColors.mainColor,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Row(
                        children: [
                          Text('اصفهان',style:Theme.of(context).textTheme.labelSmall!.copyWith(color:Colors.white)),
                          const SizedBox(width: 3,),
                          const Icon(Icons.close,color: Colors.white,size: 14,),
                        ],
                      ),
                    );
                  },),
                )),
                Stack(
                  children: [
                    IconButton(onPressed: (){
                      Get.to(FilterScreen(),transition: Transition.leftToRight);
                    },splashRadius: 20, icon: const Icon(Icons.tune_rounded)),
                    Positioned(
                      right: Get.width*0.022,
                      top: Get.width*0.025,
                      child: Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        width: 14,height:14,decoration: const BoxDecoration(
                        shape:BoxShape.circle,
                        color: AppColors.mainColor,
                      ),
                        child: Center(child: Text('2',textAlign: TextAlign.center,style:Theme.of(context).textTheme.labelSmall!.copyWith(color:Colors.white))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 2,),
                Obx(() => Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      items: dropDownItems
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: AppColors.disabledText),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: dropDownValue.value,
                      onChanged: (value) {
                        dropDownValue.value = value as String;
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: Get.width/3,
                        padding: const EdgeInsets.only(right: 8,left: 5,top: 5,bottom: 2),
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
                          width: 200,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          offset: const Offset(-20, 0),
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
                ),),
              ],
            ),
          ),
          SizedBox(
            height: Get.height + 85,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 25,);
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 15,top: 15),
                      itemBuilder: (context, index) {
                        return Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomCenter,
                          children: [
                            Positioned(
                                bottom: - Get.width * 0.025,
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black45,
                                          offset: Offset(
                                            0.0,
                                            0.0,
                                          ),
                                          blurRadius: 8.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 8.0,
                                          spreadRadius: 0.0,
                                        ),
                                      ]),
                                )),
                            Positioned(
                              right: 0,
                              bottom: Get.width * 0.015,
                              left: 0,
                              top: 15,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 175,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black45,
                                        offset: Offset(
                                          6.0,
                                          5.0,
                                        ),
                                        blurRadius: 8.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ),
                                    ]),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                clipBehavior: Clip.none,
                                width: MediaQuery.of(context).size.width,
                                height: 160,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CachedNetworkImage(
                                    imageUrl: "http://via.placeholder.com/320x150&text=image",
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                right: Get.width * 0.06,
                                bottom: Get.width * 0.15,
                                child: Text(
                                  "هتل سنتی سهروردی",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: Colors.white),
                                )),
                            Positioned(
                                right: Get.width * 0.05,
                                bottom: Get.width * 0.08,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/location_small_pin_ic.svg',
                                        color: Colors.white,
                                        width: 18),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "استان اصفهان،شهر اصفهان،خیابان میرداماد،انتهای کوچه یازدهم",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                )),
                            Positioned(
                              bottom: - Get.width * 0.03,
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child:Row(
                                  children: [
                                    const Spacer(),
                                    Text('241',style:Theme.of(Get.context!).textTheme.labelLarge),
                                    const SizedBox(width: 2,),
                                    const Icon(Icons.favorite_outline_rounded,color:AppColors.mainColor,size: 17,),
                                    const SizedBox(width: 10,),
                                    Text('26',style:Theme.of(Get.context!).textTheme.labelLarge),
                                    const SizedBox(width: 3,),
                                    SvgPicture.asset('assets/icons/comment_count_ic.svg',color: AppColors.mainColor,),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      },),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text('قبلی',style:Theme.of(context).textTheme.bodyMedium),
            SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                return Container(
                  width: 10,
                  decoration: BoxDecoration(
                    border:Border.all(),
                    color: Colors.red
                  ),
                );
              },),
            ),
            Text('بعدی',style:Theme.of(context).textTheme.bodyMedium),
          ],)
        ],
      ),
    );
  }
}
