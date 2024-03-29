import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/controllers/base_controller.dart';
import 'package:uspace_ir/controllers/history_controller.dart';
import 'package:uspace_ir/controllers/home_controller.dart';
import 'package:uspace_ir/controllers/search_controller.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/pages/history/history_screen.dart';
import 'package:uspace_ir/pages/home/home_screen.dart';
import 'package:uspace_ir/pages/profile/profile_screen.dart';
import 'package:uspace_ir/pages/search/live_search_screen.dart';
import 'package:uspace_ir/pages/search/search_screen.dart';
import 'package:uspace_ir/widgets/bottom_sheets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  //test
  // final LoginController loginController = Get.put(LoginController());

  final RxBool loading = false.obs;

  final BaseController baseController = Get.put(BaseController());
  final UserController userController = Get.put(UserController(),permanent: true);
  final HistoryController historyController = Get.put(HistoryController(),permanent: true);
  final SearchController searchController = Get.put(SearchController(),permanent: true);
  final HomeController homeController = Get.put(HomeController(),permanent: true);

  final RefreshController refreshController =
  RefreshController(initialRefresh: false,);


  final page = [
    ProfileScreen(),
    HistoryScreen(),
    SearchScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        if(loading.value == true){
          return false;
        }
        if(baseController.pageIndex.value != 3){
          baseController.pageIndex.value = 3;
          return false;
        }
        else{
          return true;
        }
      },
      child: GestureDetector(
        onTap: () {
          return FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          top: false,
          child: Scaffold(
              body: SmartRefresher(
                enablePullDown: true,
                physics: const BouncingScrollPhysics(),
                controller: refreshController,
                onRefresh: onRefresh,
                child: CustomScrollView(
                  controller: searchController.searchScrollController,
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
                        Hive.box(userBox).delete(userCart);
                      },
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15,top: 15.0),
                      child: IconButton(
                        onPressed: (){
                        },
                        splashRadius: 20,
                        icon: const Icon(Icons.menu,color: Colors.grey,),
                      ),
                    ),
                  ],
                  bottom:
                  PreferredSize(
                    preferredSize: const Size(double.infinity,70),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xffF0F2F4),
                          borderRadius: BorderRadius.circular(26)
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(26) ,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20,left: 20.0,top: 3),
                            child: InkWell(
                              onTap: (){
                                if(baseController.pageIndex.value != 2){
                                  Get.to(LiveSearchScreen());
                                }
                              },
                              child: Hero(
                                tag:'SearchBar',
                                child: Material(
                                  child: Obx(() => TextField(
                                    enabled:  baseController.pageIndex.value == 2 ? true :false,
                                    style: Theme.of(context).textTheme.labelLarge,
                                    textDirection: TextDirection.rtl,
                                    controller: searchController.searchTextFieldController,
                                    onTap: () {
                                      if (searchController.searchTextFieldController.selection ==
                                          TextSelection.fromPosition(TextPosition(
                                              offset:
                                              searchController.searchTextFieldController.text.length -
                                                  1))) {
                                        searchController.searchTextFieldController.selection =
                                            TextSelection.fromPosition(TextPosition(
                                                offset:searchController.searchTextFieldController.text.length));
                                      }
                                    },
                                    onChanged: (value) {
                                      searchController.searchWithFilter(value);
                                    },
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
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ),
                ),
                    SliverToBoxAdapter(
                      child: Obx(
                        () => page[baseController.pageIndex.value],
                      ),
                    )
                  ],
                ),
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
        if(index == 1 && userController.lastReserveCode.isEmpty){
          BottomSheets().orderCode();
        }
        searchController.searchTextFieldController.clear();
        searchController.searchScrollController.animateTo(0, duration: const Duration(microseconds: 1), curve: Curves.linear);
        if(index == 2 && searchController.searchEcolodgesResult.isEmpty){
          searchController.searchWithFilter('');
        }
        if(index != 2 ){
          searchController.resetFilter();
        }
          baseController.pageIndex.value = index;
        },
      child: Obx(() => SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(child: SizedBox()),
                baseController.pageIndex.value == index
                    ? SvgPicture.asset(pictureSelected)
                    : SvgPicture.asset(picture),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  text,
                  style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(
                      color: baseController.pageIndex.value == index
                          ? AppColors.mainColor
                          : AppColors.disabledText),
                )
              ],
            ),
          )),
    );
  }

  void onRefresh() {
    switch (baseController.pageIndex.value){
      case 3:
        homeController.retryConnection();
        break;
      case 2:
        searchController.searchEcolodgesResult.clear();
        searchController.searchWithFilter(searchController.searchTextFieldController.text);
        break;
      case 1:
    }
    refreshController.refreshCompleted();
  }

}
