import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uspace_ir/app/config/them_data.dart';
import 'package:sizer/sizer.dart';
import 'package:uspace_ir/routes/constance_routes.dart';
import 'package:uspace_ir/routes/route.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Sizer(builder: (context, orientation, deviceType) {
    return GetMaterialApp(
        theme: ThemConfig.createTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.home,
        getPages: Pages().pages
    );
  },));
}