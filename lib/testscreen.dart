import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:readmore/readmore.dart';
import 'package:uspace_ir/controllers/user_controller.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';
import 'package:uspace_ir/pages/reservation/reserve_room_screen.dart';
import 'package:uspace_ir/widgets/custom_progress.dart';
import 'package:uspace_ir/widgets/facilites_dialog.dart';
import 'package:uspace_ir/widgets/image_view.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/reservation_controller.dart';
import 'package:uspace_ir/widgets/textfield.dart';

class TestScreen extends StatelessWidget {
  TestScreen({Key? key}) : super(key: key);

  final UserController userController = Get.find<UserController>();


  @override
  Widget build(BuildContext context) {
    ReservationController reservationController = Get.put(ReservationController('berenjestanak'));
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          notificationPredicate: (notification) {
            if (notification is OverscrollNotification || GetPlatform.isIOS) {
              return notification.depth == 2;
            }
            return notification.depth == 0;
          },
          color: AppColors.mainColor,
          onRefresh: () async {
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: reservationController.mainScrollController,
            slivers: [
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 15, bottom: 15.0),
          //     child: FloatingActionButton(backgroundColor: AppColors.mainColor, onPressed: () {}, child: SvgPicture.asset('assets/icons/chat_ic.svg')),
          //   ),
          // ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }

}
