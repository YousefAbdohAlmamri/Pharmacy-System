import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/Models/Medicine.dart';
import 'package:pharmacy_app/services/pharmacyServices.dart';


// class MedicineDetailsPage extends StatelessWidget {
//   final int MedicineId;
//   final Color backColor = const Color(0xFF141E28); // اللون الخلفي
//   const MedicineDetailsPage({required this.MedicineId,super.key});

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }

class MedicineDetailsPage extends StatefulWidget {
  final int MedicineId;

  const MedicineDetailsPage({required this.MedicineId ,super.key});

  @override
  State<MedicineDetailsPage> createState() => _MedicineDetailsPageState();
}

class _MedicineDetailsPageState extends State<MedicineDetailsPage> {
  
//   final Color backColor = const Color(0xFF141E28); // اللون الخلفي
ApiService apiService = new ApiService();  
  late Future<Medicine> futureMedicine; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }
  
    Future<void> _refresh() async {
    setState(() {
      futureMedicine = apiService.getMedicineById(widget.MedicineId);
      
      
    });
    
    await futureMedicine;
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF1C2733), // خلفية داكنة
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: futureMedicine,
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
                    Text('حدث خطأ أثناء جلب بيانات الدواء', style: TextStyle(color: Colors.white)),
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

            final Medicine medicine = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الشريط العلوي
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {
                        Navigator.of(context).pop();
                      },icon: Icon(Icons.arrow_back_ios,color: Colors.white, size: 20),),
                      Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
                    ],
                  ),
                  const SizedBox(height: 20),
                    
                  // صورة واسم الدواء
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: (medicine.ImageUrl != null)
                                  ? NetworkImage("https://localhost:44383/Images/${medicine.ImageUrl}") as ImageProvider
                                  : const AssetImage('assets/images/image3.jpeg'),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicine.Name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              buildInfoItem("الألم"),
                              SizedBox(width: 15,),
                              buildInfoItem("السعر"),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              buildInfoItem("الشركة"),
                              SizedBox(width: 15,),
                              buildInfoItem("بلاد الصنع"),
                              
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                    
                  const SizedBox(height: 20),
                    
                  // الوصف الرمادي
                  Container(
                    width: 350,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B3B4B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      medicine.Description!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                    
                  ),
                    
                  SizedBox(height: 20),
                    
                  // المعلومات السفلية
                  Container(
                    width: 350,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B3B4B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        buildBottomInfoRow("تاريخ الانشاء", medicine.DateCreated!),
                        const SizedBox(height: 8),
                        buildBottomInfoRow("تاريخ الانتهاء", medicine.ExpirationDate!),
                        const SizedBox(height: 8),
                        buildBottomInfoRow("الحالة", "متاح"),
                      ],
                    ),
                  ),
                ],
              );
          }
            ),
          ),
        ),
      ),
    );
  }
}

  // عنصر معلومات علوي
  Widget buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }

  // عنصر معلومات سفلي
  Widget buildBottomInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
