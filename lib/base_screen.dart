import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/login_controller.dart';
import 'package:uspace_ir/controllers/search_controller.dart';
import 'package:uspace_ir/pages/explore/explore_screen.dart';
import 'package:uspace_ir/pages/history/history_screen.dart';
import 'package:uspace_ir/pages/home/home_screen.dart';
import 'package:uspace_ir/pages/profile/profile_screen.dart';
import 'package:uspace_ir/app/widgets/search/search_screen.dart';

import 'app/widgets/bottom_sheets.dart';

class BasePage extends StatelessWidget {
  BasePage({Key? key}) : super(key: key);

  //test
  LoginController loginController = Get.put(LoginController());



  SearchController searchController = Get.put(SearchController());

  var pageIndex = 3.obs;

  final page = [
    ProfileScreen(),
    HistoryScreen(),
    ExploreScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: GestureDetector(
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
                  splashRadius: 20,
                  icon: SvgPicture.asset('assets/icons/bell_ic.svg'),
                  onPressed: () {
                    loginController.phoneNumberController.clear();
                    BottomSheets().loginBottomSheet();
                  },
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15,top: 15.0),
                  child: IconButton(
                    onPressed: (){},
                    splashRadius: 20,
                    icon: const Icon(Icons.menu,color: Colors.grey,),
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
                      child: InkWell(
                        onTap: (){
                          Get.to(SearchScreen(),transition: Transition.fadeIn);
                        },
                        child: TextField(
                          enabled: false,
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
                        picture: 'assets/icons/profile_nav_outline_ic.svg',
                        pictureSelected: 'assets/icons/profile_nav_fill_ic.svg',
                        text: "پروفایل",
                        index: 0),
                    myNavigationItem(
                        picture: 'assets/icons/paper_outline_ic.svg',
                        pictureSelected: 'assets/icons/paper_nav_fill_ic.svg',
                        text: 'تاریخچه',
                        index: 1),
                    myNavigationItem(
                        picture: 'assets/icons/location_pin_nav_outline_ic.svg',
                        pictureSelected:
                            'assets/icons/location_pin_nav_fill_ic.svg',
                        text: "جست و جو",
                        index: 2),
                    myNavigationItem(
                        picture: 'assets/icons/home_nav_outline_ic.svg',
                        pictureSelected: 'assets/icons/home_nav_fill_ic.svg',
                        text: 'صفحه اصلی',
                        index: 3),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  myNavigationItem({
    required String picture,
    required String pictureSelected,
    required String text,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        if(index ==0 && !loginController.isUserLogin.value){
          BottomSheets().loginBottomSheet();
        }else{
        pageIndex.value = index;
      }},
      child: Obx(() => SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(child: SizedBox()),
                pageIndex.value == index
                    ? SvgPicture.asset(pictureSelected)
                    : SvgPicture.asset(picture),
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
