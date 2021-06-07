import 'package:flutter/material.dart';
import 'dart:io';
import 'package:english_words/english_words.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'main.dart';

class RandomWords extends StatefulWidget {
  _RandomWordsState nextWord() => _RandomWordsState();

  @override
  _RandomWordsState createState() => _RandomWordsState();

}

class _RandomWordsState extends State<RandomWords> {

  @override
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget build(BuildContext context) {

    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }

  Widget _build(BuildContext context, var item){
    return Text(item);
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

}


class myWidget extends StatefulWidget {
  String someText;
  final int someCount;
  TextInput kl;

  myWidget({this.someText, this.someCount});

  @override
  _myWidgetState createState() => _myWidgetState();
}

class _myWidgetState extends State<myWidget>{
  int count=0;

  @override
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget build(BuildContext context) {
    final wordPair = WordPair.random();

    setState(() {
      Text('Word - ');
      widget.someText= wordPair.toString();
      count++;
    });
    return Text('${widget.someText}');

  }
}