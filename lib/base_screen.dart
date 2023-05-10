import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/views/home/home_screen.dart';

class BasePage extends StatelessWidget {
  BasePage({Key? key}) : super(key: key);

  var pageIndex = 3.obs;

  final page = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                centerTitle: false,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 15,top: 15.0),
                  child: IconButton(
                    onPressed: (){},
                    splashRadius: 20,
                    icon: Icon(Icons.menu,color: Colors.grey,),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15,top: 15.0),
                    child: IconButton(
                      splashRadius: 20,
                      icon: SvgPicture.asset('assets/icons/bell_ic.svg'),
                      onPressed: () {},
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, 70),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F2F4),
                      borderRadius: BorderRadius.circular(26)
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20,left: 20.0,top: 3),
                        child: TextField(
                          style: Theme.of(context).textTheme.labelLarge,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10),
                              child: InkWell(child: SvgPicture.asset('assets/icons/search_ic.svg',),onTap: (){},),
                            ),
                            hintText: "جستجوی نام اقامتگاه،شهر،روستا",
                            hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.disabledIcon)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ), //SliverAppBar
              SliverToBoxAdapter(
                child: Obx(
                  () => page[pageIndex.value],
                ),
              )
            ],
          ),
          bottomNavigationBar: Container(
            height: 80,
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(color: Color(0xffF0F2F4), width: 1.5))),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  myNavigationItem(
                      icon: const Icon(Icons.person_outline_rounded,
                          color: AppColors.disabledIcon),
                      iconSelected:
                          const Icon(Icons.person, color: AppColors.mainColor),
                      text: "پروفایل",
                      index: 0),
                  myNavigationItem(
                      icon: const Icon(Icons.description_outlined,
                          color: AppColors.disabledIcon),
                      iconSelected: const Icon(Icons.description,
                          color: AppColors.mainColor),
                      text: 'تاریخچه',
                      index: 1),
                  myNavigationItem(
                      icon: const Icon(Icons.location_on_outlined,
                          color: AppColors.disabledIcon),
                      iconSelected: const Icon(Icons.location_on,
                          color: AppColors.mainColor),
                      text: "جست و جو",
                      index: 2),
                  myNavigationItem(
                      icon: const Icon(Icons.home_outlined,
                          color: AppColors.disabledIcon),
                      iconSelected:
                          const Icon(Icons.home, color: AppColors.mainColor),
                      text: 'صفحه اصلی',
                      index: 3),
                ],
              ),
            ),
          )),
    );
  }


  myNavigationItem({
    required Icon icon,
    required Icon iconSelected,
    required String text,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        pageIndex.value = index;
      },
      child: Obx(() => SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(child: SizedBox()),
                pageIndex.value == index ? iconSelected : icon,
                const SizedBox(
                  height: 3,
                ),
                Text(
                  text,
                  style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(
                      color: pageIndex.value == index
                          ? AppColors.mainColor
                          : AppColors.disabledText),
                )
              ],
            ),
          )),
    );
  }
}
