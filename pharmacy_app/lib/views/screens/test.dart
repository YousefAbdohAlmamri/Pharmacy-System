// // import 'package:flutter/material.dart';
// // import 'package:pharmacy_app/core/Models/Medicine.dart';

// // class SearchMedicinesScreen extends StatefulWidget {
// //   const SearchMedicinesScreen({super.key});

// //   @override
// //   State<SearchMedicinesScreen> createState() => _SearchMedicinesScreenState();
// // }

// // class _SearchMedicinesScreenState extends State<SearchMedicinesScreen> {
// //   late List<Medicine> medicines = [];


// //    void filterSearch(String query) {
// //     List<String> results = [];
// //     if (query.isEmpty) {
// //       results = medicines;
// //     } else {
// //       results = medicines
// //           .where((med) => med.toLowerCase().startsWith(query.toLowerCase()))
// //           .toList();
// //     }

// //     setState(() {
// //       filteredMedicines = results;
// //     });
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Placeholder();
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:pharmacy_app/core/Models/PharmacyDetails.dart';
// import '../../services/pharmacyServices.dart';

// class MedicineSearchPage extends StatefulWidget {
//   @override
//   _MedicineSearchPageState createState() => _MedicineSearchPageState();
// }

// class _MedicineSearchPageState extends State<MedicineSearchPage> {
//   bool isWriting = false;
//   final TextEditingController _medicineName = TextEditingController();
//   late  Future<List<PharmacyDetails>> searchResult;
//   ApiService apiService = new ApiService();
//   // قائمة الأدوية
//   List<String> medicines = [
//     "Aspirin",
//     "Amoxicillin",
//     "Azithromycin",
//     "Paracetamol",
//     "Ibuprofen",
//     "Insulin",
//     "Atorvastatin",
//     "Metformin",
//   ];

//   // قائمة النتائج بعد البحث
//   List<String> filteredMedicines = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredMedicines = medicines; // في البداية تعرض كل الأدوية
//     searchResult = apiService.SearchPharmacyByMedicine(_medicineName.text.trim());
//   }

//   void filterSearch(String query) {
//     List<String> results = [];
//     if (query.isEmpty) {
//       results = medicines;
//     } else {
//       results = medicines
//           .where((med) => med.toLowerCase().startsWith(query.toLowerCase()))
//           .toList();
//     }

//     setState(() {
//       filteredMedicines = results;
      
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Medicines'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: TextField(
//               controller: _medicineName,
//               onChanged: (value) => filterSearch(value),
//               decoration: InputDecoration(
//                 labelText: 'Search medicine',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 prefixIcon: IconButton(onPressed: (){
//                   setState(() {
//                     isWriting = !isWriting;             
//                   });
//                 },icon:Icon(Icons.search)),
//               ),
//             ),
//           ),
//           isWriting?Expanded(
//             child: ListView.builder(
//               itemCount: filteredMedicines.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(filteredMedicines[index]),
//                 );
//               },
//             ),
//           ): SingleChildScrollView(
//         child: FutureBuilder<List<PharmacyDetails>>(
//                         future: searchResult,
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState != ConnectionState.done)
//                             {
//                               return Center(child: 
//                               CircularProgressIndicator(),);
//                             }
                          
//                           if (snapshot.hasError)
//                             {
//                               return Center(child: 
//                               Text('Error: ${snapshot.error}',),);
//                             }

//                             final list = snapshot.data ?? [];

//                             return GridView.builder(
//                               itemCount: 3,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 2,
//                                       crossAxisSpacing: 20,
//                                       mainAxisSpacing: 20,
//                                       childAspectRatio: 0.7),
//                               //لمنع التمرير داخلة
//                               //physics: const NeverScrollableScrollPhysics(),
//                               physics : NeverScrollableScrollPhysics() ,
//                               shrinkWrap: true,
//                               //---------------------------
//                               itemBuilder: (context, index) {
                                
//                                   final phar = list[index];
//                                 return GestureDetector(
                                          
//                                   onTap: () {
//                                     //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PharmacyProfilePage(apiService: ApiService(),pharmacyId: pharmacy.Id,)));
//                                     // Navigator.of(context).push(MaterialPageRoute(
//                                     //     builder: (context) => Stored_About(
//                                     //         stores[index], storephone)));
//                                   },
//                                   child: Container(
//                                     //height: 100,
//                                     margin: EdgeInsets.all(5),
//                                     padding: EdgeInsets.only(left: 0,top: 0,right: 0,bottom: 0),
//                                     // width: 100,
//                                     decoration: const BoxDecoration(
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Color.fromARGB(45, 0, 0, 0),
//                                             blurRadius: 4,
//                                             spreadRadius: 1,
//                                             offset: Offset(0, 1),
//                                           ),
//                                         ],
//                                         borderRadius:
//                                             BorderRadius.all(Radius.circular(10)),
//                                         color:
//                                             Color.fromRGBO(35, 48, 63, 100)),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(
//                                               width: 40,
//                                               height: 40,
//                                               decoration: const BoxDecoration(
//                                                   color: Color(0xFF598FBA),
//                                                   borderRadius: BorderRadius.only(
//                                                       topRight:
//                                                           Radius.circular(10),
//                                                       bottomLeft:
//                                                           Radius.circular(10))),
//                                               child: IconButton(
//                                                 onPressed: () {
//                                                   // setState(() {
//                                                   //   pharmacy.isFavorite =
//                                                   //       !pharmacy.isFavorite;
//                                                   //   // isFavorite = !isFavorite;
//                                                   // });
//                                                 },
                                                
//                                                 // icon: pharmacy.isFavorite
//                                                 icon: false
//                                                     ? const Icon(Icons.favorite,
//                                                         size: 26,
//                                                         color: Color.fromARGB(
//                                                             255, 253, 88, 88))
//                                                     : const Icon(
//                                                         Icons.favorite_border,
//                                                         color: Colors.white),
//                                               ),
//                                             ),
                                            
//                                           ],
//                                         ),
//                                         ClipRRect(
//                                           borderRadius: BorderRadius.circular(50),
//                                           //backgroundColor:
//                                           //Color.fromARGB(255, 111, 149, 174),
//                                           child: Image.network("https://localhost:44383/Images/${phar.ImageUrl}",width: 100,height: 100,),
//                                         ),
//                                         const SizedBox(height: 3),
//                                         Text(
//                                           phar.Name!,
//                                           style: const TextStyle(color: Colors.grey,fontSize: 18),
//                                         ),
//                                         // Text(
//                                         //   store.StoreType!,
//                                         //   style: const TextStyle(
//                                         //       fontSize: 12,
//                                         //       color: Color.fromARGB(
//                                         //           255, 105, 105, 105)),
//                                         // ),
                                        
//                                         Text(
//                                           phar.Location!,
//                                           style: const TextStyle(
//                                               fontSize: 12,
//                                               color: Color.fromARGB(255, 139, 139, 141)),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
                      
//                    },
//                  )
//             ),
//         ],
//       ),
//     );
//   }
// }











// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pharmacy_app/core/Models/PharmacyDetails.dart';
// import '../../services/pharmacyServices.dart';

// class MedicineSearchPage extends StatefulWidget {
//   const MedicineSearchPage({super.key});

//   @override
//   State<MedicineSearchPage> createState() => _MedicineSearchPageState();
// }

// class _MedicineSearchPageState extends State<MedicineSearchPage> {
//   // ====== التحكم ======
//   final TextEditingController _controller = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   final ApiService _api = ApiService();
//   Timer? _debounce;
//   static const _debounceDuration = Duration(milliseconds: 400);

//   // ====== حالة البحث ======
//   bool _loading = false;
//   String _error = '';
//   String _lastQuery = '';
//   List<PharmacyDetails> _results = [];

//   // ====== الاقتراحات (محلية الآن؛ يمكن جعلها من API لاحقًا) ======
//   final List<String> _allSuggestions = const [
//     "Aspirin",
//     "Amoxicillin",
//     "Azithromycin",
//     "Paracetamol",
//     "Ibuprofen",
//     "Insulin",
//     "Atorvastatin",
//     "Metformin",
//   ];
//   List<String> _filteredSuggestions = [];
//   final List<String> _recent = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredSuggestions = _allSuggestions;
//     // بحث أولي فارغ لا يطلب من API
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _controller.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }

//   // يفلتر الاقتراحات المحلية أثناء الكتابة
//   void _filterSuggestions(String query) {
//     final q = query.trim().toLowerCase();
//     setState(() {
//       _filteredSuggestions = q.isEmpty
//           ? _allSuggestions
//           : _allSuggestions
//               .where((s) => s.toLowerCase().startsWith(q))
//               .toList();
//     });
//   }

//   // يُستدعى عند تغيير النص مع Debounce
//   void _onQueryChanged(String value) {
//     _filterSuggestions(value);
//     _debounce?.cancel();
//     _debounce = Timer(_debounceDuration, () => _search(value));
//   }

//   // البحث الفعلي باستدعاء API
//   Future<void> _search(String query) async {
//     final q = query.trim();
//     if (!mounted) return;

//     // إن كان الاستعلام فارغًا لا نستدعي الـ API
//     if (q.isEmpty) {
//       setState(() {
//         _loading = false;
//         _error = '';
//         _results = [];
//         _lastQuery = '';
//       });
//       return;
//     }

//     setState(() {
//       _loading = true;
//       _error = '';
//       _lastQuery = q;
//     });

//     try {
//       final data = await _api.SearchPharmacyByMedicine(q); // <== دالة API الخاصة بك
//       if (!mounted) return;
//       setState(() {
//         _results = data;
//         _loading = false;

//         // حفظ في "عمليات البحث الأخيرة"
//         if (!_recent.contains(q)) {
//           _recent.insert(0, q);
//           if (_recent.length > 10) _recent.removeLast();
//         }
//       });
//     } catch (e) {
//       if (!mounted) return;
//       setState(() {
//         _loading = false;
//         _error = e.toString();
//       });
//     }
//   }

//   // تنفيذ البحث الآن (زر البحث أو Enter)
//   void _searchNow() => _search(_controller.text);

//   void _clearQuery() {
//     _controller.clear();
//     _filterSuggestions('');
//     setState(() {
//       _results = [];
//       _error = '';
//       _loading = false;
//       _lastQuery = '';
//     });
//     // إبقاء التركيز في الحقل للكتابة مباشرة
//     _focusNode.requestFocus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Medicines'),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // شريط البحث
//             Padding(
//               padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
//               child: TextField(
//                 controller: _controller,
//                 focusNode: _focusNode,
//                 textInputAction: TextInputAction.search,
//                 onSubmitted: (_) => _searchNow(),
//                 onChanged: _onQueryChanged,
//                 decoration: InputDecoration(
//                   labelText: 'Search medicine',
//                   hintText: 'Type a medicine name…',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   prefixIcon: IconButton(
//                     tooltip: 'Search',
//                     onPressed: _searchNow,
//                     icon: const Icon(Icons.search),
//                   ),
//                   suffixIcon: _loading
//                       ? const Padding(
//                           padding: EdgeInsets.all(12.0),
//                           child: SizedBox(
//                             width: 18,
//                             height: 18,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           ),
//                         )
//                       : (_controller.text.isEmpty
//                           ? null
//                           : IconButton(
//                               tooltip: 'Clear',
//                               onPressed: _clearQuery,
//                               icon: const Icon(Icons.close),
//                             )),
//                 ),
//               ),
//             ),

//             // اقتراحات أثناء الكتابة + عمليات البحث الأخيرة
//             if (_focusNode.hasFocus)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Column(
//                   children: [
//                     // الاقتراحات
//                     if (_filteredSuggestions.isNotEmpty &&
//                         _controller.text.isNotEmpty)
//                       Container(
//                         constraints: const BoxConstraints(maxHeight: 180),
//                         decoration: BoxDecoration(
//                           color: theme.cardColor,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: theme.dividerColor,
//                           ),
//                         ),
//                         child: ListView.builder(
//                           itemCount: _filteredSuggestions.length,
//                           itemBuilder: (context, i) {
//                             final s = _filteredSuggestions[i];
//                             return ListTile(
//                               leading: const Icon(Icons.medication_outlined),
//                               title: Text(s),
//                               onTap: () {
//                                 _controller.text = s;
//                                 _controller.selection = TextSelection.fromPosition(
//                                   TextPosition(offset: s.length),
//                                 );
//                                 _searchNow();
//                                 _focusNode.unfocus();
//                               },
//                             );
//                           },
//                         ),
//                       ),

//                     // عمليات البحث الأخيرة
//                     if (_recent.isNotEmpty && _controller.text.isEmpty)
//                       Container(
//                         margin: const EdgeInsets.only(top: 8),
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: theme.colorScheme.surface,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: theme.dividerColor),
//                         ),
//                         child: Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: _recent
//                               .map(
//                                 (r) => ActionChip(
//                                   label: Text(r),
//                                   avatar: const Icon(Icons.history, size: 18),
//                                   onPressed: () {
//                                     _controller.text = r;
//                                     _controller.selection =
//                                         TextSelection.fromPosition(
//                                       TextPosition(offset: r.length),
//                                     );
//                                     _searchNow();
//                                     _focusNode.unfocus();
//                                   },
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),

//             const SizedBox(height: 6),

//             // منطقة النتائج / الحالات
//             Expanded(
//               child: Builder(
//                 builder: (_) {
//                   if (_error.isNotEmpty) {
//                     return _ErrorView(
//                       message: 'حدث خطأ أثناء البحث:\n$_error',
//                       onRetry: () => _search(_lastQuery),
//                     );
//                   }

//                   if (_loading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (_controller.text.trim().isEmpty) {
//                     return _IdleView();
//                   }

//                   if (_results.isEmpty) {
//                     return _EmptyView(query: _lastQuery);
//                   }

//                   // عرض النتائج في Grid
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: GridView.builder(
//                       itemCount: _results.length,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 16,
//                         mainAxisSpacing: 16,
//                         childAspectRatio: 0.70,
//                       ),
//                       itemBuilder: (context, index) {
//                         final ph = _results[index];
//                         return GestureDetector(
                                          
//                                   onTap: () {
//                                     //Navigator.of(context).push(MaterialPageRoute(builder: (context) => PharmacyProfilePage(apiService: ApiService(),pharmacyId: pharmacy.Id,)));
//                                     // Navigator.of(context).push(MaterialPageRoute(
//                                     //     builder: (context) => Stored_About(
//                                     //         stores[index], storephone)));
//                                   },
//                                   child: Container(
//                                     //height: 100,
//                                     margin: EdgeInsets.all(5),
//                                     padding: EdgeInsets.only(left: 0,top: 0,right: 0,bottom: 0),
//                                     // width: 100,
//                                     decoration: const BoxDecoration(
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Color.fromARGB(45, 0, 0, 0),
//                                             blurRadius: 4,
//                                             spreadRadius: 1,
//                                             offset: Offset(0, 1),
//                                           ),
//                                         ],
//                                         borderRadius:
//                                             BorderRadius.all(Radius.circular(10)),
//                                         color:
//                                             Color.fromRGBO(35, 48, 63, 100)),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(
//                                               width: 40,
//                                               height: 40,
//                                               decoration: const BoxDecoration(
//                                                   color: Color(0xFF598FBA),
//                                                   borderRadius: BorderRadius.only(
//                                                       topRight:
//                                                           Radius.circular(10),
//                                                       bottomLeft:
//                                                           Radius.circular(10))),
//                                               child: IconButton(
//                                                 onPressed: () {
//                                                   // setState(() {
//                                                   //   pharmacy.isFavorite =
//                                                   //       !pharmacy.isFavorite;
//                                                   //   // isFavorite = !isFavorite;
//                                                   // });
//                                                 },
                                                
//                                                 // icon: pharmacy.isFavorite
//                                                 icon: false
//                                                     ? const Icon(Icons.favorite,
//                                                         size: 26,
//                                                         color: Color.fromARGB(
//                                                             255, 253, 88, 88))
//                                                     : const Icon(
//                                                         Icons.favorite_border,
//                                                         color: Colors.white),
//                                               ),
//                                             ),
                                            
//                                           ],
//                                         ),
//                                         ClipRRect(
//                                           borderRadius: BorderRadius.circular(50),
//                                           //backgroundColor:
//                                           //Color.fromARGB(255, 111, 149, 174),
//                                           child: Image.network("https://localhost:44383/Images/${ph.ImageUrl}",width: 100,height: 100,),
//                                         ),
//                                         const SizedBox(height: 3),
//                                         Text(
//                                           ph.Name!,
//                                           style: const TextStyle(color: Colors.grey,fontSize: 18),
//                                         ),
//                                         // Text(
//                                         //   store.StoreType!,
//                                         //   style: const TextStyle(
//                                         //       fontSize: 12,
//                                         //       color: Color.fromARGB(
//                                         //           255, 105, 105, 105)),
//                                         // ),
                                        
//                                         Text(
//                                           ph.Location!,
//                                           style: const TextStyle(
//                                               fontSize: 12,
//                                               color: Color.fromARGB(255, 139, 139, 141)),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ====== Widgets مساعدة لعرض الحالات والبطاقة ======

// class _IdleView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('ابحث عن دواء لعرض الصيدليات المتوفرة'),
//     );
//   }
// }

// class _EmptyView extends StatelessWidget {
//   final String query;
//   const _EmptyView({required this.query});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('لا توجد نتائج لـ "$query"'),
//     );
//   }
// }

// class _ErrorView extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;
//   const _ErrorView({required this.message, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(message, textAlign: TextAlign.center),
//           const SizedBox(height: 12),
//           FilledButton.icon(
//             onPressed: onRetry,
//             icon: const Icon(Icons.refresh),
//             label: const Text('إعادة المحاولة'),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/Models/PharmacyDetails.dart';
import 'package:pharmacy_app/views/screens/PharmacyDetail.dart';
import '../../services/pharmacyServices.dart';

class MedicineSearchPage extends StatefulWidget {
  const MedicineSearchPage({super.key});

  @override
  State<MedicineSearchPage> createState() => _MedicineSearchPageState();
}

class _MedicineSearchPageState extends State<MedicineSearchPage> {
  // ====== التحكم ======
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ApiService _api = ApiService();
  final Color backColor = const Color(0xFF141E28); // اللون الخلفي
  final GlobalKey<ScaffoldState> _globalKey =
      GlobalKey<ScaffoldState>();

  Future<List<PharmacyDetails>>? _pharmacies;
  String _error = '';

  Future<void> _search(String query) async {
    final q = query.trim();
    if (q.isEmpty) return;

    setState(() {
      _error = '';
      _pharmacies = _api.SearchPharmacyByMedicine(q);
    });
  }

  // تنفيذ البحث الآن (زر البحث أو Enter)
  void _searchNow() => _search(_controller.text);

  void _clearQuery() {
    _controller.clear();
    _focusNode.requestFocus();
    setState(() {
      _pharmacies = null;
      _error = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(backgroundColor: backColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 143, 141, 141),
                  size: 27,
                ),
              ),
              title: const Text(
                "البحث بلأدوية",
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
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const homeChat()));
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
        body: SafeArea(
          child: Column(
            children: [
              // شريط البحث
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _searchNow(),
                  style: const TextStyle(fontSize: 18,color: Colors.white),
                  decoration: InputDecoration(
                    //labelText: 'Search medicine',
                    hintText: "بحث ....",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: IconButton(
                      tooltip: 'Search',
                      onPressed: _searchNow,
                      icon: const Icon(Icons.search,
                      color: Colors.grey,),
                    ),
                    suffixIcon: _controller.text.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Clear',
                            onPressed: _clearQuery,
                            icon: const Icon(Icons.close),
                            color: Colors.grey,
                          ),
                  ),
                ),
              ),
        
              const SizedBox(height: 6),
        
              // منطقة النتائج
              Expanded(
                child: _pharmacies == null
                    ? const Center(
                        child: Text('ابحث عن دواء لعرض الصيدليات'),
                      )
                    : FutureBuilder<List<PharmacyDetails>>(
                        future: _pharmacies,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
        
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }
        
                          final list = snapshot.data ?? [];
        
                          if (list.isEmpty) {
                            return const Center(
                              child: Text('لا توجد صيدليات لهذا الدواء'),
                            );
                          }
        
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
                                final ph = list[index];
                                
                                return GestureDetector(
                                          
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PharmacyProfilePage( pharmacyId:ph.Id!)));
                                    
                                  },
                                  child: Container(
                                    //height: 100,
                                    margin: EdgeInsets.all(2),
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
                                          child: Image.network(
                                        "https://localhost:44383/Images/${ph.ImageUrl}",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          ph.Name!,
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
                                          ph.Location!,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}







// class _PharmacyCard extends StatelessWidget {
//   final String name;
//   final String location;
//   final String? imageUrl;
//   final VoidCallback? onTap;

//   const _PharmacyCard({
//     required this.name,
//     required this.location,
//     required this.imageUrl,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: const Color.fromRGBO(35, 48, 63, 1),
//       elevation: 2,
//       borderRadius: BorderRadius.circular(12),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: [
//               // زر المفضلة (شكل فقط)
//               Align(
//                 alignment: Alignment.topRight,
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF598FBA),
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(10),
//                       bottomLeft: Radius.circular(10),
//                     ),
//                   ),
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.favorite_border, color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(50),
//                 child: _PharmacyImage(imageUrl: imageUrl),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 name,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(color: Colors.white, fontSize: 16),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 location,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Color.fromARGB(255, 179, 179, 179),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _PharmacyImage extends StatelessWidget {
//   final String? imageUrl;
//   const _PharmacyImage({required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     // ملاحظة: لا تستخدم localhost على الهاتف الحقيقي
//     final url = imageUrl ?? '';
//     return Image.network(
//       url,
//       width: 100,
//       height: 100,
//       fit: BoxFit.cover,
//       errorBuilder: (_, __, ___) => Container(
//         width: 100,
//         height: 100,
//         color: const Color(0xFF3E4E61),
//         child: const Icon(Icons.image_not_supported_outlined, color: Colors.white),
//       ),
//       // يمكن إضافة loadingBuilder إن رغبت
//     );
//   }
// }