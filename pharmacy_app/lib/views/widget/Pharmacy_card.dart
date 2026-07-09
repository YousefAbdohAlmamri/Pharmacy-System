// import 'package:flutter/material.dart';
// import '../../core/Data/storeData.dart';
// import '../screens/Main_Interface.dart';



// class PharmacyCard extends StatefulWidget {
//   const PharmacyCard({super.key});

//   @override
//   State<PharmacyCard> createState() => _PharmacyCardState();
// }

// class _PharmacyCardState extends State<PharmacyCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//                                   margin: EdgeInsets.all(3),
//                                   // height: 150,
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
//                                           Color.fromARGB(255, 243, 243, 243)),
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
//                                           Container(
//                                             margin: const EdgeInsets.all(8),
//                                             height: 45,
//                                             width: 25,
//                                             decoration: const BoxDecoration(
//                                                 borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
//                                                 bottomRight: Radius.circular(10)),
                                                
//                                                 // borderRadius: BorderRadius.all(
//                                                 //     Radius.circular(8)),
//                                                 color: Color(0xFF598FBA)),
//                                             child: const Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 Text(
//                                                   "4.5",
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 12),
//                                                 ),
//                                                 Icon(Icons.star_rate_rounded,
//                                                     size: 15,
//                                                     color: Colors.amberAccent)
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(50),
//                                         //backgroundColor:
//                                         //Color.fromARGB(255, 111, 149, 174),
//                                         child: store.StoreImage,
//                                       ),
//                                       const SizedBox(height: 12),
//                                       Text(
//                                         store.StoreName!,
//                                         style: const TextStyle(fontSize: 18),
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
//                                             color: Color.fromARGB(
//                                                 255, 105, 105, 105)),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//   }
// }















// // class HotelCard extends StatelessWidget {
// //   const HotelCard({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(builder: (context) => const HotelDetailsPage()),
// //         );
// //       },
// //       child: Container(
// //         width: 100,
// //         height: 100,
// //         margin: const EdgeInsets.all(8),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(16),
// //           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             Stack(
// //               children: [
// //                 ClipRRect(
// //                   borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
// //                   child: Image.asset(
// //                     "assets/images/img_1.jpg",
// //                     height: 160,
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //                 Positioned(
// //                   top: 8,
// //                   left: 8,
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //                     decoration: BoxDecoration(
// //                       color: Colors.blue[300],
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                     child: Row(
// //                       children: const [
// //                         Icon(Icons.star, color: Colors.yellow, size: 16),
// //                         SizedBox(width: 4),
// //                         Text('4.5', style: TextStyle(color: Colors.white)),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 8),
// //             Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //               margin: const EdgeInsets.symmetric(horizontal: 90),
// //               decoration: BoxDecoration(
// //                 color: Colors.blue[700],
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               child: const Center(
// //                 child: Text(
// //                   'فندق',
// //                   style: TextStyle(color: Colors.white, fontSize: 12),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 12),
// //               child: Container(
// //                 padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
// //                 decoration: BoxDecoration(
// //                   color: Colors.blueGrey[100],
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: const Center(
// //                   child: Text(
// //                     'نارسس صنعاء',
// //                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 6),
// //             const Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 12),
// //               child: Text(
// //                 'صنعاء - الستين الشمالي',
// //                 style: TextStyle(fontSize: 14, color: Colors.black54),
// //                 textAlign: TextAlign.center,
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             const Divider(),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: const [
// //                   Icon(Icons.phone, color: Colors.blue),
// //                   Icon(Icons.share, color: Colors.blue),
// //                   Icon(Icons.favorite_border, color: Colors.blue),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // صفحة التفاصيل
// // class HotelDetailsPage extends StatelessWidget {
// //   const HotelDetailsPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("تفاصيل الفندق"),
// //       ),
// //       body: const Center(
// //         child: Text(
// //           'هنا يمكنك عرض تفاصيل فندق نارسس صنعاء بالكامل.',
// //           style: TextStyle(fontSize: 18),
// //         ),
// //       ),
// //     );
// //   }
// // }