

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/them_data.dart';
import 'package:uspace_ir/app/routes/constance_routes.dart';
import 'package:uspace_ir/app/routes/route.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(GetMaterialApp(
      theme: ThemConfig.createTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.reservation,
      getPages: Pages().pages
  ));
}