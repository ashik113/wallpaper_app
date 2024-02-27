// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'explore_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List collections = [];
  List medias = [];
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
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        medias = result['media'];
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ExplorePage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    print(medias.length);
    print(collections.length);

    return Scaffold(
        body: Container(
      child: Column(children: [
        Expanded(
          child: GridView.builder(
            itemCount: collections.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (context, index) {
              id = collections[index]['id'];
              return GestureDetector(
                onTap: () {
                  exploreCollection(id);
                },
                child: Container(
                    margin: EdgeInsets.all(15.0),
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
                        medias[index]['type'] == 'Photo'
                            ? Image.network(medias[index]['src']['tiny'])
                            : Image.network('https://picsum.photos/200'),
                      ],
                    )),
              );
            },
          ),
        ),
      ]),
    ));
  }
}
