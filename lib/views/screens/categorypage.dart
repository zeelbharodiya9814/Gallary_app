import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pr_gallary_app/apihelper/api_Helper_class.dart';

import '../../model/gallary_modal.dart';
import 'wallpaperdetail.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool icon = true;

  int currentpage = 0;
  CarouselController carouselController = CarouselController();

  List<Map<String, dynamic>> o = [];

  List<Map<String, dynamic>> heading = [
    {
      "name": "Natures",
      "image": "assets/images/nature.jpeg",
    },
    {
      "name": "Foods",
      "image": "assets/images/foods.jpeg",
    },
    {
      "name": "Animals",
      "image": "assets/images/animal1.jpeg",
    },
    {
      "name": "Birds",
      "image": "assets/images/birds.png",
    },
    {
      "name": "Flowers",
      "image": "assets/images/flowers.png",
    },
    {
      "name": "Sports",
      "image": "assets/images/sports.jpeg",
    },
    {
      "name": "Cars",
      "image": "assets/images/cars.png",
    },
    {
      "name": "Phone",
      "image": "assets/images/phone.png",
    },
    // "Sports"
    // "Cars"
  ];

  late Future<List<Gallary>?> getData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData = APIHelper.apiHelper.fetchRates(pacl: "Natures");
  }

  // final String title;
  bool isDelete = true;
  bool isSelected0 = true;
  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;

  // List car = [
  //  'Nature',
  //  'Cars',
  //  'Dogs',
  // 'flowers',
  // 'Cats',
  // 'buildings',
  // ];

  // int _currentIndex = 0;
  // int currentPage = 0;
  // CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...heading
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: ActionChip(
                              backgroundColor: Colors.deepPurple[100],
                              side: BorderSide(
                                  color: Colors.deepPurple, width: 2),
                              focusNode: FocusNode(canRequestFocus: true),
                              elevation: 5,
                              autofocus: true,
                              disabledColor: Colors.purple[100],
                              avatar: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.deepPurple,width: 2),
                                      image: DecorationImage(image: AssetImage("${e['image']}")),
                                    ),
                                      // child: Image.asset("${e['image']}")
                                  )),
                              label: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Text(
                                  e['name'],
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  getData = APIHelper.apiHelper
                                      .fetchRates(pacl: e['name']);
                                });
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 20,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 4.0, right: 4, bottom: 4, top: 0),
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
                                return Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Detail(),
                                                settings: RouteSettings(
                                                    arguments: data[i])));
                                        // Navigator.pushNamed(context, 'Detail' ,arguments: data[i]);
                                      });
                                    },
                                    child: Container(
                                      height: 250,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            "${data[i].largeImageURL}",
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
          ),
        ],
      ),
    );

    //   Scaffold(
    //   backgroundColor: Colors.black,
    //   body: FutureBuilder(
    //     future: getData,
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.hasError) {
    //         return Center(
    //           child: Text("Error: ${snapshot.error}"),
    //         );
    //       } else if (snapshot.hasData) {
    //
    //         List<Gallary>? data = snapshot.data;
    //
    //         return (data != null)
    //             ? MasonryGridView.builder(
    //             itemCount: data.length,
    //             mainAxisSpacing: 1.5,
    //             crossAxisSpacing: 1.5,
    //             gridDelegate:
    //             SliverSimpleGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 3,
    //             ),
    //             itemBuilder: (context, i) {
    //               return Card(
    //                 elevation: 10,
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(10)),
    //                 child: GestureDetector(
    //                   onTap: () {
    //                     setState(() {
    //                       Navigator.pushNamed(context, 'Detail' ,arguments: data[i]);
    //                     });
    //                   },
    //                   child: Container(
    //                     height: 250,
    //                     child: ClipRRect(
    //                         borderRadius: BorderRadius.circular(10),
    //                         child: Image.network(
    //                           "${data[i].largeImageURL}",
    //                           fit: BoxFit.cover,
    //                         )),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             })
    //             : Center(
    //           child: Text("No data found..."),
    //         );
    //       }
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     },
    //   ),
    //
    //
    //   floatingActionButton: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(left: 30.0,top: 25),
    //         child: Row(
    //           children: [
    //             Wrap(
    //               children: [
    //                 FilterChip(
    //                   label: Text('Nature'),
    //                   labelStyle: TextStyle(
    //                       color: isSelected0 ? Colors.black : Colors.white),
    //                   selected: isSelected0,
    //                   onSelected: (bool selected) {
    //                     setState(() {
    //                       getData = APIHelper.apiHelper.fetchRates(pacl: "Natures");
    //                       isSelected0 = !isSelected0;
    //                       isSelected1 = false;
    //                     });
    //                   },
    //                   selectedColor: Theme.of(context).accentColor,
    //                   checkmarkColor: Colors.black,
    //                 ),
    //                 SizedBox(
    //                   width: 10,
    //                 ),
    //                 FilterChip(
    //                   label: Text('Animals'),
    //                   labelStyle: TextStyle(
    //                       color: isSelected1 ? Colors.black : Colors.white),
    //                   selected: isSelected1,
    //                   onSelected: (bool selected) {
    //                     setState(() {
    //                       getData = APIHelper.apiHelper.fetchRates(pacl: "Animals");
    //                       isSelected1 = !isSelected1;
    //                       isSelected0 = false;
    //                     });
    //                   },
    //                   selectedColor: Theme.of(context).accentColor,
    //                   checkmarkColor: Colors.black,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
