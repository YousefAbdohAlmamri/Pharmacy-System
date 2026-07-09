import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

bool _isNotificationsActive = false;
String? selectedOption;

class _drawerState extends State<drawer> {
  final Color backColor = const Color(0xFF141E28); // اللون الخلفي
  final Color mainColor = const Color(0xFF1E2A38); // اللون الحاويات


  final List<bool> _isExpanded = [false, false];

  bool _isSwetch = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320,
      backgroundColor: backColor,
      child: ListView(
        children: [
          Container(
            height: 130,
            color: mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //const SizedBox(width: 0),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/fonts/images/img_1.jpg"),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("صيدلتي",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                    Text("الاصدار  0 . 1 . 4",
                        style: TextStyle(
                            color: Color.fromARGB(255, 207, 207, 207),
                            fontSize: 16))
                  ],
                ),
                const SizedBox(width: 50),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                )
              ],
            ),
          ),

          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration:  BoxDecoration(
                color: backColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const ListTile(
              leading: Icon(Icons.person, size: 28, color: Colors.black),
              title: Text(
                "الحساب",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.chevron_right, size: 28),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const ListTile(
              leading: Icon(Icons.collections_outlined,
                  size: 28, color: Colors.black),
              title: Text(
                "الوسائط",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.chevron_right, size: 28),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile(
                leading: const Icon(Icons.color_lens_outlined,
                    size: 28, color: Colors.black),
                title: const Text(
                  "المظهر",
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: _isSwetch ? const Text("فاتح") : const Text("داكن"),
                trailing: Switch(
                  value: _isSwetch,
                  activeColor: Colors.blueGrey,
                  inactiveThumbColor: Colors.blueGrey,
                  inactiveTrackColor: const Color.fromARGB(255, 0, 0, 0),
                  onChanged: (bool value) {
                    setState(() {
                      _isSwetch = value;
                    });
                  },
                )),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
                // color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _isExpanded[panelIndex] = !_isExpanded[panelIndex];
                });
              },
              children: [
                ExpansionPanel(
                  highlightColor: Colors.blueGrey,
                  // splashColor: Colors.blueGrey,
                  backgroundColor: Colors.white,
                  headerBuilder: (context, isExpanded) {
                    return const ListTile(
                      leading:
                          Icon(Icons.language, size: 28, color: Colors.black),
                      title: Text(
                        "اللغة",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  },
                  body: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("خيار 1"),
                          leading: Radio<String>(
                            value: "value1",
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  isExpanded: _isExpanded[0],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _isExpanded[1] = !_isExpanded[1];
                });
              },
              children: [
                ExpansionPanel(
                  backgroundColor: Colors.white,
                  headerBuilder: (context, isExpanded) {
                    return const ListTile(
                      leading: Icon(Icons.notifications_active,
                          size: 28, color: Colors.black),
                      title: Text(
                        "الاشعارات",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  },
                  body: const Padding(
                      padding: EdgeInsets.all(10), child: Text("data")),
                  isExpanded: _isExpanded[1],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const ListTile(
              leading: Icon(Icons.help_outline_outlined,
                  size: 28, color: Colors.black),
              title: Text(
                "المساعدة",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.chevron_right, size: 28),
            ),
          ),
          const SizedBox(height: 5),
          // Divider(color: Colors.black38, endIndent: 20, indent: 20),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const ListTile(
              leading: Icon(Icons.share, size: 28, color: Colors.black),
              title: Text(
                "مشاركة التطبيق",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.chevron_right, size: 28),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const ListTile(
              leading: Icon(Icons.star_border_rounded,
                  size: 28, color: Colors.black),
              title: Text(
                "قييم التطبيق",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.chevron_right, size: 28),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const ListTile(
              leading: Icon(Icons.live_help, size: 28, color: Colors.black),
              title: Text(
                "الدعم الفني",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.chevron_right, size: 28),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 2)),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const ListTile(
              leading:
                  Icon(Icons.call_made_sharp, size: 28, color: Colors.black),
              title: Text(
                "التواصل مع المطور",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.chevron_right, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}

class drawer1 extends StatefulWidget {
  const drawer1({super.key});

  @override
  State<drawer1> createState() => _drawer1State();
}

class _drawer1State extends State<drawer1> {
  final Color backColor = const Color(0xFF141E28); // اللون الخلفي
  final Color mainColor = const Color(0xFF1E2A38); // اللون الحاويات

  final List<bool> _isExpanded = [false, false];
  bool _isSwetch = true;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 320,
      backgroundColor: backColor,
      child: ListView(
        children: [
          Container(
            height: 130,
            color: mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 0),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/img_1.jpg"),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("صيدلتي",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                    Text("الاصدار  0 . 1 . 4",
                        style: TextStyle(
                            color: Color.fromARGB(255, 207, 207, 207),
                            fontSize: 16))
                  ],
                ),
                const SizedBox(width: 50),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share,color: Colors.white),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          const ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text(
              "الحساب",
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            trailing: Icon(Icons.chevron_right,color: Colors.white),
          ),
          const ListTile(
            leading: Icon(Icons.collections_outlined, color: Colors.white),
            title: Text(
              "الوسائط",
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            trailing: Icon(Icons.chevron_right,color: Colors.white),
          ),
          ListTile(
              leading:
                  const Icon(Icons.color_lens_outlined, color: Colors.white),
              title: const Text(
                "المظهر",
                style: TextStyle(fontSize: 18,color: Colors.white),
              ),
              subtitle: _isSwetch ? const Text("فاتح",style: TextStyle(color: Color.fromARGB(255, 95, 93, 93)),) : const Text("داكن",style: TextStyle(color: Color.fromARGB(255, 95, 93, 93)),),
              trailing: Switch(
                value: _isSwetch,
                activeColor: const Color(0xFF3D6C91),
                inactiveThumbColor: const Color(0xFF3D6C91),
                inactiveTrackColor: const Color.fromARGB(255, 0, 0, 0),
                onChanged: (bool value) {
                  setState(() {
                    _isSwetch = value;
                  });
                },
              )),
          ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _isExpanded[panelIndex] = !_isExpanded[panelIndex];
              });
            },
            children: [
              ExpansionPanel(
                highlightColor: Colors.blueGrey,
                // splashColor: Colors.blueGrey,
                backgroundColor: mainColor,
                headerBuilder: (context, isExpanded) {
                  return const ListTile(
                    leading: Icon(Icons.language, color: Colors.white),
                    title: Text(
                      "اللغة",
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  );
                },
                body: Padding(
                  padding:const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ListTile(
                        title:const Text("عربي",style: TextStyle(color: Color.fromARGB(255, 95, 93, 93)),),
                        leading: Radio<String>(
                          value: "value1",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title:const Text("انجليزي",style: TextStyle(color: Color.fromARGB(255, 95, 93, 93)),),
                        leading: Radio<String>(
                          value: "value2",
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                isExpanded: _isExpanded[0],
              )
            ],
          ),
          const SizedBox(height: 10),
          ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _isExpanded[1] = !_isExpanded[1];
              });
            },
            children: [
              ExpansionPanel(
                backgroundColor: mainColor,
                headerBuilder: (context, isExpanded) {
                  return const ListTile(
                    leading:
                        Icon(Icons.notifications_active, color: Colors.white),
                    title: Text(
                      "الاشعارات",
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Checkbox(
                        // fillColor: WidgetStatePropertyAll(
                        //     Color.fromARGB(255, 255, 255, 255)),
                        activeColor: Colors.blueGrey,
                        value: _isNotificationsActive,
                        onChanged: (value) {
                          setState(() {
                            _isNotificationsActive = !_isNotificationsActive;
                          });
                        },
                      ),
                      const Text("تفعيل",style: TextStyle(color: Color.fromARGB(255, 95, 93, 93)),)
                    ],
                  ),
                ),
                isExpanded: _isExpanded[1],
              )
            ],
          ),
          const ListTile(
            leading: Icon(Icons.help_outline_outlined, color: Colors.white),
            title: Text(
              "المساعدة",
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            trailing: Icon(Icons.chevron_right,color: Colors.white),
          ),
          // const SizedBox(height: 10),
          // Divider(color: Colors.black38, endIndent: 20, indent: 20),
          const SizedBox(height: 10),
          const ListTile(
            leading: Icon(Icons.share, color: Colors.white),
            title: Text(
              "مشاركة التطبيق",
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            trailing: Icon(Icons.chevron_right,color: Colors.white),
          ),
          const ListTile(
            leading:
                Icon(Icons.star_border_rounded, size: 28, color: Colors.white),
            title: Text(
              "قييم التطبيق",
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            trailing: Icon(Icons.chevron_right,color: Colors.white),
          ),
          const ListTile(
            leading: Icon(Icons.live_help, color: Colors.white),
            title: Text(
              "الدعم الفني",
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            trailing: Icon(Icons.chevron_right,color: Colors.white),
          ),
          const ListTile(
            leading: Icon(Icons.call_made_sharp, color: Colors.white),
            title: Text(
              "التواصل مع المطور",
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            trailing: Icon(Icons.chevron_right,color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   MyAppState createState() => MyAppState();
// }

// class MyAppState extends State<MyApp> {
//   final GlobalKey<SliderDrawerState> _sliderDrawerKey =
//       GlobalKey<SliderDrawerState>();
//   late String title;

//   @override
//   void initState() {
//     title = "Home";
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(fontFamily: 'BalsamiqSans'),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SliderDrawer(
//             appBar: SliderAppBar(
//                 appBarColor: const Color.fromARGB(255, 230, 51, 51),
//                 title: Text(title,
//                     style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w700,
//                         ))),
//             key: _sliderDrawerKey,
//             sliderOpenSize: 179,
//             sliderCloseSize: 200,
//             slideDirection: SlideDirection.RIGHT_TO_LEFT,
//             slider: _SliderView(
//               onItemClick: (title) {
//                 // _sliderDrawerKey.currentState!.toggle();
//               },
//             ),
//             child: _AuthorList()),
//       ),
//     );
//   }
// }

// class _SliderView extends StatelessWidget {
//   final Function(String)? onItemClick;

//   const _SliderView({Key? key, this.onItemClick}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color.fromARGB(255, 144, 162, 106),
//       padding: const EdgeInsets.only(top: 30),
//       child: ListView(
//         children: <Widget>[
//           const SizedBox(
//             height: 30,
//           ),
//           CircleAvatar(
//             radius: 65,
//             backgroundColor: Colors.grey,
//             child: CircleAvatar(
//               radius: 60,
//               backgroundImage: Image.network(
//                       'https://nikhilvadoliya.github.io/assets/images/nikhil_1.webp')
//                   .image,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           const Text(
//             'Nick',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 30,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ...[
//             Menu(Icons.home, 'Home'),
//             Menu(Icons.add_circle, 'Add Post'),
//             Menu(Icons.notifications_active, 'Notification'),
//             Menu(Icons.favorite, 'Likes'),
//             Menu(Icons.settings, 'Setting'),
//             Menu(Icons.arrow_back_ios, 'LogOut')
//           ]
//               .map((menu) => _SliderMenuItem(
//                   title: menu.title,
//                   iconData: menu.iconData,
//                   onTap: onItemClick))
//               .toList(),
//         ],
//       ),
//     );
//   }
// }

// class _SliderMenuItem extends StatelessWidget {
//   final String title;
//   final IconData iconData;
//   final Function(String)? onTap;

//   const _SliderMenuItem(
//       {Key? key,
//       required this.title,
//       required this.iconData,
//       required this.onTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//         title: Text(title,
//             style: const TextStyle(
//                 color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
//         leading: Icon(iconData, color: Colors.black),
//         onTap: () => onTap?.call(title));
//   }
// }

// class _AuthorList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<Quotes> quotesList = [];
//     quotesList.add(Quotes(Colors.amber, 'Amelia Brown',
//         'Life would be a great deal easier if dead things had the decency to remain dead.'));
//     quotesList.add(Quotes(Colors.orange, 'Olivia Smith',
//         'That proves you are unusual," returned the Scarecrow'));
//     quotesList.add(Quotes(Colors.deepOrange, 'Sophia Jones',
//         'Her name badge read: Hello! My name is DIE, DEMIGOD SCUM!'));
//     quotesList.add(Quotes(Colors.red, 'Isabella Johnson',
//         'I am about as intimidating as a butterfly.'));
//     quotesList.add(Quotes(Colors.purple, 'Emily Taylor',
//         'Never ask an elf for help; they might decide your better off dead, eh?'));
//     quotesList
//         .add(Quotes(Colors.green, 'Maya Thomas', 'Act first, explain later'));

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: ListView.separated(
//           scrollDirection: Axis.vertical,
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           itemBuilder: (builder, index) {
//             return LimitedBox(
//               maxHeight: 150,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: quotesList[index].color,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(10.0),
//                     )),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Text(
//                         quotesList[index].author,
//                         style: const TextStyle(
//                             fontFamily: 'BalsamiqSans_Blod',
//                             fontSize: 30,
//                             color: Colors.white),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Text(
//                         quotesList[index].quote,
//                         style: const TextStyle(
//                             fontFamily: 'BalsamiqSans_Regular',
//                             fontSize: 15,
//                             color: Colors.white),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//           separatorBuilder: (builder, index) {
//             return const Divider(
//               height: 10,
//               thickness: 0,
//             );
//           },
//           itemCount: quotesList.length),
//     );
//   }
// }

// class Quotes {
//   final MaterialColor color;
//   final String author;
//   final String quote;

//   Quotes(this.color, this.author, this.quote);
// }

// class Menu {
//   final IconData iconData;
//   final String title;

//   Menu(this.iconData, this.title);
// }
