import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/screens/set_wallpaper_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [];
  int page = 1;
  @override
  void initState() {
    fetchAPI();
    super.initState();
  }

  fetchAPI() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {
          'Authorization':
              'f3RBfS0EpXJgX5ArX3GZY3Ju04MXRgjsLIu2LlfxT3KWxWkjvSzBLDMk',
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }

  loadMore() async {
    setState(() {
      page++;
    });

    String url = "https://api.pexels.com/v1/curated?per_page=80&page=$page";

    await http.get(
      Uri.parse(url),
      headers: {
        'Authorization':
            'f3RBfS0EpXJgX5ArX3GZY3Ju04MXRgjsLIu2LlfxT3KWxWkjvSzBLDMk'
      },
    ).then((value) {
      Map result = jsonDecode(value.body);
      images.addAll(result['photos']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpapers'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SetWallpaperScreen(
                              imageUrl: images[index]['src']['large2x']),
                        ),
                      ),
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          images[index]['src']['tiny'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          MaterialButton(
            height: 50,
            onPressed: () {
              loadMore();
            },
            child: Container(
              width: double.infinity,
              height: 25,
              child: Center(
                child: Text(
                  'Load More',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
