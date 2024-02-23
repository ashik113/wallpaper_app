import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Text('image'),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {},
              child: Text('Load More'),
            ),
          )
        ],
      ),
    );
  }
}
