import '../widget/BottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'CreateAccount.dart';

class CreateOrLoginAccount extends StatelessWidget {
  final Color backColor = const Color(0xFF141E28);
  
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backColor,
        //backgroundColor: Colors.white, // اللون الخلفي العلوي
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(76, 94, 115, 100),
          //backgroundColor: Color(0xFF3D6C91),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => bottomnavigationbar()));
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // الجزء العلوي مع النص
            ClipPath(
              clipper: clipper(),
              child: Container(
                  height: 200,
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromRGBO(76, 94, 115, 100),
                    //color: const Color(0xFF3D6C91),
                  ),
                  alignment: Alignment.topCenter,
                  // اللون الخلفي العلوي
                  child: const Text(
                    'المنصة الطبية',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            ),

            const SizedBox(height: 0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                color: backColor, // اللون الخلفي السفلي
                //color: Colors.white, // اللون الخلفي السفلي
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'مرحباً',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(76, 94, 115, 100),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const // مسافة بين النصوص
                    Text(
                      'يمكنكم الان من معرفة أماكن توافر الأدوية في الصيدليات وكذلك معرفة جميع التفاصيلعن الصيدليات والأدوية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 160), // مسافة بين النصوص والأزرار
                    Container(
                      width: 350,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Login_Screen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3D6C91),
                          //backgroundColor: Colors.grey[200],
                          //: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // مسافة بين الأزرار
                    Container(
                      height: 55,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreeateAcount()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3D6C91),
                          //onPrimary: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'إنشاء حساب',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 3, size.height + 40, size.width, size.height - 130);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
