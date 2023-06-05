import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:readmore/readmore.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/custom_tab_indicator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:uspace_ir/controllers/dropdown_controller.dart';
import 'package:uspace_ir/views/reservation/reserve_room_screen.dart';

class ReservationScreen extends StatelessWidget {
  ReservationScreen({Key? key}) : super(key: key);

  PageController secondPageController = PageController();
  DropDownController dropDownController = Get.put(DropDownController());

  ///------->details text
  String roomInformation = """
  هتل سنتی شیران در شهر زیبای اصفهان، مربوط به دوره قاجار واقع شده است. خانه تاریخی محمد قلی شیران به عنوان یکی از آثار ملی ایران به ثبت رسیده است و پس از مرمت و احیا اکـنـون با نام هتل سنتی شیران آماده پذیرایی از مهمـانـان و گـردشگران داخـلی و خـارجی می باشد.
هتل سنتی شیران دارای 5 اتاق با طراحی داخلی متفاوت می باشد. این اتاق ها با نام های ناصرالدین شاه، فتحعلی شاه (شاه نشین)، مظفرالدین شاه، پریخان خانم و عباس میرزا نـام گذاری شده است. تمامی اتـاق ها دارای تخت هستند و حداکثر ظرفیت پذیرش 17 مهمـان را دارد. سرویس بهداشتی تمـام اتـاق ها اختصاصی است. سیستم سرمایش اتـاق های این هتل سنتی اسپلیت و سیستم گرمایش آن شوفاژ می باشد.""";

  String roomEquipments =
      """از جمله امکانات و خدماتی که هتل سنتی شیران اصفهان برای رفاه مهمانان گرامی در نـظـر گرفته می توان به جای پارک خودرو در مقابل هتل، پرسنل مسلط به زبـان انگلیسی و کـافی شاپ اشاره نمود. مهمـانـان این هتل سنتی می توانند در فضـای سنتی و دلنشین محوطـه و کـافی شـاپ لحظات خوشی را تجربه کنند.تخت هستند و حـداکـثـر ظرفـیت پـذیـرش 17 مهمان را دارد. سرویس بهداشتی تمام اتاق ها اختصاصی است. سیستم سرمـایش اتـاق های این هتل سنتی اسپلیت و سیستم گرمایش آن شوفاژ می باشد.""";

  String roomLocation =
      """هتل سنتی شیران اصفهان به دلیل آئینه کاری های کم نظیر در معماری داخلی خود، همچون الـمـاس می درخشد و می تواند بـه عـنـوان یـک جاذبه گردشگری منحصر بفرد مورد توجه گـردشگـران داخلی و خـارجی قرار گیرد. شهر اصفهان با بناهای تاریخی به جا مانده از دوران قاجار، عباسیان و صفوی همه ساله گردشگران داخلی و خارجی زیادی را به خود جلب می کند. از جمله آثار باستانی اصفهان می توان به میدان نقش جهان و مساجد و بازار آن، مسجد امام، کلیسای وانـک و مـحـله جـلـفـا، سی وسه پل، پل خواجو، کاخ عالی قـاپـو، کـاخ چهلستون، کاخ هشت بهشت، منار جنبان، آتشگاه، مدرسه چهار باغ اشاره کرد. اصفهان دارای جاذبه های طبیعی و تفریحی مانند باغ پرندگان، باغ گلها، آکواریوم، کوه صفه و پـارک جنگلی نـاژوان نیز می باشد.""";

  String importantLocationDistance =
      """فاصله تا فرودگاه بین المللی شهید بهشتی اصفهان --> 24.4 کیلومتر (28 دقیقه)
فاصله تا ایستگاه راه آهن اصفهان --> 24.5 کیلومتر (31 دقیقه)
فاصله تا پایانه مسافربری کاوه اصفهان --> 3.8 کیلومتر (9 دقیقه)
فاصله تا پایانه مسافربری صفه اصفهان --> 20.5 کیلومتر (28 دقیقه)
فاصله تا میدان نقش جهان و مسجد شیخ لطف الله --> 3.4 کیلومتر (9 دقیقه)
فاصله تا مسجد امام اصفهان --> 3.1 کیلومتر (9 دقیقه)
فاصله تا کاخ چهل ستون --> 2.7 کیلومتر (7 دقیقه)
فاصله تا مدرسه چهار باغ --> 3.5 کیلومتر (11 دقیقه)
فاصله تا پل خواجو --> 5.7 کیلومتر (16 دقیقه)
فاصله تا سی و سی پل --> 4 کیلومتر (10 دقیقه)
فاصله تا کاخ هشت بهشت --> 5.1 کیلومتر (14دقیقه)
فاصله تا باغ گلهای اصفهان --> 8.4 کیلومتر (18 دقیقه)
فاصله تا باغ پرندگان --> 11.4 کیلومتر (22 دقیقه)
فاصله تا اکواریوم اصفهان --> 10.8 کیلومتر (20 دقیقه)
فاصله تا منارجنبان --> 9.1 کیلومتر (22 دقیقه)
فاصله تا نزدیک ترین ایستگاه مترو --> 650 متر (9 دقیقه به صورت پیاده)""";

  String facilitiesAndFeatures = """
  اسپلیت
  ایوان
  پرسنل مسلط به انگلیسی
  حمام مستقل
  شوفاژ
  سرویس بهداشتی""";

  ////////////////////
  ////-------> comment text
  String commentText =
      """سلام من در تاريخ ١٠و١١فروردين ١٤٠٢ به همراه خانواده ام اقامت داشتم ،و چهار اتاق رزرو كرده بوديم كه يكي از يكي قشنگتر بود ما كه خييلي لذت برديم از سكوت و آرامش و تميزي وصبحانه عالي و پرسنل محترم از هر لحاظ عالي بود و ما دلمون نميخواست حتي به مكانهاي ديدني بريم انقدر عالي بود من در اتاق پريخان خانوم اقامت داشتم واقعا زيبا بود""";

  var selectedDate = DateTime.now().obs;
  RxBool isDateSelected = false.obs;
  RxBool isDurationSelected = false.obs;
  RxBool isFave = false.obs;
  final dropDownValue = ''.obs;

  final List<String> dropDownItems = [
    'هال برد',
    'فول برد',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 2,
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/icons/bell_ic.svg',
                              color: AppColors.disabledIcon,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward_rounded,
                                color: AppColors.disabledIcon)),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildBody(),
                )
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                comments(),
                details(),
                rooms(),
              ],
            )),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10.0),
          child: FloatingActionButton(
              backgroundColor: AppColors.mainColor,
              onPressed: () {},
              child: SvgPicture.asset('assets/icons/chat_ic.svg')),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }

  _buildBody() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: MediaQuery.of(Get.context!).size.width,
          height: 200,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: PageView.builder(
              scrollDirection:
                  axisDirectionToAxis(flipAxisDirection(AxisDirection.right)),
              allowImplicitScrolling: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              controller: secondPageController,
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(boxShadow: [
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
                        ], borderRadius: BorderRadius.circular(25)),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 170,
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://via.placeholder.com/320x150&text=image",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.broken_image_outlined),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: Get.width * 0.18,
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                const BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1.2,
                                    blurRadius: 2.75,
                                    offset: Offset(-1.5, 0)),
                                BoxShadow(
                                    color: AppColors.mainColor.withOpacity(0.1),
                                    spreadRadius: 1.2,
                                    blurRadius: 2.75,
                                    offset: const Offset(-1.5, 0))
                              ],
                              shape: BoxShape.circle),
                          child: Center(
                              child: IconButton(
                            splashRadius: 18,
                            onPressed: () {
                              if (index != 2) {
                                secondPageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.mainColor,
                              size: 18,
                            ),
                            padding: EdgeInsets.zero,
                            alignment: Alignment.center,
                          ))),
                    ),
                    Positioned(
                      right: 10,
                      top: Get.width * 0.18,
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                const BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1.2,
                                    blurRadius: 2.75,
                                    offset: Offset(1.5, 0)),
                                BoxShadow(
                                    color: AppColors.mainColor.withOpacity(0.1),
                                    spreadRadius: 1.2,
                                    blurRadius: 2.75,
                                    offset: const Offset(1.5, 0))
                              ],
                              shape: BoxShape.circle),
                          child: IconButton(
                              splashRadius: 18,
                              onPressed: () {
                                if (index != 0) {
                                  secondPageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                }
                              },
                              alignment: Alignment.center,
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: AppColors.mainColor,
                                size: 18,
                              ))),
                    ),
                    Positioned(
                      bottom: Get.width * 0.045,
                      right: Get.width / 10 + 20,
                      left: Get.width / 10 + 20,
                      child: Container(
                        height: 38,
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
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                              child: Text(
                                  'اتاق 3 تخته پریخان خانم هتل سنتی شیران_اصفهان',
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style:
                                      Theme.of(context).textTheme.labelMedium)),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    isFave.toggle();
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Obx(() => Icon(
                        isFave.value
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isFave.value ? Colors.red : null,
                        size: 23)),
                  )),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset('assets/icons/share_line_ic.svg'),
                  )),
              const Spacer(),
              Text('هتل سنتی سهرودی_اصفهان',
                  style: Theme.of(Get.context!).textTheme.displayMedium),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('9.4/10',
                  textDirection: TextDirection.rtl,
                  style: Theme.of(Get.context!).textTheme.labelSmall),
              const SizedBox(
                width: 5,
              ),
              Text('(39.852 بازدید کننده)',
                  textDirection: TextDirection.rtl,
                  style: Theme.of(Get.context!).textTheme.labelSmall),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                    'استان اصفهان،شهر اصفهان، خیابان میرداماد،انتهای کوچه یازدهم',
                    textDirection: TextDirection.rtl,
                    style: Theme.of(Get.context!).textTheme.labelSmall),
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                'assets/icons/location_pin_nav_outline_ic.svg',
                width: 15,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(children: [
                  Text("نفر",
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.grayColor)),
                  Text('15',
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.grayColor)),
                  Text('ظرفیت: ',
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.grayColor)),
                  const SizedBox(width: 5),
                  SvgPicture.asset('assets/icons/capacity_ic.svg',
                      width: 20, color: AppColors.grayColor),
                ]),
                const SizedBox(height: 20),
                Row(children: [
                  Text("واحد",
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.grayColor)),
                  Text('15',
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.grayColor)),
                  Text('اتاق ها: ',
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.grayColor)),
                  const SizedBox(width: 5),
                  SvgPicture.asset('assets/icons/rooms_ic.svg',
                      width: 20, color: AppColors.grayColor),
                ]),
              ],
            ),
            const SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(children: [
                  Text('14:00',
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.grayColor)),
                  Text('زمان تحویل: ',
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.grayColor)),
                  const SizedBox(width: 5),
                  SvgPicture.asset('assets/icons/delivery_time_ic.svg',
                      width: 20, color: AppColors.grayColor),
                ]),
                const SizedBox(height: 20),
                Row(children: [
                  Text('14:00',
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.grayColor)),
                  Text('زمان تخلیه: ',
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.grayColor)),
                  const SizedBox(width: 5),
                  SvgPicture.asset('assets/icons/discharge_time_ic.svg',
                      width: 20, color: AppColors.grayColor),
                ]),
              ],
            ),
          ]),
        ),
        const SizedBox(
          height: 30,
        ),
        const TabBar(
            labelColor: AppColors.primaryTextColor,
            unselectedLabelColor: AppColors.disabledText,
            labelPadding: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(horizontal: 20),
            indicator: CustomTabIndicator(
              color: AppColors.mainColor,
              indicatorHeight: 3,
              radius: 4,
            ),
            tabs: [
              Tab(
                  child: Center(
                child: Text(
                  "نظرات",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )),
              Tab(
                  child: Center(
                child: Text(
                  "توضیحات",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )),
              Tab(
                  child: Center(
                child: Text(
                  "اتاق ها",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )),
            ])
      ],
    );
  }

  details() {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Container(
            height: 1,
            width: Get.width,
            color: Colors.black.withOpacity(0.1),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('اطلاعات اقامتگاه',
                      style: Theme.of(Get.context!).textTheme.bodySmall),
                  const SizedBox(
                    height: 5,
                  ),
                  ReadMoreText(
                    roomInformation,
                    textAlign: TextAlign.justify,
                    style: Theme.of(Get.context!).textTheme.titleSmall,
                    trimLines: 4,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    lessStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 10, color: Colors.blue),
                    trimCollapsedText: 'نمایش بیشتر',
                    trimExpandedText: 'نمایش کمتر',
                    moreStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 10, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text('امکانات اقامتگاه',
                      style: Theme.of(Get.context!).textTheme.bodySmall),
                  const SizedBox(
                    height: 5,
                  ),
                  ReadMoreText(
                    roomEquipments,
                    textAlign: TextAlign.justify,
                    style: Theme.of(Get.context!).textTheme.titleSmall,
                    trimLines: 4,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    lessStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 10, color: Colors.blue),
                    trimCollapsedText: 'نمایش بیشتر',
                    trimExpandedText: 'نمایش کمتر',
                    moreStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 10, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text('موقعیت جغرافیایی',
                      style: Theme.of(Get.context!).textTheme.bodySmall),
                  const SizedBox(
                    height: 5,
                  ),
                  ReadMoreText(
                    roomLocation,
                    textAlign: TextAlign.justify,
                    style: Theme.of(Get.context!).textTheme.titleSmall,
                    trimLines: 4,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    lessStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 10, color: Colors.blue),
                    trimCollapsedText: 'نمایش بیشتر',
                    trimExpandedText: 'نمایش کمتر',
                    moreStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 10, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                      'فاصله (تقریبی) این هتل سنتی تا جاذبه های گردشگری و مکان های مهم',
                      style: Theme.of(Get.context!).textTheme.bodySmall),
                  const SizedBox(
                    height: 5,
                  ),
                  ReadMoreText(
                    importantLocationDistance,
                    textAlign: TextAlign.justify,
                    style: Theme.of(Get.context!).textTheme.titleSmall,
                    trimLines: 4,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    lessStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 10, color: Colors.blue),
                    trimCollapsedText: 'نمایش بیشتر',
                    trimExpandedText: 'نمایش کمتر',
                    moreStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 10, color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text('ادرس اقامتگاه',
                      style: Theme.of(Get.context!).textTheme.bodySmall),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      'استان اصفهان،شهر اصفهان،خیابان میرداماد،انتهای کوچه یازدهم',
                      style: Theme.of(Get.context!).textTheme.titleSmall),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'جستجو بر روی نقشه',
                        style: Theme.of(Get.context!)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColors.mainColor),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 165,
                    width: Get.width,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(33.86834369769126, 57.428369220286626),
                        minZoom: 3,
                        maxZoom: 20,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName:
                              'dev.fleaflet.flutter_map.example',
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            rotate: true,
                            width: 80,
                            height: 80,
                            point:
                                LatLng(33.86834369769126, 57.428369220286626),
                            builder: (ctx) => const Icon(
                              Icons.location_on,
                              size: 35,
                              color: Colors.red,
                            ),
                            anchorPos: AnchorPos.align(AnchorAlign.center),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('امکانات و ویژگی ها',
                      style: Theme.of(Get.context!).textTheme.bodySmall),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(facilitiesAndFeatures,
                      textAlign: TextAlign.end,
                      style: Theme.of(Get.context!).textTheme.titleSmall),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              )),
        ]),
      ),
    );
  }

  importantPoints() {
    return ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 1,
                width: Get.width,
                color: Colors.black.withOpacity(0.1),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('رزرو کودکان',
                        style: Theme.of(Get.context!).textTheme.bodySmall),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'اقامت کودکان کمتر از 5 سال رایگان می باشد.',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('شرایط کنسلی رزرو اقامتگاه',
                        style: Theme.of(Get.context!).textTheme.bodySmall),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      """در صورت کنسلی تا 48 ساعت قبل از ورود و ایام تعطیلات، هزینه شب اول کسر می‌گردد پس از آن کل هزینه به عنوان جریمه محاسبه خواهد شد. در صورت کنسلی رزرو های تاریخ 25 اسفند تا 13 فروردین به هیچ عنوان هزینه ای عودت داده نخواهد شد.
همچنین هزینه کنسلینگ سامانه یواسپیس، 10 درصد می باشد که به هزینه کنسلینگ اقامتگاه افزوده می شود.""",
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('کنسلی در نوروز یا ایام پیک',
                        style: Theme.of(Get.context!).textTheme.bodySmall),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      """کنسلی در نوروز (۲۰ اسفند تا ۲۰ فروردین)، تعطیلات رسمی و ایام پیک سفر ممکن است با قوانین کنسلی عادی اقامتگاه متفاوت باشد. لطفا قبل از کنسلی برای دریافت شرایط با سایت تماس بگیرید یا از طریق ارسال تیکت در بخش مدیریت سفارشات خود، پیگیر باشید""",
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('قوانین و مقررات اقامتگاه',
                        style: Theme.of(Get.context!).textTheme.bodySmall),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      """ارائه مدارک محرمیت در زمان پذیرش الزامی است.
هتل سنتی شیران اصفهان از پذیرش حیوانات خانگی معذور است.
ارائه مدارک محرمیت معتبر در زمان پذیرش الزامی است.
هتل از پذیرش حیوانات خانگی معذور است.
با توجه به تفاوت نرخ و شرایط پذیرش مهمانان خارجی، قبل از قطعی کردن رزرو با پشتیبانی هماهنگ کنید.""",
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(Get.context!).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(children: [
                            Text("نفر",
                                textDirection: TextDirection.rtl,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall),
                            Text('15',
                                textDirection: TextDirection.rtl,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall),
                            Text('ظرفیت: ',
                                textDirection: TextDirection.rtl,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall),
                            const SizedBox(width: 5),
                            SvgPicture.asset(
                              'assets/icons/capacity_ic.svg',
                              width: 20,
                            ),
                          ]),
                          const SizedBox(height: 20),
                          Row(children: [
                            Text("واحد",
                                textDirection: TextDirection.rtl,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall),
                            Text('15',
                                textDirection: TextDirection.rtl,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall),
                            Text('اتاق ها: ',
                                textDirection: TextDirection.rtl,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall),
                            const SizedBox(width: 5),
                            SvgPicture.asset(
                              'assets/icons/rooms_ic.svg',
                              width: 20,
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(children: [
                            Text('14:00',
                                textDirection: TextDirection.rtl,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall),
                            Text('زمان تحویل: ',
                                textDirection: TextDirection.rtl,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall),
                            const SizedBox(width: 5),
                            SvgPicture.asset(
                              'assets/icons/delivery_time_ic.svg',
                              width: 20,
                            ),
                          ]),
                          const SizedBox(height: 20),
                          Row(children: [
                            Text('14:00',
                                textDirection: TextDirection.rtl,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall),
                            Text('زمان تخلیه: ',
                                textDirection: TextDirection.rtl,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .labelSmall),
                            const SizedBox(width: 5),
                            SvgPicture.asset(
                              'assets/icons/discharge_time_ic.svg',
                              width: 20,
                            ),
                          ]),
                        ],
                      ),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  rooms() {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          child: Column(children: [
            Container(
              height: 1,
              width: Get.width,
              color: Colors.black.withOpacity(0.1),
            ),
            Container(
                width: Get.width,
                height: 50,
                color: AppColors.mainColor.withOpacity(0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 35,
                        width: Get.width / 2 - 75,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.7, color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(children: [
                            const Icon(Icons.arrow_drop_down_rounded,
                                color: AppColors.disabledIcon),
                            const Spacer(),
                            Obx(() => isDurationSelected.value
                                ? SizedBox()
                                : Text('به مدت',
                                    style: Theme.of(Get.context!)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            color: AppColors.disabledText))),
                            const SizedBox(width: 5),
                            SvgPicture.asset('assets/icons/calendar_ic.svg'),
                          ]),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Jalali? picked = await showPersianDatePicker(
                          context: Get.context!,
                          initialDate: Jalali.now(),
                          firstDate: Jalali.now(),
                          lastDate: Jalali(1404, 1),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData(
                                dialogTheme: DialogTheme(
                                  contentTextStyle: Theme.of(Get.context!)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.red),
                                  titleTextStyle: TextStyle(color: Colors.red),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        var label = picked?.toDateTime();
                        print(picked);
                        if (picked != null) {
                          isDateSelected.value = true;
                        }
                      },
                      child: Container(
                          height: 35,
                          width: Get.width / 2 - 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.7, color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(children: [
                              const Icon(Icons.arrow_drop_down_rounded,
                                  color: AppColors.disabledIcon),
                              const Spacer(),
                              Obx(
                                () => isDateSelected.value
                                    ? Text(
                                        '${selectedDate.value.toJalali().year}/${selectedDate.value.toJalali().month}/${selectedDate.value.toJalali().day}  ',
                                        style: Theme.of(Get.context!)
                                            .textTheme
                                            .labelMedium)
                                    : Text('تاریخ ورورد',
                                        style: Theme.of(Get.context!)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                                color: AppColors.disabledText)),
                              ),
                              const SizedBox(width: 5),
                              SvgPicture.asset('assets/icons/calendar_ic.svg'),
                            ]),
                          )),
                    ),
                  ],
                )),
            ListView.separated(
              itemCount: 5,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 20,
                );
              },
              itemBuilder: (context, index) {
                return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 110,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      'اتاق سه تخته پریخان خانم هتل سنتی شیران_اصفهان',
                                      softWrap: true,
                                      textDirection: TextDirection.rtl,
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .labelSmall),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(children: [
                                                Text('1 تخت دبل',
                                                    style: Theme.of(
                                                            Get.context!)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: AppColors
                                                                .disabledText)),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                const Icon(
                                                  Icons.done_all_rounded,
                                                  color: AppColors.disabledIcon,
                                                  size: 15,
                                                ),
                                              ]),
                                              const SizedBox(height: 8),
                                              Row(children: [
                                                Text('صبحانه',
                                                    style: Theme.of(
                                                            Get.context!)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: AppColors
                                                                .disabledText)),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                const Icon(
                                                    Icons.done_all_rounded,
                                                    color:
                                                        AppColors.disabledIcon,
                                                    size: 15),
                                              ]),
                                            ]),
                                        const SizedBox(width: 15),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(children: [
                                                Text('حمام مستقل',
                                                    style: Theme.of(
                                                            Get.context!)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: AppColors
                                                                .disabledText)),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                const Icon(
                                                    Icons.done_all_rounded,
                                                    color:
                                                        AppColors.disabledIcon,
                                                    size: 15),
                                              ]),
                                              const SizedBox(height: 8),
                                              Row(children: [
                                                Text('توالت فرنگی',
                                                    style: Theme.of(
                                                            Get.context!)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: AppColors
                                                                .disabledText)),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                const Icon(
                                                    Icons.done_all_rounded,
                                                    color:
                                                        AppColors.disabledIcon,
                                                    size: 15),
                                              ]),
                                            ]),
                                        const SizedBox(width: 15),
                                        index == 1
                                            ? const SizedBox()
                                            : Obx(() => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 6.0),
                                                  child: Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton2(
                                                        isExpanded: true,
                                                        hint: Text(
                                                          'انتخاب نوع پکیچ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .copyWith(
                                                                  fontSize: 8,
                                                                  color: AppColors
                                                                      .mainColor),
                                                        ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                                fontSize: 8),
                                                        items: dropDownController
                                                            .dropDownItems
                                                            .map(
                                                                (selectedType) {
                                                          return DropdownMenuItem(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            value: selectedType,
                                                            child: Text(
                                                              selectedType,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .grayColor),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          dropDownController
                                                              .setSelected(
                                                                  value!);
                                                        },
                                                        value: dropDownController
                                                                    .dropDownValue
                                                                    .value ==
                                                                ""
                                                            ? null
                                                            : dropDownController
                                                                .dropDownValue
                                                                .value,
                                                        buttonStyleData:
                                                            ButtonStyleData(
                                                          height: 25,
                                                          width:
                                                              Get.width / 4.2,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5,
                                                                  left: 0,
                                                                  top: 0,
                                                                  bottom: 2),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                              width: 0.5,
                                                              color: AppColors
                                                                  .mainColor,
                                                            ),
                                                          ),
                                                        ),
                                                        iconStyleData:
                                                            const IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down_rounded,
                                                          ),
                                                          iconEnabledColor:
                                                              AppColors
                                                                  .mainColor,
                                                        ),
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                                elevation: 2,
                                                                width:
                                                                    Get.width /
                                                                        4.2,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              12),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              12)),
                                                                ),
                                                                offset:
                                                                    const Offset(
                                                                        0, 0),
                                                                direction:
                                                                    DropdownDirection
                                                                        .textDirection,
                                                                scrollbarTheme:
                                                                    ScrollbarThemeData(
                                                                  radius: const Radius
                                                                      .circular(40),
                                                                  thickness:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                              6),
                                                                  thumbVisibility:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                              true),
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                      ]),
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Obx(() => InkWell(
                                              onTap: () {
                                                dropDownController.dropDownValue
                                                            .value ==
                                                        ""
                                                    ? null
                                                    : Get.to(
                                                        RoomReservationScreen());
                                              },
                                              child: Container(
                                                width: Get.width / 4.2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: dropDownController
                                                              .dropDownValue
                                                              .value ==
                                                          ""
                                                      ? AppColors.grayColor
                                                      : AppColors.mainColor,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 6.0),
                                                  child: Center(
                                                      child: Text(
                                                    'رزرو اتاق',
                                                    style: Theme.of(
                                                            Get.context!)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 10),
                                                  )),
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.mainColor,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6.0),
                                            child: Center(
                                                child: Text(
                                                    '2,000,000 تومان / یک شب',
                                                    softWrap: true,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: Theme.of(
                                                            Get.context!)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            fontSize: 8,
                                                            color: AppColors
                                                                .mainColor))),
                                          ),
                                        ),
                                      ])
                                ]),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: Get.width / 4.5,
                              height: Get.width / 4.5,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "http://via.placeholder.com/320x150&text=image",
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.broken_image_outlined),
                              ),
                            ),
                          ),
                        ]));
              },
            )
          ])),
    );
  }

  comments() {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 1,
              width: Get.width,
              color: Colors.black.withOpacity(0.1),
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBarIndicator(
                              rating: 4.0,
                              itemCount: 5,
                              itemSize: 17.0,
                              physics: const BouncingScrollPhysics(),
                              unratedColor: AppColors.grayColor,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                              textDirection: TextDirection.rtl,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star_rounded,
                                color: Color(0xffFFC700),
                              ),
                            ),
                            const Spacer(),
                            Text('علی اصغر قاسمی کفاش',
                                style:
                                    Theme.of(Get.context!).textTheme.bodySmall),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              clipBehavior: Clip.hardEdge,
                              width: 35,
                              height: 35,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "http://via.placeholder.com/320x150&text=image",
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.broken_image_outlined),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 48.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ReadMoreText(
                                commentText,
                                textAlign: TextAlign.justify,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: AppColors.grayColor),
                                trimLines: 4,
                                textDirection: TextDirection.rtl,
                                trimMode: TrimMode.Line,
                                lessStyle: Theme.of(Get.context!)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 10, color: Colors.blue),
                                trimCollapsedText: 'نمایش بیشتر',
                                trimExpandedText: 'نمایش کمتر',
                                moreStyle: Theme.of(Get.context!)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 10, color: Colors.blue),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '14 تیر 1402',
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontSize: 10, 
                                              color: AppColors.grayColor),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    const Spacer(),
                                    InkWell(
                                        onTap: () {
                                        },
                                        child: SvgPicture.asset(
                                            'assets/icons/reply_ic.svg')),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, top: 5.0),
                                      child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          onTap: () {
                                            print('reply');
                                          },
                                          child: Text('پاسخ',
                                              style: Theme.of(Get.context!)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      color:
                                                          AppColors.mainColor,
                                                      fontSize: 10))),
                                    ),
                                  ])
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                itemCount: 6),
          ],
        ),
      ),
    );
  }
}
