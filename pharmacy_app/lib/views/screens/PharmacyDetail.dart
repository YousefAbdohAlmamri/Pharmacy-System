//import 'dart:js_interop';
//import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
//import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_app/core/Models/Category.dart';
import 'package:pharmacy_app/core/Models/Medicine.dart';
import 'package:pharmacy_app/core/Models/pharmacysMedicines.dart';
import 'package:pharmacy_app/views/screens/MedicineDetails.dart';
import '../../services/pharmacyServices.dart'; // ApiService (المفترض موجود)
import '../../core/Models/Pharmacy.dart'; // Pharmacy model مع fromJson
//import '../../core/Models/Medicine.dart'; // (اختياري) نموذج الدواء
import 'package:url_launcher/url_launcher.dart'; // لفتح الروابط/الاتصال (إضافة dependency)
//import 'package:intl/intl.dart'; // إذا رغبت بتنسيق تواريخ (اختياري)

//import '../screens/MedicineDetails.dart'; // صفحة تفاصيل الدواء (عدل المعاملات حسب الحاجة)

class PharmacyProfilePage extends StatefulWidget {
  //final ApiService apiService;
  final int pharmacyId;
  const PharmacyProfilePage({ required this.pharmacyId, Key? key}) : super(key: key);

  @override
  State<PharmacyProfilePage> createState() => _PharmacyProfilePageState();
}

class _PharmacyProfilePageState extends State<PharmacyProfilePage> {
  ApiService apiService = new ApiService();
  late Future<Pharmacy> futurePharmacy;
  //late Future<List<Medicine>> futureMedicines;
  late Future<List<Pharmacysmedicines>> futureMedicines;
  //late Future<List<Category>> futureCategories;
  final Color mainColor = const Color(0xFF1E2A38);
  final Color backColor = const Color(0xFF141E28);
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    // جلب البيانات لأول مرة
    // futurePharmacy = widget.apiService.getPharmacy(widget.pharmacyId);
    // futureMedicines = widget.apiService.getMedicine();
    //futureCategories = widget.apiService.getCategory();
    _refresh();
  }

  // تعيد Future<void> حتى نقدر نستخدمها مع RefreshIndicator
  Future<void> _refresh() async {
    setState(() {
      futurePharmacy = apiService.getPharmacy(widget.pharmacyId);
      futureMedicines = apiService.getPharmacysMedicines(widget.pharmacyId);
      //futureCategories = widget.apiService.getCategory();
    });
    // ننتظر انتهاء التحميل ليتوقف الـ RefreshIndicator
    await futurePharmacy;
  }

  // دوال مساعدة لفتح روابط / اتصال
  Future<void> _launchUrl(String? url) async {
    if (url == null || url.isEmpty) return;
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // خطأ صغير للمستخدم
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لا يمكن فتح الرابط')));
    }
  }

  Future<void> _callPhone(String? phone) async {
    if (phone == null || phone.isEmpty) return;
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لا يمكن إجراء المكالمة')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SafeArea(
        child: FutureBuilder<Pharmacy>(
          future: futurePharmacy,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // شاشة تحميل بسيطة
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              // عرض الخطأ بطريقة ودية
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('حدث خطأ أثناء جلب بيانات الصيدلية', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 8),
                    Text(snapshot.error.toString(), style: TextStyle(color: Colors.redAccent)),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _refresh(),
                      child: const Text('حاول مرة أخرى'),
                    )
                  ],
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('لا توجد بيانات', style: TextStyle(color: Colors.white)));
            }

            final Pharmacy pharmacy = snapshot.data!;

            // بيانات افتراضية لو غير موجودة
            final String name = pharmacy.Name ?? 'اسم الصيدلية';
            final String description = pharmacy.Description ?? 'لا يوجد وصف متاح';
            final String location = pharmacy.Location ?? 'لا يوجد موقع';
            final String? imageUrl = pharmacy.ImageUrl;
            final String phone = (pharmacy.Phone != null) ? pharmacy.Phone.toString() : '-';
            final int userId = pharmacy.UserId ?? 0;
            //final List<Medicine> medicines = pharmacy.PharmacyMedicines ?? [];

            return RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // ---------- الجزء العلوي مع الخلفية والاسم ----------
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                      child: Stack(
                        children:[ 
                          //1
                   Positioned(
                    top : 170,
                    right : 20,
                    child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(112, 112, 112, 100),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                   //2
                   Positioned(
                    top : 75,
                    right : 2,
                    child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(218, 230, 239, 100),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                  
                  //3
                  Positioned(
                    top : 130,
                    right : 25,
                    child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(218, 230, 239, 100),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                  

                  //4
                  Positioned(
                    top : 55,
                    right : 35,
                    child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(112, 112, 112, 100),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                  

                  //5
                  Positioned(
                    top : 150,
                    right : 70,
                    child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                  

                  //6
                  Positioned(
                    top : 40,
                    right : 83,
                    child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(218, 230, 239, 100),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                  

                  //7
                   Positioned(
                    top : 170,
                    left : 20,
                    child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(112, 112, 112, 100),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                   //8
                   Positioned(
                    top : 75,
                    left : 2,
                    child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(218, 230, 239, 100),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                  
                  //9
                  Positioned(
                    top : 130,
                    left : 25,
                    child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(218, 230, 239, 100),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                  

                  //10
                  Positioned(
                    top : 55,
                    left : 35,
                    child: Container(
                    width: 43,
                    height: 43,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(112, 112, 112, 100),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                  

                  //11
                  Positioned(
                    top : 150,
                    left : 70,
                    child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                  

                  //12
                  Positioned(
                    top : 40,
                    left : 83,
                    child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(218, 230, 239, 100),
                      shape: BoxShape.circle
                      ),
                    ),
                  ), 
                  
                          
                          Column(
                          children: [  
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        color: const Color.fromRGBO(54, 69, 86, 40),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.thumb_up_alt_outlined, color: Color.fromRGBO(161, 153, 153, 16), size: 18),
                                          const SizedBox(width: 6),
                                          Text('3', style: const TextStyle(color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        color: const Color.fromRGBO(54, 69, 86, 40),
                                      ),
                                      child: const Icon(Icons.favorite_border, color: Colors.white, size: 20),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: const Color.fromRGBO(54, 69, 86, 40),
                                    ),
                                    child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                        
                            // الصورة والاسم
                            CircleAvatar(
                              radius: 55,
                              backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
                                  ? NetworkImage("https://localhost:44383/Images/${pharmacy.ImageUrl}") as ImageProvider
                                  : const AssetImage('assets/images/image3.jpeg'),
                            ),
                            const SizedBox(height: 13),
                            Text(
                              name,
                              style: GoogleFonts.cairo(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ]),
                    ),

                    const SizedBox(height: 20),

                    // ---------- المحتوى حسب التاب ----------
                    _buildTabContent(
                      selectedTab: selectedTab,
                      onSelectTab: (i) => setState(() => selectedTab = i),
                      mainColor: mainColor,
                      pharmacy: pharmacy,
                      onCall: () => _callPhone(pharmacy.Phone),
                      onOpenLocation: () => _launchUrl(pharmacy.Location ?? pharmacy.Location),
                      // onOpenWebsite: () => _launchUrl(pharmacy.website),
                      // onOpenFacebook: () => _launchUrl(pharmacy.facebook),
                      // onOpenInstagram: () => _launchUrl(pharmacy.instagram),
                    ),

                    const SizedBox(height: 16),

                    // زر التاب (الأدوية / حول)
                    Container(
                      width: 200,
                      height: 45,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.blueGrey, width: 3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          tabButton(Icons.mail, "الأدوية", selectedTab == 1, () {
                            setState(() {
                              selectedTab = 1;
                            });
                          }),
                          tabButton(Icons.store, "حول", selectedTab == 0, () {
                            setState(() {
                              selectedTab = 0;
                            });
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabContent({
    required int selectedTab,
    required void Function(int) onSelectTab,
    required Color mainColor,
    required Pharmacy pharmacy,
    required VoidCallback onCall,
    required VoidCallback onOpenLocation,
    // required VoidCallback onOpenWebsite,
    // required VoidCallback onOpenFacebook,
    // required VoidCallback onOpenInstagram,
  }) {
    if (selectedTab == 0) {
      // تب "حول" — معلومات الصيدلية
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 310,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildIconButton(Icons.phone, "اتصال", onTap: onCall),
                  buildIconButton(Icons.location_on, pharmacy.Location ?? 'الموقع', onTap: onOpenLocation),
                  buildIconButton(Icons.email,'بريد', onTap: (){}),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: 310,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    pharmacy.Description ?? 'لا يوجد وصف',
                    style: GoogleFonts.cairo(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('3/7/2025 م', style: const TextStyle(color: Colors.white)),
                      const Spacer(),
                      const Text("تاريخ الانشاء", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('متاح', style: const TextStyle(color: Colors.white)),
                      const Spacer(),
                      const Text("الحالة", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: 310,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildSocialButton("موقع", Colors.blueGrey.withOpacity(0.3), onTap: (){}),
                  buildSocialButton("فيسبوك", Colors.blueGrey, onTap: (){}),
                  buildSocialButton("انستقرام", const Color.fromARGB(255, 238, 7, 77), onTap: (){}),
                ],
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      );
    } else if (selectedTab == 1){
      return SingleChildScrollView(
        child: FutureBuilder<List<Pharmacysmedicines>>(
                        future: futureMedicines,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            {
                              return Center(child: 
                              CircularProgressIndicator(),);
                            }
                          
                          if (snapshot.hasError)
                            {
                              return Center(child: 
                              Text('Error: ${snapshot.error}',style: TextStyle(color: Colors.white),),);
                            }

                            final list = snapshot.data ?? [];

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 0,
                              childAspectRatio: 0.5,
                              ),
                              padding: const EdgeInsets.all(20),
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                              final med = list[index];
                              //final image = (med.imageUrl != null && med.imageUrl!.isNotEmpty) ? NetworkImage(med.imageUrl!) : const AssetImage('assets/images/image1.jpg');
                              return GestureDetector(
                                onTap: () {
                                // انتقل لصفحة تفاصيل الدواء — عدّل المعاملات حسب صفحة MedicineDetails عندك
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedicineDetailsPage(MedicineId: med.Id!)));
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                          color: Color.fromARGB(255, 164, 185, 202),
                                          ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                      child: Image.network(
                                        "https://localhost:44383/Images/${med.ImageName}",
                                        height: 80,
                                        width: 120,
                                        fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                    width: 125,
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(color: Color.fromARGB(32, 0, 0, 0), spreadRadius: 2, blurRadius: 4),
                                            ],
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                          color: Color(0xFF1E2A38),
                                          ),
                                        child: Column(
                                        children: [
                                          Text(med.Name ?? 'اسم الدواء', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                                          Text(med.CategoryName ?? '-', style: const TextStyle(color: Color.fromRGBO(161, 153, 153, 16))),
                                          const SizedBox(height: 5),
                                        ],
                                     ),
                                    ),
                                  ],
                                ),
                              ),
                          );
                        },
                      );
                   },
                 )
            );
        }else {
          return Placeholder();
        }
      
      }
  }

  Widget buildIconButton(IconData icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: const Color.fromRGBO(61, 108, 145, 100)),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.cairo(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }

  Widget buildSocialButton(String text, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
        child: Text(text, style: GoogleFonts.cairo(fontSize: 12, color: Colors.white)),
      ),
    );
  }

  Widget tabButton(IconData icon, String text, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(color: active ? Colors.blueGrey : Colors.transparent, borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(text, style: GoogleFonts.cairo(fontSize: 12, color: Colors.white)),
          ],
        ),
      ),
    );
  }



