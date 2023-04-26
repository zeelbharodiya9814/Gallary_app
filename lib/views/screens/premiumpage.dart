import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pr_gallary_app/views/screens/wallpaperdetail.dart';

import '../../apihelper/api_Helper_class.dart';
import '../../model/gallary_modal.dart';

class Premium extends StatefulWidget {
  const Premium({Key? key}) : super(key: key);

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  late Future<List<Gallary>?> getData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData = APIHelper.apiHelper.fetchRates(pacl: "All");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Padding(
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
                                        settings:
                                            RouteSettings(arguments: data[i])));
                                // Navigator.pushNamed(context, 'Detail' ,arguments: data[i]);
                              });
                            },
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          colorFilter: const ColorFilter.mode(
                                            Color(0xffC19E82),
                                            BlendMode.modulate,
                                          ),
                                          fit: BoxFit.cover,
                                          image: NetworkImage(data[i].largeImageURL))
                                    ),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    color: Colors.deepPurple[100],
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text("\$ ${data[i].comments}",style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  ),
                                ],
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
    );
  }
}
