import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/controllers/ticket_controller.dart';
import 'package:uspace_ir/main.dart';

class TicketScreen extends StatelessWidget {
  final String trackCode;
  const TicketScreen({
    required this.trackCode,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TicketController mainController = Get.put(TicketController(trackCode));
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Form(
        key: mainController.formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20, top: 15.0),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                splashRadius: 20,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 15.0),
                child: IconButton(
                  splashRadius: 20,
                  icon: SvgPicture.asset('assets/icons/bell_ic.svg'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(bottom: 5, left: Get.width * 0.09, right: 25),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: AppColors.mainColor))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => mainController.loading.value
                          ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 15,
                            width: Get.width / 5,
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: const Color(0xffF3F3F3)),
                          ))
                          : Text(
                        mainController.firstTicket.value!.data.isEmpty ? 'ارسال تیکت': mainController.firstTicket.value!.data[0].title,
                        style: Theme.of(Get.context!).textTheme.displayMedium,
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.support_agent_outlined,
                        size: 20,
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Obx(() => !mainController.loading.value && mainController.firstTicket.value != null && mainController.firstTicket.value!.data.isEmpty ? importantPoint(mainController) : conversation(mainController),),
                const SizedBox(height: 100,)
              ],
            ),
          ),
          bottomNavigationBar:
          Obx(() => !mainController.loading.value ? mainController.firstTicket.value != null && mainController.firstTicket.value!.data.isEmpty ? sendFirstTicketButton(mainController) : const SizedBox() : const SizedBox() ),
          bottomSheet:
          Obx(() => !mainController.loading.value ? mainController.firstTicket.value != null && mainController.firstTicket.value!.data.isEmpty ? const SizedBox() : sendTextfield(mainController) : const SizedBox() ),
        ),
      ),
    );
  }

  conversation(TicketController mainController) {
    return Obx(() => ListView.builder(
      itemCount: mainController.loading.value ? 10 : mainController.allMessage.value!.data.conversation.length+1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {

        if(index == 0 && !mainController.loading.value){
          return Column(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xffE1E6EA),
                  ),
                  child: Text(mainController.allMessage.value!.data.mStartDate.toPersianDateStr(seprator: ' '),textDirection: TextDirection.rtl,)),

              Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: Get.width/1.5
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xfff8f9fa),
                        ),
                        child:Padding(
                          padding:const EdgeInsets.all(8.0),
                          child: Text(mainController.allMessage.value!.data.content),
                        ),
                      ),
                    ),
                    Text("${timeShow(mainController.allMessage.value!.data.mStartDate.hour)}:${timeShow(mainController.allMessage.value!.data.mStartDate.minute)}",style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor,fontSize: 9.sp),),
                    const SizedBox(height: 15,)
                  ],
                ),
              ),
            ],
          );
        }

        //loading
        if(mainController.loading.value){
          if(index == 2||index == 4||index == 5){return
            Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 25,
                    width: index == 4 ? Get.width/3.2 :Get.width/2.2,
                    margin: const EdgeInsets.only(left: 20,bottom: 15),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffF3F3F3)),
                  ),
                ));}else{
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 25,
                    width: index == 1 ? Get.width/3.7 : index == 6 ? Get.width/1.75 : Get.width/2.4,
                    margin: const EdgeInsets.only(right: 20,bottom: 15),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffF3F3F3)),
                  ),
                ));

          }}


        // conversation
        if(mainController.allMessage.value!.data.conversation[index-1].side.sideId == 1){

          return Column(
            children: [

              // show date
              mainController.allMessage.value!.data.conversation[index-1 == mainController.allMessage.value!.data.conversation.length-1 ? index-1 : index].mStartDate.difference(mainController.allMessage.value!.data.conversation[index-1].mStartDate) >= const Duration(days: 1) ?             Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xffE1E6EA),
                  ),
                  child: Text(mainController.allMessage.value!.data.conversation[index-1].mStartDate.toPersianDateStr(seprator: ' '),textDirection: TextDirection.rtl,))
                  :const SizedBox(),

              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: Get.width/1.5
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xfff8f9fa),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(mainController.allMessage.value!.data.conversation[index-1].content,textDirection: TextDirection.rtl,textAlign: TextAlign.right,),
                        ),
                      ),
                    ),
                    Text("${timeShow(mainController.allMessage.value!.data.conversation[index-1].mStartDate.hour)}:${timeShow(mainController.allMessage.value!.data.conversation[index-1].mStartDate.minute)}",style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor,fontSize: 9),),
                    const SizedBox(height: 15,)
                  ],
                ),
              ),
            ],
          );

        }else{

          return Column(
          children: [

            // show date
            mainController.allMessage.value!.data.conversation[index-1 == mainController.allMessage.value!.data.conversation.length-1 ? index-1 : index].mStartDate.difference(mainController.allMessage.value!.data.conversation[index-1].mStartDate) >= const Duration(days: 1) ?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xffE1E6EA),
                ),
                child: Text(mainController.allMessage.value!.data.conversation[index-1].mStartDate.toPersianDateStr(seprator: ' '),textDirection: TextDirection.rtl,))
                :const SizedBox(),


            Align(
              alignment: Alignment.topRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: Get.width/1.5
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xfff8f9fa),
                      ),
                      child:Padding(
                        padding:const EdgeInsets.all(8.0),
                        child: Text(mainController.allMessage.value!.data.conversation[index-1].content,textAlign: TextAlign.right,textDirection: TextDirection.rtl,),
                      ),
                    ),
                  ),
                  Text("${timeShow(mainController.allMessage.value!.data.conversation[index-1].mStartDate.hour)}:${timeShow(mainController.allMessage.value!.data.conversation[index-1].mStartDate.minute)}",style: Theme.of(Get.context!).textTheme.labelSmall!.copyWith(color: AppColors.grayColor,fontSize: 9.sp),),
                  const SizedBox(height: 15,)
                ],
              ),
            ),
          ],
        );
        }
      },));
  }

  sendTextfield(TicketController mainController) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10.0),
        child: Row(
          children: [
            Expanded(child:
            TextField(
              controller: mainController.replyTxtEditCtr,
              textDirection: TextDirection.rtl,
              maxLines: 4,
              minLines: 1,
              textAlign: TextAlign.right,
              style: Theme.of(Get.context!).textTheme.bodyLarge,
              decoration: InputDecoration(
                // enabledBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(8),
                //     borderSide:const BorderSide(width: 0.3,color: AppColors.grayColor) ),
                // focusedBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(8),
                //     borderSide:const BorderSide(width: 0.3,) ),
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(8),
                //     borderSide:const BorderSide(width: 0.3,) )
                hintText: 'پیام جدید خود را بنویسید',
                  hintStyle: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.grayColor.withOpacity(0.5)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              ),
            )),
            const SizedBox(width: 15,),
            Obx(() => mainController.sendReply.value? const SizedBox(
              width: 25,height: 25,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
              ),
            ) : IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 20,
              onPressed: (){
                mainController.sendTicket();
              }, icon:const Icon(Icons.send_rounded),color: AppColors.mainColor,)
            )
          ],
        ),
      ),
    );
  }

  Widget importantPoint(TicketController mainController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text('مسافر عزیز، شما میتوانید از طریق ارسال تیکت ما را از مشکل بوجود آمده مطلع فرمایید.',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: const Color(0xff31708f),fontSize: 14.sp),textAlign: TextAlign.right,textDirection: TextDirection.rtl,)),
              const SizedBox(width: 5,),
              const Icon(Icons.info,color: Color(0xff31708f),size: 18,),
            ],
          ),
          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text('پاسخگویی به تیکت ها سریع تر از تماس تلفنی میباشد و در زمان شما صرفه جویی خواهد شد',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: const Color(0xff31708f),fontSize: 14.sp),textAlign: TextAlign.right,textDirection: TextDirection.rtl,)),
              const SizedBox(width: 5,),
              const Icon(Icons.info,color: Color(0xff31708f),size: 18,),
            ],
          ),
          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text('پاسخ شما در همین صفحه اعلام خواهد شد و در صورت نیاز بخش پشتیبانی با شما تماس حاصل خواهد کرد.',style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: const Color(0xff31708f),fontSize: 14.sp),textAlign: TextAlign.right,textDirection: TextDirection.rtl,)),
              const SizedBox(width: 5,),
              const Icon(Icons.info,color: Color(0xff31708f),size: 18,),
            ],
          ),
          const SizedBox(height: 35,),
          Text('عنوان',style: Theme.of(Get.context!).textTheme.displayMedium,),
          const SizedBox(height: 10,),
          TextFormField(
            textDirection: TextDirection.rtl,
            controller: mainController.titleTxtEditCtr,
            textAlign: TextAlign.right,
            style: Theme.of(Get.context!).textTheme.bodyLarge,
            validator: (value) {
              if (value!.isEmpty) {
                return 'لطفا عنوان تیکت را وارد کنید.';
              }
              return null;
            },
              onTap: () {
                if (mainController.titleTxtEditCtr.selection ==
                    TextSelection.fromPosition(TextPosition(
                        offset:
                        mainController.titleTxtEditCtr.text.length -
                            1))) {
                  mainController.titleTxtEditCtr.selection =
                      TextSelection.fromPosition(TextPosition(
                          offset:mainController.titleTxtEditCtr.text.length));
                }
              },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:const BorderSide(width: 0.3,color: AppColors.grayColor) ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:const BorderSide(width: 0.3,) ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                 borderSide:const BorderSide(width: 0.3,) ),
              hintText: 'عنوان تیکت را وارد کنید',
              hintStyle: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.grayColor.withOpacity(0.5)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            ),
          ),
          const SizedBox(height: 15,),
          Text('پیام جدید خود را بنویسید',style: Theme.of(Get.context!).textTheme.displayMedium,),
          const SizedBox(height: 10,),
          TextFormField(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.top,
            maxLines: 6,
            style: Theme.of(Get.context!).textTheme.bodyLarge,
            controller: mainController.contentTxtEditCtr,
            onTap: () {
              if (mainController.contentTxtEditCtr.selection ==
                  TextSelection.fromPosition(TextPosition(
                      offset:
                      mainController.contentTxtEditCtr.text.length -
                          1))) {
                mainController.contentTxtEditCtr.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset:mainController.contentTxtEditCtr.text.length));
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'لطفا پیام خود را بنویسید';
              }
              return null;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:const BorderSide(width: 0.3,color: AppColors.grayColor) ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:const BorderSide(width: 0.3,) ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:const BorderSide(width: 0.3,) ),
              hintText: 'پیام جدید خود را بنویسید',
              hintTextDirection: TextDirection.rtl,
              hintStyle: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(color: AppColors.grayColor.withOpacity(0.5)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            ),
          ),
        ],
      ),
    );
  }

  String timeShow(int time){
    if(time<10){
      return '0$time';
    }
    return time.toString();
  }

  sendFirstTicketButton(TicketController mainController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
            ),
              onPressed: (){
                if (mainController.formKey.currentState!.validate()) {
                  mainController.sendTicket();
                }
              }, child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Text('ارسال پیام',style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontSize: 20.sp,color: Colors.white),),
              )),
        ],
      ),
    );
  }

}
