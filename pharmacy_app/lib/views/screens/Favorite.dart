// import 'package:flutter/material.dart';

// class Favorite extends StatelessWidget {
//   const Favorite({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

//import 'dart:js_interop';

//import 'package:bookking/Models/Stores.dart';


// import 'dart:js_interop';

// import 'package:bookking/Models/Stores.dart';

//import '../../core/Models/Stores.dart';
//import 'Main_Interface.dart';
//import 'Our_Working_Store.dart';
import 'package:pharmacy_app/services/pharmacyServices.dart';
import 'package:pharmacy_app/views/screens/PharmacyDetail.dart';

import '../widget/Drawer.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final Color backColor = const Color(0xFF141E28); // اللون الخلفي
  final Color fieldColor = const Color(0xFF24323A); // input fill
  final GlobalKey<ScaffoldState> _globalKey =
      GlobalKey<ScaffoldState>(); //للدراور

  // final List<Stores> filteredStoreType = stores.where((element) {
  //   return element.isFavorite == true;
  // }).toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            "المفضلة",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_active_outlined,
                color: Color.fromARGB(255, 143, 141, 141),
                size: 27,
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => const homeChat()));
              },
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Color.fromARGB(255, 143, 141, 141),
                size: 27,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 10),
                  // width: 370,
                  height: 45,
                  decoration: BoxDecoration(
                    color: fieldColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        hintText: "بحث ....",
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search,
                          color: Colors.grey,),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.filter_alt,
                            color: Colors.grey,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none)),
                  ),
                ),
                const SizedBox(height: 20),
                const TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  dividerColor: Color.fromARGB(0, 96, 125, 139),
                  labelColor: Color(0xFF3D6C91),
                  indicatorColor: Color(0xFF3D6C91),
                  unselectedLabelColor: Color.fromARGB(255, 174, 174, 174),
                  tabs: [
                    Text("الكل", style: TextStyle(fontSize: 16)),
                    Text("القلب", style: TextStyle(fontSize: 16)),
                    Text("المعدة", style: TextStyle(fontSize: 16)),
                    Text("المخ", style: TextStyle(fontSize: 16)),
                    Text("الكبد", style: TextStyle(fontSize: 16)),
                    Text("الكلى", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: TabBarView(children: [
                    false
                        ? const Center(
                            child: Text("لا يوجد اي  مفضلة",
                                style: TextStyle(color: Colors.grey,fontSize: 22)))
                        : Container(
                            child: GridView.builder(
                              itemCount: 3,
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
                                
                                // List<StorePhone> storephone = storePhone
                                //     .where((element) =>
                                //         element.StoreID == store.StoreID)
                                //     .toList();
                                // // final phone = storephone[0];
                                return GestureDetector(
                                          
                                  onTap: () {
                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PharmacyProfilePage(apiService: ApiService(),pharmacyId: pharmacy.Id,)));
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
                                                  // setState(() {
                                                  //   pharmacy.isFavorite =
                                                  //       !pharmacy.isFavorite;
                                                  //   // isFavorite = !isFavorite;
                                                  // });
                                                },
                                                
                                                // icon: pharmacy.isFavorite
                                                icon: false
                                                    ? const Icon(Icons.favorite,
                                                        size: 26,
                                                        color: Color.fromARGB(
                                                            255, 253, 88, 88))
                                                    : const Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.white),
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          //backgroundColor:
                                          //Color.fromARGB(255, 111, 149, 174),
                                          child: Image.asset('assets/images/img_1.jpg',width: 100,height: 100,),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          'صيدلية صنعاء',
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
                                          'الستين الشمالي',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(255, 139, 139, 141)),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    // const StoresFavoriteGridView(storeType: "فندق"),
                    // const StoresFavoriteGridView(storeType: "صالة افراح"),
                    // const StoresFavoriteGridView(storeType: "ثلاجة"),
                    // const StoresFavoriteGridView(storeType: "دي جي"),
                    // const StoresFavoriteGridView(storeType: "ملعب"),
                  ]),
                )
              ],
            )),
      ),
    );
  }
}

// // class StoresFavoriteGridView extends StatefulWidget {
// //   final String storeType;
// //   const StoresFavoriteGridView({super.key, required this.storeType});

// //   @override
// //   State<StoresFavoriteGridView> createState() => _StoresFavoriteGridViewState();
// // }

// // class _StoresFavoriteGridViewState extends State<StoresFavoriteGridView> {
// //   @override
// //   Widget build(BuildContext context) {
// //     final List<Stores> filteredStoreType = stores.where((element) {
// //       return element.StoreType == widget.storeType &&
// //           element.isFavorite == true;
// //     }).toList();
// //     return filteredStoreType.isEmpty
// //         ? Center(
// //             child: Text("لا يوجد اي ${widget.storeType} مفضلة",
// //                 style: const TextStyle(fontSize: 22)))
// //         : Container(
// //             child: GridView.builder(
// //               itemCount: filteredStoreType.length,
// //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                   crossAxisCount: 2,
// //                   crossAxisSpacing: 20,
// //                   mainAxisSpacing: 20,
// //                   childAspectRatio: 0.7),
// //               //لمنع التمرير داخلة
// //               physics: const NeverScrollableScrollPhysics(),
// //               shrinkWrap: true,
// //               //---------------------------
// //               itemBuilder: (context, index) {
// //                 final store = filteredStoreType[index];
// //                 // List<StorePhone> storephone = storePhone
// //                 //     .where((element) => element.StoreID == store.StoreID)
// //                 //     .toList();
// //                 return GestureDetector(
// //                   onTap: () {
// //                     // Navigator.of(context).push(MaterialPageRoute(
// //                     //     builder: (context) => Stored_About(
// //                     //         filteredStoreType[index], storephone)));
// //                   },
// //                   child: Container(
// //                     margin: const EdgeInsets.all(3),
// //                     // height: 150,
// //                     // width: 100,
// //                     decoration: const BoxDecoration(
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Color.fromARGB(45, 0, 0, 0),
// //                             blurRadius: 4,
// //                             spreadRadius: 1,
// //                             offset: Offset(0, 1),
// //                           ),
// //                         ],
// //                         borderRadius: BorderRadius.all(Radius.circular(10)),
// //                         color: Color.fromARGB(255, 243, 243, 243)),
// //                     child: Column(
// //                       children: [
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             Container(
// //                               width: 40,
// //                               height: 40,
// //                               decoration: const BoxDecoration(
// //                                   color: Color(0xFF3D6C91),
// //                                   borderRadius: BorderRadius.only(
// //                                       topRight: Radius.circular(10),
// //                                       bottomLeft: Radius.circular(10))),
// //                               child: IconButton(
// //                                 onPressed: () {
// //                                   setState(() {
// //                                     store.isFavorite = !store.isFavorite;
// //                                     // isFavorite = !isFavorite;
// //                                   });
// //                                 },
// //                                 icon: store.isFavorite
// //                                     ? const Icon(
// //                                         Icons.favorite,
// //                                         size: 26,
// //                                         color: Color.fromARGB(255, 253, 88, 88),
// //                                       )
// //                                     : const Icon(Icons.favorite_border,
// //                                         color: Colors.white),
// //                               ),
// //                             ),
// //                             Container(
// //                               margin: const EdgeInsets.all(8),
// //                               height: 25,
// //                               width: 45,
// //                               decoration: const BoxDecoration(
// //                                   borderRadius:
// //                                       BorderRadius.all(Radius.circular(8)),
// //                                   color: Color(0xFF3D6C91)),
// //                               child: const Row(
// //                                 mainAxisAlignment:
// //                                     MainAxisAlignment.spaceEvenly,
// //                                 children: [
// //                                   Text(
// //                                     "4.5",
// //                                     style: const TextStyle(
// //                                         color: Colors.white, fontSize: 12),
// //                                   ),
// //                                   Icon(Icons.star_rate_rounded,
// //                                       size: 15, color: Colors.amberAccent)
// //                                 ],
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         ClipRRect(
// //                           borderRadius: BorderRadius.circular(50),
// //                           //backgroundColor:
// //                           //Color.fromARGB(255, 111, 149, 174),
// //                           child: store.StoreImage,
// //                         ),
// //                         const SizedBox(height: 12),
// //                         Text(
// //                           store.StoreName!,
// //                           style: const TextStyle(fontSize: 18),
// //                         ),
// //                         Text(
// //                           store.StoreType!,
// //                           style: const TextStyle(
// //                               fontSize: 12,
// //                               color: Color.fromARGB(255, 105, 105, 105)),
// //                         ),
// //                         Text(
// //                           store.StoreLocation!,
// //                           style: const TextStyle(
// //                               fontSize: 12,
// //                               color: Color.fromARGB(255, 105, 105, 105)),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           );
// //   }
// // }
