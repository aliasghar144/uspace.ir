import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uspace_ir/app/config/app_colors.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/models/new_ticket_model.dart';
import 'package:uspace_ir/models/tickets_model.dart';

class TicketController extends GetxController{
  String? trackCode;

  TicketController(this.trackCode);

  @override
  void onInit() {
    showFirstTicket();
    super.onInit();
  }

  final firstTicket = Rxn<NewTicketModel>();
  final allMessage = Rxn<TicketsModel>();

  final formKey = GlobalKey<FormState>();

  RxBool sendReply = false.obs;

  TextEditingController contentTxtEditCtr = TextEditingController();
  TextEditingController titleTxtEditCtr = TextEditingController();
  TextEditingController replyTxtEditCtr = TextEditingController();


  showFirstTicket() async {
    try{
      loading.value = true;
      Uri url = Uri.parse('$mainUrl/customer/tickets/$trackCode');
      final response = await http.get(url);
      if(response.statusCode ==200){
        firstTicket.value = newTicketModelFromJson(response.body);
        if(firstTicket.value!.data.isNotEmpty){
          showAllMessage(firstTicket.value!.data[0].ticketCode.toString());
        }else{
          loading.value = false;
        }
      }
    }catch(e){
      print(e);
    }
  }

  showAllMessage(String ticketCode)async{
    try{
      loading.value = true;
      Uri url = Uri.parse('$mainUrl/customer/tickets/$ticketCode/show');
      final response = await http.get(url);
      if(response.statusCode == 200){
        allMessage.value = ticketsModelFromJson(response.body);

        loading.value = false;
      }
    }catch(e){
      print(e);
    }
  }

  sendTicket() async {
    try{

      // send ticket az first time
      if(firstTicket.value!.data.isEmpty){
        loading.value = true;

        Map<String,dynamic> body = {
          'title': titleTxtEditCtr.text,
          'content': contentTxtEditCtr.text
        };

        Uri url = Uri.parse('$mainUrl/customer/tickets/$trackCode/new-ticket');
        final http.Response response = await http.post(url,body: jsonEncode(body),headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });

        var data = jsonDecode(response.body);

        if(response.statusCode == 200){
          contentTxtEditCtr.clear();
          titleTxtEditCtr.clear();
          if(data['message'] == 'ok' ||data['message'] == '200'){
            showFirstTicket();
            loading.value = false;
          }
          else
          {

            Get.showSnackbar(
                GetSnackBar(
                  backgroundColor: AppColors.redColor,
                  duration: const Duration(seconds: 3),
                  messageText: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),

                ));
            loading.value = false;

          }
        }
        else
        {
          Get.showSnackbar(
              GetSnackBar(
                backgroundColor: AppColors.redColor,
                duration: const Duration(seconds: 3),
                messageText: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),

              ));
          loading.value = false;

        }
      }

      else

      {
        sendReply.value = true;

        Map<String,dynamic> body = {
          'tracking_code': trackCode,
          'content': replyTxtEditCtr.text
        };
        Uri url = Uri.parse('$mainUrl/customer/tickets/${firstTicket.value!.data[0].ticketCode.toString()}/answered-to-ticket');
        final http.Response response = await http.post(url,body: jsonEncode(body),headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });

        if(response.statusCode == 200){
          var data = jsonDecode(response.body);
          if(data['status'] == 'ok'){
            allMessage.value!.data.conversation.add(Conversation(side: Side(sideId: 2, sideName: 'مهمان'), content: replyTxtEditCtr.text, mStartDate: DateTime.now(), jStartDate: ''));
            // loading.value = false;
            sendReply.value = false;
            replyTxtEditCtr.clear();
          }
          else
            {
              Get.showSnackbar(
                  GetSnackBar(
                    backgroundColor: AppColors.redColor,
                    duration: const Duration(seconds: 3),
                    messageText: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(data['details'],style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color:Colors.white),textAlign: TextAlign.start)),

                  ));
              loading.value = false;
              sendReply.value = false;}
        }
      }

    }catch(e){
      print(e);
    }
  }

  RxBool loading  = false.obs;

}