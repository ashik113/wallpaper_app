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
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 80,
                    childAspectRatio: 0.5,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.black,
                    );
                  }),
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
