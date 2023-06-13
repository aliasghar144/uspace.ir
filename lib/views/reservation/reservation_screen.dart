import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/custom_tab_indicator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:uspace_ir/app/widgets/textfield.dart';
import 'package:uspace_ir/controllers/dropdown_controller.dart';
import 'package:uspace_ir/views/reservation/reserve_room_screen.dart';

class ReservationScreen extends StatelessWidget {
  ReservationScreen({Key? key}) : super(key: key);

  PageController secondPageController = PageController();
  DropDownController dropDownController = Get.put(DropDownController());

  List facilities = [
    'تخت دبل',
    'تعداد پله:بدون پله',
    'تعداد خواب:بدون خواب',
    'نوع واحد:سنتی',
    'توالت فرنگی مستقل',
    'متراژ:20متر',
    'چشم انداز:حیاط',
    'حمام مستقل',
    'توالت فرنگی',
    'صبحانه',
    'مینی بار ',
    'نور گیر',
    'شوفاژ',
    'یخچال',
    'کافی شاپ',
    'اینترنت رایگان',
    'صندوق امانات'
  ].obs;

  ///-------details text
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

  ///---------------------------------------

  ///--------create comment
  ///
  RxBool isTextFieldSelected = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  ///---------------------------------------

  ////////////////////
  ////-------> comment text
  String commentText =
      """سلام من در تاريخ ١٠و١١فروردين ١٤٠٢ به همراه خانواده ام اقامت داشتم ،و چهار اتاق رزرو كرده بوديم كه يكي از يكي قشنگتر بود ما كه خييلي لذت برديم از سكوت و آرامش و تميزي وصبحانه عالي و پرسنل محترم از هر لحاظ عالي بود و ما دلمون نميخواست حتي به مكانهاي ديدني بريم انقدر عالي بود من در اتاق پريخان خانوم اقامت داشتم واقعا زيبا بود""";

  var selectedDate = DateTime.now().obs;
  RxBool isDateSelected = false.obs;
  RxBool isDurationSelected = false.obs;
  RxBool isFave = false.obs;

  RxList<RxBool> showMore =
      [false.obs, false.obs, false.obs, false.obs, false.obs].obs;

  RxInt selectedPackageIndex = 100.obs;
  RxInt selectedPackageId = 100.obs;

  final durationDropDownValue = 'به مدت: 1 شب'.obs;

  final List<String> durationDropDownItems = [
    'به مدت: 1 شب',
    'به مدت: 2 شب',
    'به مدت: 3 شب',
    'به مدت: 5 شب',
    'به مدت: 6 شب',
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
                  pinned: true,
                  floating: true,
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 16),
                    child: IconButton(
                        splashRadius: 20,
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/bell_ic.svg',
                        )),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
              onPressed: () {
                Get.bottomSheet(
                    SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    icon: const Icon(
                                      Icons.cancel_rounded,
                                      color: AppColors.grayColor,
                                    )),
                                Text('ثبت نظر برای هتل سنتی شیران _ اصفهان',
                                    style: Theme.of(Get.context!)
                                        .textTheme
                                        .labelLarge),
                              ]),
                          const SizedBox(
                            height: 15,
                          ),
                          FocusScope(
                            child: Focus(
                              onFocusChange: (value) {
                                isTextFieldSelected.value = value;
                              },
                              child: Obx(() => MyTextField(
                                    label: 'نام و نام خانوادگی',
                                    textEditingController: nameController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[ا-ی ئ و ]'))
                                    ],
                                    maxline: 1,
                                    onEditingComplete: () {
                                      isTextFieldSelected.value = false;
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    keyboardType: TextInputType.name,
                                    iconButton: isTextFieldSelected.value
                                        ? IconButton(
                                            onPressed: () {
                                              nameController.clear();
                                            },
                                            splashRadius: 20,
                                            icon: SvgPicture.asset(
                                                'assets/icons/close_ic.svg'))
                                        : null,
                                    textInputAction: TextInputAction.next,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          MyTextField(
                            label: 'پست الکترونیکی',
                            hintText: 'پست الکترونیکی (اختیاری)',
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9@_]')),
                            ],
                            textEditingController: emailController,
                            maxline: 1,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          MyTextField(
                            label: 'نظر شما',
                            textEditingController: commentController,
                            verticalScrollPadding: 15,
                            maxline: 6,
                            keyboardType: TextInputType.multiline,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: Get.width,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                              child: Text('ارسال نظر',
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white)),
                            ),
                          )
                        ]),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(28),
                            topLeft: Radius.circular(28))));
              },
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
                              "https://www.uspace.ir/public/img/ecolodge/categories/trade-hotel2.jpg",
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
                                  textAlign: TextAlign.center,
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
                    style: Theme.of(Get.context!).textTheme.titleMedium,
                    trimLines: 4,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    lessStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 10, color: Colors.blue),
                    trimCollapsedText: 'نمایش بیشتر',
                    trimExpandedText: 'نمایش کمتر',
                    moreStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleMedium!
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
                    style: Theme.of(Get.context!).textTheme.titleMedium,
                    trimLines: 4,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    lessStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 10, color: Colors.blue),
                    trimCollapsedText: 'نمایش بیشتر',
                    trimExpandedText: 'نمایش کمتر',
                    moreStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleMedium!
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
                    style: Theme.of(Get.context!).textTheme.titleMedium,
                    trimLines: 4,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    lessStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 10, color: Colors.blue),
                    trimCollapsedText: 'نمایش بیشتر',
                    trimExpandedText: 'نمایش کمتر',
                    moreStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleMedium!
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
                    style: Theme.of(Get.context!).textTheme.titleMedium,
                    trimLines: 4,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    lessStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 10, color: Colors.blue),
                    trimCollapsedText: 'نمایش بیشتر',
                    trimExpandedText: 'نمایش کمتر',
                    moreStyle: Theme.of(Get.context!)
                        .textTheme
                        .titleMedium!
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
                      style: Theme.of(Get.context!).textTheme.titleMedium),
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
                      style: Theme.of(Get.context!).textTheme.titleMedium),
                  const SizedBox(
                    height: 25,
                  ),
                  Text('رزرو کودکان',
                      style: Theme.of(Get.context!).textTheme.bodySmall),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'اقامت کودکان کمتر از 5 سال رایگان می باشد.',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: Theme.of(Get.context!).textTheme.titleMedium,
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
                    style: Theme.of(Get.context!).textTheme.titleMedium,
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
                    style: Theme.of(Get.context!).textTheme.titleMedium,
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
                    style: Theme.of(Get.context!).textTheme.titleMedium,
                  ),
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
                      style: Theme.of(Get.context!).textTheme.titleMedium,
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
                      style: Theme.of(Get.context!).textTheme.titleMedium,
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
                      style: Theme.of(Get.context!).textTheme.titleMedium,
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
                      style: Theme.of(Get.context!).textTheme.titleMedium,
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
                    Obx(() => Directionality(
                          textDirection: TextDirection.rtl,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(children: [
                                SvgPicture.asset(
                                    'assets/icons/calendar_ic.svg'),
                                const SizedBox(width: 5,),
                                Text('به مدت',
                                    style: Theme.of(Get.context!)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: AppColors.grayColor))
                              ]),
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: AppColors.grayColor),
                              items: dropDownController.dropDownItems
                                  .map((selectedType) {
                                return DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  value: selectedType,
                                  child: Text(
                                    selectedType,
                                    style: Theme.of(Get.context!)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: AppColors.grayColor),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                dropDownController.setSelected(value!);
                              },
                              value:
                                  dropDownController.dropDownValue.value == ""
                                      ? null
                                      : dropDownController.dropDownValue.value,
                              buttonStyleData: ButtonStyleData(
                                height: 35,
                                width: Get.width / 2.8,
                                padding: const EdgeInsets.only(
                                    right: 10, left: 8, top: 0, bottom: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: const Color(0xffF8F9FD),
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down_rounded,
                                ),
                                iconEnabledColor: AppColors.grayColor,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                  elevation: 2,
                                  padding: EdgeInsets.zero,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12),
                                        bottomLeft: Radius.circular(12)),
                                  ),
                                  direction: DropdownDirection.textDirection,
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all(true),
                                  )),
                            ),
                          ),
                        )),
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
                                  titleTextStyle:
                                      const TextStyle(color: Colors.red),
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
                        picked?.toDateTime();
                        if (picked != null) {
                          isDateSelected.value = true;
                        }
                      },
                      child: Container(
                          height: 35,
                          width: Get.width / 2 - 50,
                          decoration: BoxDecoration(
                            color:const Color(0xffF8F9FD),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          'اتاق سه تخته پریخان خانم هتل سنتی شیران_اصفهان',
                                          softWrap: true,
                                          textDirection: TextDirection.rtl,
                                          style: Theme.of(Get.context!)
                                              .textTheme
                                              .labelSmall),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            index == 0
                                                ? InkWell(
                                                    onTap: () {
                                                      Get.dialog(
                                                          chosePackage());
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    child: Obx(() => Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      3.0),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: selectedPackageId
                                                                              .value ==
                                                                          100
                                                                      ? AppColors
                                                                          .mainColor
                                                                      : AppColors
                                                                          .grayColor,
                                                                  width: 0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        6.0,
                                                                    horizontal:
                                                                        15),
                                                            child: Center(
                                                                child: Text(
                                                                    'انتخاب نوع پکیج',
                                                                    softWrap:
                                                                        true,
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    style: Theme.of(Get
                                                                            .context!)
                                                                        .textTheme
                                                                        .bodySmall!
                                                                        .copyWith(
                                                                            fontSize:
                                                                                8,
                                                                            color: selectedPackageId.value == 100
                                                                                ? AppColors.mainColor
                                                                                : AppColors.grayColor))),
                                                          ),
                                                        )),
                                                  )
                                                : const SizedBox(),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Obx(() => Container(
                                                  width: Get.width / 4.2,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 3.0),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: selectedPackageId
                                                                          .value ==
                                                                      100 &&
                                                                  index == 0
                                                              ? AppColors
                                                                  .grayColor
                                                              : AppColors
                                                                  .mainColor,
                                                          width: 0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 6.0),
                                                    child: Center(
                                                        child: Text(
                                                            selectedPackageId.value ==
                                                                        100 &&
                                                                    index == 0
                                                                ? 'قیمت هر شب'
                                                                : '2,000,000 تومان / یک شب',
                                                            softWrap: true,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: Theme.of(Get
                                                                    .context!)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    fontSize: 8,
                                                                    color: selectedPackageId.value == 100 &&
                                                                            index ==
                                                                                0
                                                                        ? AppColors
                                                                            .grayColor
                                                                        : AppColors.mainColor))),
                                                  ),
                                                )),
                                          ]),
                                      Obx(() => SizedBox(
                                            height: selectedPackageId.value ==
                                                        100 &&
                                                    index == 0
                                                ? 10
                                                : 5,
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(() => selectedPackageId.value ==
                                                      100 &&
                                                  index == 0
                                              ? const SizedBox()
                                              : Obx(() => TextButton.icon(
                                                  onPressed: () {
                                                    showMore[index].toggle();
                                                  },
                                                  icon: Icon(
                                                    showMore[index].value
                                                        ? Icons
                                                            .keyboard_arrow_up_rounded
                                                        : Icons
                                                            .keyboard_arrow_down_rounded,
                                                    size: 15,
                                                  ),
                                                  label: Text(
                                                      showMore[index].value
                                                          ? 'کمتر'
                                                          : 'امکانات بیشتر',
                                                      style: Theme.of(
                                                              Get.context!)
                                                          .textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              color: Colors
                                                                  .blueAccent,
                                                              fontSize: 10))))),
                                          Obx(() => InkWell(
                                                onTap: () {
                                                  selectedPackageId.value ==
                                                              100 &&
                                                          index == 0
                                                      ? null
                                                      : Get.to(
                                                          RoomReservationScreen(),
                                                          arguments: index);
                                                },
                                                child: Container(
                                                  width: Get.width / 4.2,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: selectedPackageId
                                                                    .value ==
                                                                100 &&
                                                            index == 0
                                                        ? AppColors.grayColor
                                                        : AppColors.mainColor,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 6.0),
                                                    child: Center(
                                                        child: Text(
                                                      'رزرو اتاق',
                                                      style:
                                                          Theme.of(Get.context!)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10),
                                                    )),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      )
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
                                  child: Hero(
                                    tag: 'hero $index',
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://shiranhotel.uspace.ir/spaces/shiranhotel/images/main/shiranhotel_uspace_1638686061.jpg",
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                              Icons.broken_image_outlined),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        Obx(() => selectedPackageId.value == 100 && index == 0
                            ? const SizedBox()
                            : Wrap(
                                direction: Axis.horizontal,
                                textDirection: TextDirection.rtl,
                                children: facilitiesList(
                                        showMore: showMore[index].value,
                                        facilitiesList: facilities)
                                    .map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(item,
                                              style: Theme.of(Get.context!)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      fontSize: 10,
                                                      color:
                                                          AppColors.grayColor)),
                                        ),
                                        const Icon(Icons.done_all_rounded,
                                            size: 15,
                                            color: AppColors.grayColor)
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )),
                      ],
                    ));
              },
            ),
            const SizedBox(
              height: 25,
            ),
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
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 0),
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
                                    .titleMedium!
                                    .copyWith(color: AppColors.grayColor),
                                trimLines: 4,
                                textDirection: TextDirection.rtl,
                                trimMode: TrimMode.Line,
                                lessStyle: Theme.of(Get.context!)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 10, color: Colors.blue),
                                trimCollapsedText: 'نمایش بیشتر',
                                trimExpandedText: 'نمایش کمتر',
                                moreStyle: Theme.of(Get.context!)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 10, color: Colors.blue),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '14 تیر 1402',
                                      style: Theme.of(Get.context!)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: 10,
                                              color: AppColors.grayColor),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    const Spacer(),
                                    InkWell(
                                        onTap: () {},
                                        child: SvgPicture.asset(
                                            'assets/icons/reply_ic.svg')),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, top: 5.0),
                                      child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          onTap: () {},
                                          child: Text('پاسخ',
                                              style: Theme.of(Get.context!)
                                                  .textTheme
                                                  .titleMedium!
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
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget chosePackage() {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      backgroundColor: Colors.transparent,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'اتاق سه تخته پریخان خانم هتل سنتی شیران_اصفهان',
            style: Theme.of(Get.context!).textTheme.labelMedium,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'برای رزرو، یکی از این پکیج ها را انتخاب کنید',
            style: Theme.of(Get.context!).textTheme.labelSmall,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(
            height: 25,
          ),
          ListView.separated(
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () {
                        if (selectedPackageIndex.value == index) {
                          selectedPackageIndex.value = 100;
                        } else {
                          selectedPackageIndex.value = index;
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Obx(() => DottedBorder(
                              color: selectedPackageIndex.value == index
                                  ? AppColors.mainColor
                                  : AppColors.grayColor,
                              strokeWidth: 0.4,
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              radius: const Radius.circular(10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: GridView.builder(
                                      itemCount: facilities.length,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 4.5),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.done_all_rounded,
                                                size: 9.5.sp),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(facilities[index],
                                                style: Theme.of(Get.context!)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(fontSize: 7.sp)),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Positioned(
                      right: Get.width * 0.07,
                      top: -Get.height * 0.018,
                      child: InkWell(
                        onTap: () {
                          if (selectedPackageIndex.value == index) {
                            selectedPackageIndex.value = 100;
                          } else {
                            selectedPackageIndex.value = index;
                          }
                        },
                        child: Obx(() => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: selectedPackageIndex.value == index
                                    ? AppColors.mainColor
                                    : AppColors.grayColor,
                              ),
                              child: Text('پکیج ${index + 1}',
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: Colors.white)),
                            )),
                      ),
                    ),
                    Obx(() => selectedPackageIndex.value == index
                        ? Positioned(
                            left: Get.width * 0.07,
                            top: -Get.height * 0.019,
                            child: GestureDetector(
                              onTap: () {
                                selectedPackageIndex.value = 100;
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.mainColor
                                            .withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 4),
                                    const BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: AppColors.redColor,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()),
                  ],
                );
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 25),
              itemCount: 2),
          const SizedBox(
            height: 25,
          ),
          Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: selectedPackageIndex.value != 100
                      ? AppColors.mainColor
                      : AppColors.grayColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18))),
              onPressed: () {
                if (selectedPackageIndex.value != 100) {
                  selectedPackageId.value = selectedPackageIndex.value;
                  Get.back();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text('انتخاب',
                    style:
                        Theme.of(Get.context!).textTheme.labelSmall!.copyWith(
                              color: Colors.white,
                            )),
              ))),
          const SizedBox(
            height: 15,
          ),
        ]),
      ),
    );
  }

  List<dynamic> facilitiesList(
      {required bool showMore, required List facilitiesList}) {
    if (showMore) {
      return facilitiesList;
    } else {
      return facilitiesList.getRange(0, 4).toList();
    }
  }
}
