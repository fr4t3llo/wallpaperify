import 'dart:io';
// import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class FullImage extends StatelessWidget {
  final String imgUrl;

  FullImage({super.key, required this.imgUrl});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> setWallpaperFromFile(
      String wallpaperUrl, BuildContext context) async {
    try {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Permission denied to access storage"),
        ));
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Downloading Started..."),
      ));

      final file = await DefaultCacheManager().getSingleFile(wallpaperUrl);
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        final filePath = '${directory.path}/${wallpaperUrl.split('/').last}';
        await File(filePath).writeAsBytes(await file.readAsBytes());

        await ImageGallerySaver.saveImage(await file.readAsBytes());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Downloaded Successfully"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to get storage directory"),
        ));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error Occurred: $error"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: SizedBox(
        width: 120,
        height: 50,
        child: FloatingActionButton(
          onPressed: () async {
            await setWallpaperFromFile(imgUrl, context);
          },
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Download',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'my'),
              ),
              Icon(
                Icons.download,
                color: Color.fromARGB(
                    255, 18, 173, 4), // Change the color of the icon here
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
