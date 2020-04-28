 import 'package:flutter/material.dart';
 import 'package:english_words/english_words.dart';

 void main() => runApp(MyApp());

 class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
         return MaterialApp(
             title: 'Welcome to Flutter',
             home: Scaffold(
                 appBar: AppBar(
                     title: Text('Welcome to Flutter'),
                 ),
                 body: Center(
                     child: RandomWords(),
                 ),
             ),
         );
     }
 }


class RandomWordsState extends State<RandomWords> {
    @override                              // Add from this line ... 
    Widget build(BuildContext context) {
        final WordPair wordPair = WordPair.random();
        return Text(wordPair.asPascalCase);
    }                                      // ... to this line.
}


class RandomWords extends StatefulWidget {
    @override
    RandomWordsState createState() => RandomWordsState();
 }