import 'dart:ui';

import 'package:flutter/material.dart';

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
        brightness: Brightness.dark,
        //primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  //const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

// class ImageData {
//   const ImageData({@required this.image});

//   final String image;
// }

// //const _bookAppAsset = 'assets';

// final images = const [
//   ImageData(image: 'assets/samji2.jpg'),
//   ImageData(image: 'assets/samji3.jpg'),
//   ImageData(image: 'assets/samji1.jpg'),
//   ImageData(image: 'assets/samji4.jpg'),
//   ImageData(image: 'assets/samji5.jpg')
// ];

class _MainPageState extends State<MainPage> {
  List<String> imageFiles = [
    "assets/samji2.jpg",
    "assets/samji3.jpg",
    "assets/samji1.jpg",
    "assets/samji4.jpg",
    "assets/samji5.jpg"
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    //final img = images[index];
    final size = MediaQuery.of(context).size;
    final bookHeight = size.height * 0.45;
    final bookWidth = size.width * 0.6;
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            key: ValueKey<String>(imageFiles[_currentPage]),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(imageFiles[_currentPage]),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 15,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.55,
          child: PageView.builder(
            itemCount: imageFiles.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
              //print(_currentPage);
            },
            itemBuilder: (BuildContext context, int index) {
              //final data = imageFiles[index];
              return FractionallySizedBox(
                widthFactor: 0.65,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          imageFiles[index],
                          //data.image,
                          fit: BoxFit.cover,
                          height: bookHeight,
                          width: bookWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
