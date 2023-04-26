import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/gallary_modal.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {


  ScreenshotController screenshotController = ScreenshotController();

  void _captureScreenshot() async {
    // capture screenshot
    final Uint8List = await screenshotController.capture();

    // save image to gallery
    final result = await ImageGallerySaver.saveImage(Uint8List!);
    print('Image saved to gallery: $result');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Save Image in Gallery'),
        duration: Duration(seconds: 3),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    Gallary detail = ModalRoute.of(context)!.settings.arguments as Gallary;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
                height: double.infinity,
                // width: MediaQuery.of(context).size.width,
                child: Image.network(
                  "${detail.largeImageURL}",
                  fit: BoxFit.fitHeight,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await Share.share(
                        "${detail.largeImageURL}");
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.white,
                    child: Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                        )),
                  ),
                ),
                SizedBox(width: 20,),


                GestureDetector(
                  onTap: ()  {
                    _captureScreenshot();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.white,
                    child: Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.file_download_outlined,
                          color: Colors.black,
                        )),
                  ),
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.white,
                    child: Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 70),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.white,
                    child: Container(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
