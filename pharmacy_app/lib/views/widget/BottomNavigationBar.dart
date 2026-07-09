// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:pharmacy_app/services/pharmacyServices.dart';

import '../screens/AddPharmacy.dart';

import '../screens/Favorite.dart';
import '../screens/FollowUpRequests.dart';
import '../screens/Main_Interface.dart';
import 'package:flutter/material.dart';

class bottomnavigationbar extends StatefulWidget {
  const bottomnavigationbar({super.key});
  @override
  State<bottomnavigationbar> createState() => _bottomnavigationbarState();
}

class _bottomnavigationbarState extends State<bottomnavigationbar> {
  final Color backColor = const Color(0xFF141E28); // اللون الخلفي
  
  int _selectedIndex = 0;
  final List<Widget> _page = [HomePage(), Favorite(), followuprequests(),AddPharmacyPage()];
  //final List<Widget> _page = [HomePage(), Favorite(), followuprequests(),AddPharmacyPage()];
  void _onItemsTapped(int index) {
    if (index == 4) {
      SizedBox();
      // showModal(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backColor,
        body: _page[_selectedIndex],
        bottomNavigationBar: Container(
          //height: 90,
          decoration:  BoxDecoration(
              color: backColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13), topRight: Radius.circular(13)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                  blurRadius: 2,
                )
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13), topRight: Radius.circular(13)),
            child: BottomNavigationBar(
              //type: BottomNavigationBarType.fixed,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: "الصفحة الرئيسية",
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                  label: "المفضلة",
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.article,
                    size: 30,
                  ),
                  label: "متابعة الصدلية",
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.store,
                    size: 30,
                  ),
                  label: "الصيدلية",
                  backgroundColor: Colors.transparent,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xFF6EC2FF),
              // selectedFontSize: 14,
              onTap: _onItemsTapped,
              //backgroundColor: Colors.transparent,
              unselectedItemColor: const Color.fromARGB(255, 187, 187, 187),
            ),
          ),
        ),
      ),
    );
  }
}
