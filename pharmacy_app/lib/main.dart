import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/views/screens/test.dart';
//import 'package:pharmacy_app/views/screens/Main_Interface.dart';
//import 'package:pharmacy_app/views/screens/MedicineDetails.dart';
import 'package:pharmacy_app/views/widget/BottomNavigationBar.dart';

//import 'views/screens/Login.dart';
//import 'views/screens/CreateAccount.dart';

import 'views/screens/Title_Interface.dart';
//import 'views/screens/PharmacyDetail.dart';
//import 'views/screens/AddPharmacy.dart';

void main() {
   runApp(DevicePreview(
    enabled: true,
    builder: (context) => MyApp()));
 }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: CreateOrLoginAccount(),
      //home: MedicineSearchPage(),
      //home: Services(),
      routes: {
        '/register': (context) => CreateOrLoginAccount(),
      },
    );
  }
}
