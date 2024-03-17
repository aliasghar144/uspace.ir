import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/app/utils/check_currency.dart';
import 'package:uspace_ir/models/ecolodge_model.dart';
import 'package:uspace_ir/pages/reservation/reservation_screen.dart';

class CardEcolodge extends StatelessWidget {
  final EcolodgeModel ecolodge;
  const CardEcolodge({
    required this.ecolodge,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Stack(
        children: [
          InkWell(
            onTap:(){
              print(ecolodge.url);
              Get.to(const ReservationScreen(),arguments: {'url':ecolodge.url});
            },
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 180,
              child: Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                shadowColor: Colors.black26,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 92,
                      child: ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl: ecolodge.image,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined),
                          )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(ecolodge.title, maxLines: 1, style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize: 12)),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/location_small_pin_ic.svg',
                                  color: AppColors.disabledIcon,
                                  width: 13,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${ecolodge.province}, ${ecolodge.city}',
                                  style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize: 10, color: AppColors.disabledText),
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/price_ic.svg',
                                  color: AppColors.disabledIcon,
                                  width: 13,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "قیمت:",
                                  style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize: 10, color: AppColors.disabledText),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  ecolodge.minPrice == 0 ?'تماس با پشتیبانی':ecolodge.minPrice!.toString().beToman().seRagham(),
                                  style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize: 10, color: AppColors.mainColor),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                ecolodge.minPrice == 0 ? const SizedBox() : Text(
                                  checkCurrency(ecolodge.currency) ?? '',
                                  style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(fontSize: 10, color: AppColors.mainColor),
                                ),
                                const Spacer(),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (ecolodge.maxDiscountPercent != null && ecolodge.maxDiscountPercent! > 0)
            Positioned(
              right: Get.width * 0.05,
              top: 0,
              child: Container(
                height: 20,
                width: 40,
                decoration: const BoxDecoration(color: Color(0xffEA213B), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
                child: Center(child: Text('${ecolodge.maxDiscountPercent}%', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white))),
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
