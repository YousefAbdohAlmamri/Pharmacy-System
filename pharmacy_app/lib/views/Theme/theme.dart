import 'package:flutter/material.dart';

class AppColors {
  static const Color lightBackground = Colors.white;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color lightBlue = Color(0xFF3D6C91);
  static const Color lightTextGray = Color(0xFF797979);

  static const Color iconColor = Colors.white;

  static const Color darkBackground = Color(0xFF1B242F);
  static const Color darkGrey = Color(0xFF23303F);
  static const Color darkHead = Color(0xFF364556);
  static const Color darkBlue = Color(0xFF63B1EC);
}

class AppTextStyles {
  static const TextStyle headerB = TextStyle(fontSize: 25, color: Colors.black);
  static const TextStyle subHeaderB =
      TextStyle(fontSize: 20, color: Colors.black);
  static const TextStyle subHeader2B =
      TextStyle(fontSize: 18, color: Colors.black);
  static const TextStyle bodyB = TextStyle(fontSize: 14, color: Colors.black);

  static const TextStyle headerW = TextStyle(fontSize: 25, color: Colors.white);
  static const TextStyle subHeaderW =
      TextStyle(fontSize: 20, color: Colors.white);
  static const TextStyle bodyW = TextStyle(fontSize: 14, color: Colors.white);
}

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.lightBlue,
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.headerB,
      bodyLarge: AppTextStyles.subHeaderB,
      bodyMedium: AppTextStyles.bodyB,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.darkBlue,
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.headerB,
      bodyLarge: AppTextStyles.subHeaderB,
      bodyMedium: AppTextStyles.bodyB,
    ),
  );
}

// Widget iconButton({required IconData icon, required VoidCallback onPressed}){
//   return IconButton(onPressed: onPressed, icon: Icon(icon , color: AppColors.lightBackground , size: 20,));
// }
Widget iconButton({required IconData icon, VoidCallback? onPressed}) {
  return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.lightBackground,
        size: 30,
      ));
}

Widget subAppBar1({required String? titlel, required BuildContext context}) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    decoration: const BoxDecoration(
      color: AppColors.lightBlue,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      boxShadow: [
        BoxShadow(
            color: Color.fromARGB(54, 0, 0, 0),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1))
      ],
    ),
    child: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.keyboard_arrow_right_sharp,
          color: AppColors.iconColor,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        titlel!,
        style: const TextStyle(
          fontSize: 25,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    ),
  );
}

Widget subAppBar2(
    {required String? titlel,
    required BuildContext context,
    required IconData icon}) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    decoration: const BoxDecoration(
      color: AppColors.lightBlue,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      boxShadow: [
        BoxShadow(
            color: Color.fromARGB(54, 0, 0, 0),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1))
      ],
    ),
    child: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.keyboard_arrow_right_sharp,
          color: AppColors.iconColor,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        titlel!,
        style: const TextStyle(
          fontSize: 25,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            color: Colors.white,
            size: 25,
          ),
        ),
      ],
    ),
  );
}

Widget buttonNextIcon({required VoidCallback onPressed}) {
  return SizedBox(
    width: 130,
    height: 45,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "التالي",
            style: AppTextStyles.subHeaderW,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            Icons.arrow_forward,
            color: AppColors.iconColor,
          ),
        ],
      ),
    ),
  );
}

Widget buttonBackIcon({required VoidCallback onPressed}) {
  return SizedBox(
    width: 130,
    height: 45,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4C5E73),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_back,
            color: AppColors.iconColor,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "السابق",
            style: AppTextStyles.subHeaderW,
          ),
        ],
      ),
    ),
  );
}

Widget buttonLong({required IconData icon, VoidCallback? onPressed}) {
  return SizedBox(
    width: 350,
    height: 60,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 3,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "التالي",
            style: AppTextStyles.subHeaderW,
          ),
          SizedBox(
            width: 2,
          ),
          Icon(
            Icons.arrow_forward,
            color: AppColors.iconColor,
          ),
        ],
      ),
    ),
  );
}
