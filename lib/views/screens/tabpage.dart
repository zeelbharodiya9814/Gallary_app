import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pr_gallary_app/apihelper/api_Helper_class.dart';
import 'package:pr_gallary_app/views/screens/premiumpage.dart';
import 'package:pr_gallary_app/views/screens/testing.dart';
import 'package:pr_gallary_app/views/screens/wallpaperdetail.dart';
import 'package:provider/provider.dart';

import '../../controller/theme_provider.dart';
import '../../model/gallary_modal.dart';
import 'categorypage.dart';
import 'drawerpage.dart';
import 'homepage.dart';



class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage>  with SingleTickerProviderStateMixin {

  TextEditingController searchController = TextEditingController();

  int currentItem = 0;

  late TabController tabController;
  PageController pageController = PageController();

  List tabname = [
    "HOME",
    "CATEGORIES",
    "PREMIUM",
  ];

  static late Future<List<Gallary>?> getData;

  @override
  void initState() {

   getData =  APIHelper.apiHelper.fetchRates();
   tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  int currentCupertinoIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerPage(),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff232323),
        // backgroundColor: Colors.deepPurple[300],
        centerTitle: true,
        title: Text(
          "Gallary",
          style: TextStyle(
              color: Colors.deepPurple[200],
              fontSize: 22,
              letterSpacing: 2,
              fontWeight: FontWeight.w400),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0,bottom: 0,top: 8),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: AnimSearchBar(
                width: 300,
                textController: searchController,
                textFieldColor: Colors.deepPurple[100],
                searchIconColor: Colors.deepPurple[500],
                onSuffixTap: () {
                  setState(() {
                    searchController.clear();
                  });
                },
          onSubmitted: (String data) {
              setState(() {
                getData = APIHelper.apiHelper.fetchRates(pacl: data);
              });
           }),
            ),
          ),
          SizedBox(width: 15,),
        ],
        // actions: [
        //   IconButton(onPressed: () {
        //     setState(() {
        //       Provider.of<ThemeProvider>(context , listen: false).changetheme();
        //     });
        //   }, icon: Icon(Icons.light_mode)),
        // ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.deepPurple[100],
          indicatorWeight: 4,
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: (val) {
            setState(() {
              currentItem = val;
            });
            pageController.animateToPage(val,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut);
          },
          tabs: tabname
              .map((e) => Tab(
            text: e,
          ))
              .toList(),
        ),
      ),
      body: PageView(
        onPageChanged: (val) {
          setState(() {
            currentItem = val;
          });
          tabController.animateTo(val);
        },
        controller: pageController,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: FutureBuilder(
                future: getData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<Gallary>? data = snapshot.data;

                    return (data != null)
                        ? MasonryGridView.builder(
                        itemCount: data.length,
                        mainAxisSpacing: 1.5,
                        crossAxisSpacing: 1.5,
                        gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detail(),
                                        settings: RouteSettings(
                                            arguments: data[i])));
                              });
                            },
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child: Container(
                                height: 250,
                                child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: Image.network(
                                      data[i].largeImageURL,
                                      fit: BoxFit.cover,
                                    )),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          );
                        })
                        : Center(
                      child: Text("No data found..."),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(color: Colors.deepPurple[300],),
                  );
                },
              ),
            ),
          ),
          Category(),
          Premium(),
          // GalleryPage(),
        ],
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.purpleAccent[100],
      //   iconSize: 30,
      //   currentIndex: currentItem,
      //   fixedColor: Colors.white,
      //   onTap: (val) {
      //     setState(() {
      //       currentItem = val;
      //     });
      //     tabController.animateTo(val);
      //     pageController.animateToPage(val, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      //   },
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,),label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.call),label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings),label: ""),
      //   ],
      // ),
    );
  }
}
