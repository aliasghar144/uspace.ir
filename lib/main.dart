import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import 'package:uspace_ir/app/config/them_data.dart';
import 'package:uspace_ir/constance/constance.dart';
import 'package:uspace_ir/routes/route.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.openBox(userBox);
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