import 'package:pharmacy_app/core/Models/Pharmacy.dart';
import 'package:pharmacy_app/services/pharmacyServices.dart';
import 'package:pharmacy_app/views/screens/PharmacyDetail.dart';

import '../widget/Drawer.dart';
import 'package:flutter/material.dart';

final List<String> oo = ["مؤكدة", "غير مكتملة", "جاري التحقق", "مرفوضة"];

class followuprequests extends StatefulWidget {
  @override
  _followuprequestsState createState() => _followuprequestsState();
}

class _followuprequestsState extends State<followuprequests> {
  final Color backColor = const Color(0xFF141E28); // اللون الخلفي
  final Color mainColor = const Color(0xFF1E2A38); // اللون الحاويات

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  ApiService apiService = new ApiService();
  late Future<List<Pharmacy>> futurePharmacies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      futurePharmacies = apiService.getPharmacies();
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _globalKey,
          drawer: const drawer1(),
          backgroundColor: backColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(95),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: backColor,
              child: AppBar(
                backgroundColor: backColor,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    _globalKey.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Color.fromARGB(255, 143, 141, 141),
                    size: 32,
                  ),
                ),
                title: const Text(
                  "الصيدليات المنشأه",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_active_outlined,
                      color: Color.fromARGB(255, 143, 141, 141),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const homeChat()));
                    },
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      color: Color.fromARGB(255, 143, 141, 141),
                      size: 30,
                    ),
                  ),
                ],
                // bottom: const TabBar(
                //   tabAlignment: TabAlignment.start,
                //   isScrollable: true,
                //   dividerColor: Color.fromARGB(0, 96, 125, 139),
                //   labelColor: Color(0xFF3D6C91),
                //   indicatorColor: Color(0xFF3D6C91),
                //   unselectedLabelColor: Color.fromARGB(255, 174, 174, 174),
                //   tabs: [
                //     Text("الكل", style: TextStyle(fontSize: 18)),
                //     Text("مؤكدة", style: TextStyle(fontSize: 18)),
                //     Text("غير مكتملة", style: TextStyle(fontSize: 18)),
                //     Text("جاري التحقق", style: TextStyle(fontSize: 18)),
                //     Text("مرفوضة", style: TextStyle(fontSize: 18)),
                //   ],
                // ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: 
              FutureBuilder<List<Pharmacy>>(
                future: futurePharmacies,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          {
                            return Center(child: 
                            CircularProgressIndicator(),);
                          }
                        
                        if (snapshot.hasError)
                          {
                            return Center(child: 
                            Text('Error: ${snapshot.error}'),);
                          }
            
                          final list = snapshot.data ?? [];
            
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final pharmacy = list[index];
                    
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PharmacyProfilePage(pharmacyId: pharmacy.Id,)));
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 75,
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(45, 0, 0, 0),
                                  blurRadius: 10,
                                  spreadRadius: 4,
                                  offset: const Offset(0, 1),
                                )
                              ]),
                          child: GestureDetector(
                            child: Stack(
                              children: [
                                ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    //backgroundColor:
                                    //Color.fromARGB(255, 111, 149, 174),
                                    child: Image.network(
                                            "https://localhost:44383/Images/${pharmacy.ImageUrl}",width: 70,height: 70,),
                                  ),
                                  title: Text(
                                    pharmacy.Name,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(pharmacy.Location!,style: TextStyle(color: Color.fromARGB(255, 139, 139, 141)),),
                                  //subtitle: Text("${book.bookingDate}",style: TextStyle(color: Color.fromARGB(255, 139, 139, 141)),),
                                  trailing:  IconButton( onPressed: (){}, 
                                  icon:Icon(Icons.more_vert_outlined,color: Color.fromARGB(255, 139, 139, 141),)),
                                ),
                                
                              ],
                            ),
                          )),
                    );
                  },
                );
                      }
              ),
              
          ),
    );
  }
}

// class w{
//   String
// }
class curvedBoxPainter extends CustomPainter {
  final String state;
  curvedBoxPainter(this.state);
  // final Color? colorState;
  @override
  void paint(Canvas canvas, Size size) {
    Color colorState = Colors.white;
    if (state == "مؤكدة") {
      colorState = const Color(0xFF67B287);
    }
    if (state == "غير مكتملة") {
      colorState = const Color(0xFFC6CB3A);
    }
    if (state == "جاري التحقق") {
      colorState = const Color(0xFF9C9C9C);
    }
    if (state == "مرفوضة") {
      colorState = const Color(0xFFD15E33);
    }

    final Paint paint = Paint()
      ..color = colorState
      ..style = PaintingStyle.fill;
    final Path path = Path();
    path.moveTo(0, size.height * 0.4);
    path.lineTo(size.width * 0.4, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
