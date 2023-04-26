import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pr_gallary_app/views/screens/wallpaperdetail.dart';
import 'package:provider/provider.dart';

import '../../apihelper/api_Helper_class.dart';
import '../../controller/theme_provider.dart';
import '../../model/gallary_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String? search;
  late Future<List<Gallary>?> getData;

  TextEditingController searchController = TextEditingController();

  // void _handleSearch() async {
  //   final photos = await APIHelper.apiHelper.fetchRates(pacl: searchController.text);
  //   setState(() {
  //     final search = photos;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData = APIHelper.apiHelper.fetchRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 8.0, left: 5, right: 5),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         flex: 9,
          //         child: Card(
          //           elevation: 5,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10)),
          //           child: Container(
          //             height: 50,
          //             alignment: Alignment.center,
          //             child: TextFormField(
          //               controller: searchController,
          //               textInputAction: TextInputAction.next,
          //               style: TextStyle(fontSize: 20),
          //               decoration: InputDecoration(
          //                   hintText: "Search here...",
          //                   hintStyle: TextStyle(
          //                       color: Colors.grey[400], fontSize: 20),
          //                   filled: true,
          //                   fillColor: Colors.yellow.shade50,
          //                   border: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                     borderSide: BorderSide.none,
          //                   )),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         flex: 2,
          //         child: GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               getData = APIHelper.apiHelper
          //                   .fetchRates(pacl: searchController.text);
          //             });
          //           },
          //           child: Card(
          //             elevation: 5,
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(10)),
          //             child: Container(
          //               height: 50,
          //               width: 30,
          //               alignment: Alignment.center,
          //               child: Icon(
          //                 Icons.search,
          //                 size: 30,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            // flex: 14,
            child: Padding(
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
                                      // Navigator.pushNamed(context, 'Detail' ,arguments: data[i]);
                                    });
                                  },
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              colorFilter: const ColorFilter.mode(
                                                Color(0xffC19E82),
                                                BlendMode.modulate,
                                              ),
                                              fit: BoxFit.cover,
                                              image: NetworkImage(data[i].largeImageURL)),
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
  }
}
