import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class SetWallpaperScreen extends StatefulWidget {
  String imageUrl;
  SetWallpaperScreen({super.key, required this.imageUrl});

  @override
  State<SetWallpaperScreen> createState() => _SetWallpaperScreenState();
}

class _SetWallpaperScreenState extends State<SetWallpaperScreen> {
  setWallpaper() async {
    var wallpaperLocation = WallpaperManager.HOME_SCREEN;
    var filePath = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    await WallpaperManager.setWallpaperFromFile(
        filePath.path, wallpaperLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set wallpaper'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            MaterialButton(
              height: 50,
              onPressed: () {
                setWallpaper();
              },
              child: Container(
                width: double.infinity,
                height: 25,
                child: Center(
                  child: Text(
                    'Set Wallpaper',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
