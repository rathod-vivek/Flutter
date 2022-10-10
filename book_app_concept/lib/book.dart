import 'package:flutter/material.dart';

class Book {
  const Book({
    @required this.title,
    @required this.author,
    @required this.image,
  });

  final String title;
  final String author;
  final String image;
}

const _bookAppAsset = 'assets';
final _bookAppBackground = '$_bookAppAsset/bg.png';

final books = const [
  Book(
      title: 'Wink Poppy MIdnight',
      author: 'April Genevieve',
      image: '$_bookAppAsset/book1.jpg'),
  Book(
      title: 'Walking With Miss Millie',
      author: 'Tamara Bundy',
      image: '$_bookAppAsset/book2.jpg'),
  Book(title: 'Trio', author: 'Sara Tolmie', image: '$_bookAppAsset/book3.jpg'),
  Book(
      title: 'The Jungle Book',
      author: 'Rudyyard Kipling',
      image: '$_bookAppAsset/book4.jpg'),
  Book(
      title: 'The Maker of Swans',
      author: 'Paraig O\'Donnell',
      image: '$_bookAppAsset/book5.jpg'),
];
