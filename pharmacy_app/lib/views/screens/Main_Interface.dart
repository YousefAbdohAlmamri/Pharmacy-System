// import 'dart:js_interop';


import 'package:pharmacy_app/views/screens/test.dart';

import '../../core/Models/Pharmacy.dart';
import '../../services/pharmacyServices.dart';
import '../widget/Drawer.dart';
import 'PharmacyDetail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color backColor = const Color(0xFF141E28); // اللون الخلفي
  final ScrollController _scrollController = ScrollController();
  bool _isCarouselVisible = true; // حالة عرض الـ CarouselSlider
  final double _scrollOffsetThreshold = 100; // مقدار السحب المطلوب للإخفاء
  final GlobalKey<ScaffoldState> _globalKey =
      GlobalKey<ScaffoldState>(); //للدراور

  ApiService apiService = new ApiService();
  late Future<List<Pharmacy>> futurePharmacies;

void _refresh()
{
  futurePharmacies = apiService.getPharmacies();
}

  @override
  void initState() {
    super.initState();
    _refresh();

    // إضافة الاستماع لتحركات التمرير
    _scrollController.addListener(() {
      if (_scrollController.offset > _scrollOffsetThreshold &&
          _isCarouselVisible) {
        setState(() {
          _isCarouselVisible = false; // إخفاء الـ CarouselSlider
        });
      } else if (_scrollController.offset <= _scrollOffsetThreshold &&
          !_isCarouselVisible) {
        setState(() {
          _isCarouselVisible = true; // إظهار الـ CarouselSlider
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // تنظيف الـ ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          key: _globalKey,
          drawer: drawer1(),
          backgroundColor: backColor,
          appBar: AppBar(
            backgroundColor: backColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                _globalKey.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Color.fromARGB(255, 143, 141, 141),
                size: 27,
              ),
            ),
            title: const Text(
              "الصفحة الرئيسية",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color.fromARGB(0, 43, 43, 43),
                      elevation: 0,
                      // width: 150,
                      // shape: ShapeBorder,
                      content: Container(
                        height: 45,
                        // width: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 48, 48, 48),
                            borderRadius: BorderRadius.circular(50)),
                        child: const Center(
                          child: Text(
                            "لايوجد اي اشعارات",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  color: Color.fromARGB(255, 143, 141, 141),
                  size: 27,
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => const MedicineSearchPage()));
                },
                icon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 143, 141, 141),
                  size: 27,
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // صندوق البحث
                  // Container(
                  //   // width: 370,
                  //   height: 45,
                  //   decoration: BoxDecoration(
                  //     // color: const Color.fromARGB(255, 245, 245, 245),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: TextFormField(
                  //     style: const TextStyle(fontSize: 18),
                  //     decoration: InputDecoration(
                  //         filled: true,
                  //         fillColor: const Color.fromARGB(255, 245, 245, 245),
                  //         hintText: "بحث ....",
                  //         prefixIcon: IconButton(
                  //           onPressed: () {},
                  //           icon: const Icon(Icons.search),
                  //         ),
                  //         // suffixIcon: IconButton(
                  //         //   onPressed: () {},
                  //         //   icon: const Icon(
                  //         //     Icons.filter_alt,
                  //         //     color: Colors.grey,
                  //         //   ),
                  //         // ),
                  //         border: const OutlineInputBorder(
                  //             borderSide: BorderSide.none)),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
            
                  // CarouselSlider يظهر أو يختفي بناءً على الحالة
                  AnimatedContainer(
                    color: backColor,
                    duration: const Duration(milliseconds: 300),
                    height: _isCarouselVisible ? 180.0 : 0.0,
                    child: _isCarouselVisible
                        ? CarouselSlider(
                            options: CarouselOptions(
                              height: 200.0,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 0.8,
                              aspectRatio: 2.0,
                              initialPage: 0,
                            ),
                            items: [
                              'assets/images/image3.jpeg',
                              'assets/images/image2.jpeg',
                              'assets/images/image1.jpg',
                            ].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFF3D6C91),
                                      border:
                                          Border.all(color: Colors.blueGrey),
                                      image: DecorationImage(
                                        image: AssetImage(i),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 30),
            
            
                  const Text(
                    'الصيدليات',
                    style:
                        TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
            
                  
                  //const SizedBox(height: 20),
            
            
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
            
                          return GridView.builder(
                            itemCount: list.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 0.7),
                            //لمنع التمرير داخلة
                            //physics: const NeverScrollableScrollPhysics(),
                            physics : NeverScrollableScrollPhysics() ,
                            shrinkWrap: true,
                            //---------------------------
                            itemBuilder: (context, index) {
                              final pharmacy = list[index];
                              // List<StorePhone> storephone = storePhone
                              //     .where((element) =>
                              //         element.StoreID == store.StoreID)
                              //     .toList();
                              // // final phone = storephone[0];
                              return GestureDetector(
                                        
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PharmacyProfilePage(pharmacyId: pharmacy.Id,)));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => Stored_About(
                                  //         stores[index], storephone)));
                                },
                                child: Container(
                                  //height: 100,
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.only(left: 0,top: 0,right: 0,bottom: 0),
                                  // width: 100,
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(45, 0, 0, 0),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color:
                                          Color.fromRGBO(35, 48, 63, 100)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFF598FBA),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))),
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  pharmacy.isFavorite =
                                                      !pharmacy.isFavorite;
                                                  // isFavorite = !isFavorite;
                                                });
                                              },
                                              
                                              icon: pharmacy.isFavorite
                                                  ? const Icon(Icons.favorite,
                                                      size: 26,
                                                      color: Color.fromARGB(
                                                          255, 253, 88, 88))
                                                  : const Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.white),
                                            ),
                                          ),
                                          // Positioned(
                                          //   top: 0,
                                          //   left: 0,
                                          //   child: Container(
                                          //   margin: const EdgeInsets.all(8),
                                          //   height: 45,
                                          //   width: 25,
                                          //   decoration: const BoxDecoration(
                                          //       borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                                          //       bottomRight: Radius.circular(10)),
                                                
                                          //       // borderRadius: BorderRadius.all(
                                          //       //     Radius.circular(8)),
                                          //       color: Color(0xFF598FBA)),
                                          //   child: const Column(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.spaceEvenly,
                                          //     children: [
                                          //       Text(
                                          //         "4.5",
                                          //         style: TextStyle(
                                          //             color: Colors.white,
                                          //             fontSize: 12),
                                          //       ),
                                          //       Icon(Icons.star_rate_rounded,
                                          //           size: 15,
                                          //           color: Colors.amberAccent)
                                          //     ],
                                          //   ),
                                          // ),
                                          // ),
                                        ],
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        //backgroundColor:
                                        //Color.fromARGB(255, 111, 149, 174),
                                        child: Image.network(
                                            "https://localhost:44383/Images/${pharmacy.ImageUrl}",width: 110,height: 110,),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        pharmacy.Name,
                                        style: const TextStyle(color: Colors.grey,fontSize: 18),
                                      ),
                                      // Text(
                                      //   store.StoreType!,
                                      //   style: const TextStyle(
                                      //       fontSize: 12,
                                      //       color: Color.fromARGB(
                                      //           255, 105, 105, 105)),
                                      // ),
                                      
                                      Text(
                                        pharmacy.Location!,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(255, 139, 139, 141)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                      },
                    ),
                        
                  
                  
                ],
              ),
            ),
          ),
        ),
       
      ),
    );
  }
}


// // import 'dart:js_interop';

// import '../../core/Models/Stores.dart';
// import '../widget/Drawer.dart';
// import 'PharmacyDetail.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// final List<Stores> stores = [
//   Stores(
//       StoreID: 1,
//       StoreImage: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 100,
//         height: 100,
//       ),
//       StoreImageForFollow: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 60,
//         height: 60,
//       ),
//       StoreName: "فايف ستارز",
//       StoreDescription:
//           "فندق رائع ومتميز في خدماتة ويوفر راحة وحسن الاستضافة ويهتم بكل مايسعد ويفرح العميل",
//       StoreType: "فندق",
//       StoreLocation: "صنعاء - الستين الشمالي"),
//   Stores(
//       StoreID: 2,
//       StoreImage: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 100,
//         height: 100,
//       ),
//       StoreImageForFollow: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 60,
//         height: 60,
//       ),
//       StoreName: "الحديثة",
//       StoreDescription:
//           "صالة رائع ومتميز في خدماتة ويوفر راحة وحسن الاستضافة ويهتم بكل مايسعد ويفرح العميل",
//       StoreType: "صالة افراح",
//       StoreLocation: "صنعاء - الستين الشمالي"),
//   Stores(
//       StoreID: 3,
//       StoreImage: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 100,
//         height: 100,
//       ),
//       StoreImageForFollow: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 60,
//         height: 60,
//       ),
//       StoreName: "شملان",
//       StoreDescription:
//           "ثلاجات رائع ومتميز في خدماتة ويوفر راحة وحسن الاستضافة ويهتم بكل مايسعد ويفرح العميل",
//       StoreType: "ثلاجة",
//       StoreLocation: "صنعاء - الستين الشمالي"),
//   Stores(
//       StoreID: 4,
//       StoreImage: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 100,
//         height: 100,
//       ),
//       StoreImageForFollow: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 60,
//         height: 60,
//       ),
//       StoreName: "ميوزك",
//       StoreDescription:
//           "ديجي رائع ومتميز في خدماتة ويوفر راحة وحسن الاستضافة ويهتم بكل مايسعد ويفرح العميل",
//       StoreType: "دي جي",
//       StoreLocation: "صنعاء - الستين الشمالي"),
//   Stores(
//       StoreID: 5,
//       StoreImage: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 100,
//         height: 100,
//       ),
//       StoreImageForFollow: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 60,
//         height: 60,
//       ),
//       StoreName: "الوحدة",
//       StoreDescription:
//           "ملعب رائع ومتميز في خدماتة ويوفر راحة وحسن الاستضافة ويهتم بكل مايسعد ويفرح العميل",
//       StoreType: "ملعب",
//       StoreLocation: "صنعاء - الستين الشمالي"),
//   Stores(
//       StoreID: 6,
//       StoreImage: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 100,
//         height: 100,
//       ),
//       StoreImageForFollow: const Image(
//         image: AssetImage("assets/images/img_1.jpg"),
//         fit: BoxFit.cover,
//         width: 60,
//         height: 60,
//       ),
//       StoreName: "نارسس",
//       StoreDescription:
//           "فندق رائع ومتميز في خدماتة ويوفر راحة وحسن الاستضافة ويهتم بكل مايسعد ويفرح العميل",
//       StoreType: "فندق",
//       StoreLocation: "صنعاء - الستين الشمالي"),
// ];
// final List<StorePhone> storePhone = [
//   StorePhone(1, 7757575757),
//   StorePhone(1, 7757575757),
//   StorePhone(2, 7757588857),
//   StorePhone(2, 7444444442),
//   StorePhone(3, 7733333757),
//   StorePhone(4, 7757777757),
// ];

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final Color backColor = const Color(0xFF141E28); // اللون الخلفي
//   final ScrollController _scrollController = ScrollController();
//   bool _isCarouselVisible = true; // حالة عرض الـ CarouselSlider
//   final double _scrollOffsetThreshold = 100; // مقدار السحب المطلوب للإخفاء
//   final GlobalKey<ScaffoldState> _globalKey =
//       GlobalKey<ScaffoldState>(); //للدراور

//   @override
//   void initState() {
//     super.initState();

//     // إضافة الاستماع لتحركات التمرير
//     _scrollController.addListener(() {
//       if (_scrollController.offset > _scrollOffsetThreshold &&
//           _isCarouselVisible) {
//         setState(() {
//           _isCarouselVisible = false; // إخفاء الـ CarouselSlider
//         });
//       } else if (_scrollController.offset <= _scrollOffsetThreshold &&
//           !_isCarouselVisible) {
//         setState(() {
//           _isCarouselVisible = true; // إظهار الـ CarouselSlider
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose(); // تنظيف الـ ScrollController
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: DefaultTabController(
//         length: 6,
//         child: Scaffold(
//           key: _globalKey,
//           drawer: drawer1(),
//           backgroundColor: backColor,
//           appBar: AppBar(
//             backgroundColor: backColor,
//             elevation: 0,
//             leading: IconButton(
//               onPressed: () {
//                 _globalKey.currentState!.openDrawer();
//               },
//               icon: const Icon(
//                 Icons.menu,
//                 color: Color.fromARGB(255, 143, 141, 141),
//                 size: 27,
//               ),
//             ),
//             title: const Text(
//               "الصفحة الرئيسية",
//               style: TextStyle(color: Colors.white, fontSize: 22),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       backgroundColor: const Color.fromARGB(0, 43, 43, 43),
//                       elevation: 0,
//                       // width: 150,
//                       // shape: ShapeBorder,
//                       content: Container(
//                         height: 45,
//                         // width: 50,
//                         margin: EdgeInsets.symmetric(horizontal: 60),
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(255, 48, 48, 48),
//                             borderRadius: BorderRadius.circular(50)),
//                         child: const Center(
//                           child: Text(
//                             "لايوجد اي اشعارات",
//                             style: TextStyle(fontSize: 15, color: Colors.white),
//                             // textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 icon: const Icon(
//                   Icons.notifications_active_outlined,
//                   color: Color.fromARGB(255, 143, 141, 141),
//                   size: 27,
//                 ),
//               ),
//               const SizedBox(width: 4),
//               IconButton(
//                 onPressed: () {
//                   // Navigator.of(context).push(MaterialPageRoute(
//                   //     builder: (context) => const homeChat()));
//                 },
//                 icon: const Icon(
//                   Icons.chat_bubble_outline,
//                   color: Color.fromARGB(255, 143, 141, 141),
//                   size: 27,
//                 ),
//               ),
//               const SizedBox(width: 15),
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Column(children: [
//               Padding(
//                 padding: const EdgeInsets.all(17),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // صندوق البحث
//                     // Container(
//                     //   // width: 370,
//                     //   height: 45,
//                     //   decoration: BoxDecoration(
//                     //     // color: const Color.fromARGB(255, 245, 245, 245),
//                     //     borderRadius: BorderRadius.circular(10),
//                     //   ),
//                     //   child: TextFormField(
//                     //     style: const TextStyle(fontSize: 18),
//                     //     decoration: InputDecoration(
//                     //         filled: true,
//                     //         fillColor: const Color.fromARGB(255, 245, 245, 245),
//                     //         hintText: "بحث ....",
//                     //         prefixIcon: IconButton(
//                     //           onPressed: () {},
//                     //           icon: const Icon(Icons.search),
//                     //         ),
//                     //         // suffixIcon: IconButton(
//                     //         //   onPressed: () {},
//                     //         //   icon: const Icon(
//                     //         //     Icons.filter_alt,
//                     //         //     color: Colors.grey,
//                     //         //   ),
//                     //         // ),
//                     //         border: const OutlineInputBorder(
//                     //             borderSide: BorderSide.none)),
//                     //   ),
//                     // ),
//                     const SizedBox(height: 20),

//                     // CarouselSlider يظهر أو يختفي بناءً على الحالة
//                     AnimatedContainer(
//                       color: backColor,
//                       duration: const Duration(milliseconds: 300),
//                       height: _isCarouselVisible ? 180.0 : 0.0,
//                       child: _isCarouselVisible
//                           ? CarouselSlider(
//                               options: CarouselOptions(
//                                 height: 200.0,
//                                 autoPlay: true,
//                                 enlargeCenterPage: true,
//                                 viewportFraction: 0.8,
//                                 aspectRatio: 2.0,
//                                 initialPage: 0,
//                               ),
//                               items: [
//                                 'assets/images/image3.jpeg',
//                                 'assets/images/image2.jpeg',
//                                 'assets/images/image1.jpg',
//                               ].map((i) {
//                                 return Builder(
//                                   builder: (BuildContext context) {
//                                     return Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       margin: const EdgeInsets.symmetric(
//                                           horizontal: 0.0),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(15),
//                                         color: Color(0xFF3D6C91),
//                                         border:
//                                             Border.all(color: Colors.blueGrey),
//                                         image: DecorationImage(
//                                           image: AssetImage(i),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 );
//                               }).toList(),
//                             )
//                           : const SizedBox.shrink(),
//                     ),
//                     const SizedBox(height: 30),


//                     const Text(
//                       'الصيدليات',
//                       style:
//                           TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 10),

                    
//                     //const SizedBox(height: 20),


//                     SizedBox(
//                       //height: 750,
//                       child: GridView.builder(
//                             itemCount: stores.length,
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     crossAxisSpacing: 20,
//                                     mainAxisSpacing: 20,
//                                     childAspectRatio: 0.7),
//                             //لمنع التمرير داخلة
//                             //physics: const NeverScrollableScrollPhysics(),
//                             physics : NeverScrollableScrollPhysics() ,
//                             shrinkWrap: true,
//                             //---------------------------
//                             itemBuilder: (context, index) {
//                               final store = stores[index];
//                               List<StorePhone> storephone = storePhone
//                                   .where((element) =>
//                                       element.StoreID == store.StoreID)
//                                   .toList();
//                               // final phone = storephone[0];
//                               return GestureDetector(
                  
//                                 onTap: () {
//                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => PharmacyProfilePage()));
//                                   // Navigator.of(context).push(MaterialPageRoute(
//                                   //     builder: (context) => Stored_About(
//                                   //         stores[index], storephone)));
//                                 },
//                                 child: Container(
//                                   //height: 100,
//                                   margin: EdgeInsets.all(5),
//                                   padding: EdgeInsets.only(left: 0,top: 0,right: 0,bottom: 0),
//                                   // width: 100,
//                                   decoration: const BoxDecoration(
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Color.fromARGB(45, 0, 0, 0),
//                                           blurRadius: 4,
//                                           spreadRadius: 1,
//                                           offset: Offset(0, 1),
//                                         ),
//                                       ],
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(10)),
//                                       color:
//                                           Color.fromRGBO(35, 48, 63, 100)),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Container(
//                                             width: 40,
//                                             height: 40,
//                                             decoration: const BoxDecoration(
//                                                 color: Color(0xFF598FBA),
//                                                 borderRadius: BorderRadius.only(
//                                                     topRight:
//                                                         Radius.circular(10),
//                                                     bottomLeft:
//                                                         Radius.circular(10))),
//                                             child: IconButton(
//                                               onPressed: () {
//                                                 setState(() {
//                                                   store.isFavorite =
//                                                       !store.isFavorite;
//                                                   // isFavorite = !isFavorite;
//                                                 });
//                                               },
//                                               icon: store.isFavorite
//                                                   ? const Icon(Icons.favorite,
//                                                       size: 26,
//                                                       color: Color.fromARGB(
//                                                           255, 253, 88, 88))
//                                                   : const Icon(
//                                                       Icons.favorite_border,
//                                                       color: Colors.white),
//                                             ),
//                                           ),
//                                           // Positioned(
//                                           //   top: 0,
//                                           //   left: 0,
//                                           //   child: Container(
//                                           //   margin: const EdgeInsets.all(8),
//                                           //   height: 45,
//                                           //   width: 25,
//                                           //   decoration: const BoxDecoration(
//                                           //       borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
//                                           //       bottomRight: Radius.circular(10)),
                                                
//                                           //       // borderRadius: BorderRadius.all(
//                                           //       //     Radius.circular(8)),
//                                           //       color: Color(0xFF598FBA)),
//                                           //   child: const Column(
//                                           //     mainAxisAlignment:
//                                           //         MainAxisAlignment.spaceEvenly,
//                                           //     children: [
//                                           //       Text(
//                                           //         "4.5",
//                                           //         style: TextStyle(
//                                           //             color: Colors.white,
//                                           //             fontSize: 12),
//                                           //       ),
//                                           //       Icon(Icons.star_rate_rounded,
//                                           //           size: 15,
//                                           //           color: Colors.amberAccent)
//                                           //     ],
//                                           //   ),
//                                           // ),
//                                           // ),
//                                         ],
//                                       ),
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(50),
//                                         //backgroundColor:
//                                         //Color.fromARGB(255, 111, 149, 174),
//                                         child: store.StoreImage,
//                                       ),
//                                       const SizedBox(height: 3),
//                                       Text(
//                                         store.StoreName!,
//                                         style: const TextStyle(color: Colors.grey,fontSize: 18),
//                                       ),
//                                       // Text(
//                                       //   store.StoreType!,
//                                       //   style: const TextStyle(
//                                       //       fontSize: 12,
//                                       //       color: Color.fromARGB(
//                                       //           255, 105, 105, 105)),
//                                       // ),
                                      
//                                       Text(
//                                         store.StoreLocation!,
//                                         style: const TextStyle(
//                                             fontSize: 12,
//                                             color: Color.fromARGB(255, 139, 139, 141)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
                          
//                     ),
                    
//                   ],
//                 ),
//               ),
//             ]),
//           ),
//         ),
       
//       ),
//     );
//   }
// }

