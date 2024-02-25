import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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
      body: Container(
        child: Column(children: [
          Expanded(
            child: Container(
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            child: TextButton(
                onPressed: () {
                  setWallpaper();
                },
                child: Text(
                  'Set Wallpaper',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
