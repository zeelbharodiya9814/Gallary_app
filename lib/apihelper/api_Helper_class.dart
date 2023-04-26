

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/gallary_modal.dart';






class APIHelper {
  // Singleton object
  APIHelper._();
  static final APIHelper apiHelper = APIHelper._();

  Future<List<Gallary>?> fetchRates({String pacl = "Trending"}) async {

    String k = pacl;
    // String country = "World";
    // String apiKey = "35733828-c985a06ff38e2533edce297ea";
    String api = "https://pixabay.com/api/?key=35733828-c985a06ff38e2533edce297ea&q=$pacl&image_type=photo&pretty=true";

    http.Response res = await http.get(Uri.parse(api));

    // List<Gallary> photos = [];
    //
    //
    // if (res.statusCode == 200) {
    //   res.forEach((element) {
    //     photos.add(Gallary.fromJson(json: {}));
    //   });
    //   // isLoading.value = false;
    // }

    if(res.statusCode == 200) {
      Map<String,dynamic> decodedData = jsonDecode(res.body);
      print(decodedData);


      List data = decodedData['hits'];
      List<Gallary> k1 = data.map((e) => Gallary.fromMap(data: e),).toList();

      // Gallary k1  = Gallary.fromMap(data: decodedData);
      print(decodedData);
      return k1;
    }
  }
}