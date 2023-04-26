// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:screenshot/screenshot.dart';
//
// class GalleryPage extends StatefulWidget {
//   const GalleryPage({super.key});
//
//   @override
//   State<GalleryPage> createState() => _GalleryPageState();
// }
//
// class _GalleryPageState extends State<GalleryPage> {
//   final _searchController = TextEditingController();
//   List<dynamic> _photos = [];
//
//   Future<List<dynamic>> searchPhotos(String query) async {
//     final String apiUrl = 'https://api.unsplash.com/search/photos';
//     final String apiKey = 'MPMWGDZsY_QPZMtE3H-Ff_jDq34DGcT7qd76GN7DZ8';
//
//     final response =
//     await http.get(Uri.parse('$apiUrl?query=$query&client_id=$apiKey'));
//     if (response.statusCode == 200) {
//       return json.decode(response.body)['results'];
//     } else {
//       throw Exception('Failed to load photos');
//     }
//   }
//
//   void _handleSearch() async {
//     final photos = await searchPhotos(_searchController.text);
//     setState(() {
//       _photos = photos;
//     });
//   }
//
//   ScreenshotController screenshotController = ScreenshotController();
//
//   void _captureScreenshot() async {
//     // capture screenshot
//     final Uint8List = await screenshotController.capture();
//
//     // save image to gallery
//     final result = await ImageGallerySaver.saveImage(Uint8List!);
//     print('Image saved to gallery: $result');
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         backgroundColor: Colors.green,
//         content: Text('Save Image in Gellary...'),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool search = true;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gallery App'),
//         centerTitle: true,
//         elevation: 5,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 border:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
//                 labelText: 'Search photos',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: _handleSearch,
//                 ),
//               ),
//             ),
//           ),
//       Expanded(
//             child: GridView.builder(
//               itemCount: _photos.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//               ),
//               itemBuilder: (BuildContext context, int index) {
//                 final photo = _photos[index];
//                 return GestureDetector(
//                   onTap: () {
//                     photo['links']['download'];
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           actions: [
//                             Center(
//                               child: Stack(
//                                 alignment: Alignment(1.2, 1.1),
//                                 children: [
//                                   Padding(
//                                     padding:
//                                     const EdgeInsets.only(top: 20),
//                                     child: Screenshot(
//                                       controller: screenshotController,
//                                       child: Image.network(
//                                         photo['urls']['regular'],
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   FloatingActionButton(
//                                     backgroundColor: Colors.grey,
//                                     onPressed: () async {
//                                       _captureScreenshot();
//                                       Navigator.pop(context);
//                                     },
//                                     child: Icon(
//                                       Icons.save_outlined,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                     print(photo['links']['download']);
//                   },
//                   child: Image.network(
//                     photo['urls']['regular'],
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   List<String> ADD = [
//     "https://images.unsplash.com/photo-1631824682181-dbe19cf64dab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=Mnw0NDA0MDF8MHwxfHNlYXJjaHwyfHwlMjRxdWVyeXxlbnwwfHx8fDE2ODIzOTczMzM&ixlib=rb-4.0.3&q=80&w=1080",
//     "https://images.unsplash.com/photo-1489875347897-49f64b51c1f8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=Mnw0NDA0MDF8MHwxfHNlYXJjaHwzfHwlMjRxdWVyeXxlbnwwfHx8fDE2ODIzOTczMzM&ixlib=rb-4.0.3&q=80&w=1080",
//     "https://images.unsplash.com/photo-1479502806991-251c94be6b15?ixlib=rb-4.0.3&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max",
//   ];
// }
//
//
//
// class Weather {
//   final String regular;
//
//   Weather({
//     required this.regular,
//   });
//
//   factory Weather.fromMap({required Map data}) {
//     return Weather(
//       regular: data['results'][0]['regular'],
//     );
//   }
// }
//
