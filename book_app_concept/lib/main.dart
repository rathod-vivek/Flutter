import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);

  //final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = PageController();
  final _notifierScroll = ValueNotifier(0.0);

  void _listner() {
    _notifierScroll.value = _controller.page;
  }

  @override
  void initState() {
    _controller.addListener(_listner);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listner);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bookHeight = size.height * 0.45;
    final bookWidth = size.width * 0.6;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/Bg.png'),
          ),
          SizedBox(
            height: kToolbarHeight,
            child: AppBar(
              backgroundColor: Colors.white,
              leadingWidth: 0,
              centerTitle: false,
              elevation: 0,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(
                'Bookio',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          ValueListenableBuilder<double>(
              valueListenable: _notifierScroll,
              builder: (context, value, _) {
                return PageView.builder(
                  //physics: ClampingScrollPhysics(),
                  controller: _controller,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    final percentage = index - value;
                    final rotation = percentage.clamp(0.0, 1.0);
                    final fixRotation = pow(rotation, 0.35);
                    // print('index:');
                    // print(index);
                    // if (index == 1) {
                    //   print(percentage);
                    // }
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  height: bookHeight,
                                  width: bookWidth,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black26,
                                        offset: Offset(5.0, 5.0),
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Transform(
                                  alignment: Alignment.centerLeft,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.002)
                                    ..rotateY(1.8 * fixRotation)
                                    ..translate(-rotation * size.width * 0.80)
                                    ..scale(1 + rotation),
                                  child: Image.asset(
                                    book.image,
                                    fit: BoxFit.cover,
                                    height: bookHeight,
                                    width: bookWidth,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          Opacity(
                            opacity: 1 - rotation,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${book.title}',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'By ${book.author}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
