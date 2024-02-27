// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List collections = [];
  String title = '';
  int photosCount = 0;
  int mediaCount = 0;
  String id = '';
  @override
  void initState() {
    fetchCollections();
    super.initState();
  }

  fetchCollections() async {
    await http.get(
        Uri.parse("https://api.pexels.com/v1/collections/featured?per_page=30"),
        headers: {
          'Authorization':
              'f3RBfS0EpXJgX5ArX3GZY3Ju04MXRgjsLIu2LlfxT3KWxWkjvSzBLDMk'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        collections = result['collections'];
      });
    });
  }

  exploreCollection(String id) async {
    String url =
        "https://api.pexels.com/v1/collections/" + id + "?per_page=1&sort=desc";
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          'f3RBfS0EpXJgX5ArX3GZY3Ju04MXRgjsLIu2LlfxT3KWxWkjvSzBLDMk'
    }).then((value) => print(value.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(children: [
        Expanded(
            child: GridView.builder(
                itemCount: collections.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  id = collections[index]['id'];

                  return InkWell(
                    onTap: exploreCollection(id),
                    child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Center(
                              child: Text(
                                collections[index]['title'],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              (collections[index]['photos_count']).toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        )),
                  );
                })),
      ]),
    ));
  }
}
