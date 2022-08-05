import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_input/connection.dart';
import 'package:sqlite_input/datauser.dart';
import 'package:sqlite_input/updateuser.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('SQLITE DATA')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //margin: const EdgeInsets.only(top: 20.0),
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.red,
                // image: DecorationImage(
                //     image: AssetImage('assets/images/bridestone.png')),
              ),
              child: ImageSlideshow(
                children: [
                  Image.asset('assets/images/bridestone.png'),
                  Image.asset('assets/images/yokohama.png'),
                  Image.asset('assets/images/goodyear.png'),
                  Image.asset('assets/images/westlake.png'),
                  Image.asset('assets/images/michelin.png'),
                ],
                autoPlayInterval: 3000,
                isLoop: true,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Card(
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                      image: AssetImage('assets/images/bridestone1.png')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
