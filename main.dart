import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nfp/wordslib.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFP',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Non-find Predict') ,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  //MyHomePage({Key key2, this.title}) : super(context: context);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

  //_MyHomeWidgetState createState() => _MyHomePageState();
  _MyHomeWidgetState replaceState() => _MyHomeWidgetState();
}

class _superiorHelper extends _MyHomePageState{

}

class _MyHomePageState extends State<MyHomePage> {
  int _points = 0;
  int _recordPoints =0;
  int _checkChance=0;
  var tmp = '';
  var tmpWord= '*';
  //final wordPair = '';
  int _chances = 1;
  int level = 1;
  String _starsTxt="*";

  var _textFF = new TextEditingController();
  var _stext = new TextFormField();

  num get prevStateChances => null;

  void changeLevel() {
    setState(() {

    
    });
  }

  void setChancesDependsLevel() {
    if(level==1) _chances=6;
    if(level==2) _chances=5;
    if(level==3) _chances=4;
    if(level==4) _chances=3;
    if(level==5) _chances=2;
    if(level==6) _chances=1;

    if(prevStateChances != null) _chances = _chances - (_chances-prevStateChances);

  }

  void _incrementCounter() {
    setState(() {
      _points++;
    });
  }
  void _decrementCounter() {
      setState(() {
        _points--;
      });
  }

  void _incrementChance() {
    //setState(() {
    if(_chances<6) {
      _chances++;
      print('Balance of Chance - incresed');
      //});
    }
  }
  void _decrementChance() {
    setState(() {
      _chances--;
      print('Balance of Chance - decresed');
    });
  }


  var wordPair = WordPair.random();

  Widget inputTextField() {
    return new TextFormField(
      controller: _textFF,

      onChanged: (text) {
        _showLetter(wordPair.toString(), tmpWord);
        //if(wordPair.toString())
      },
      onFieldSubmitted: (text) {
        _showLetter(wordPair, tmpWord);
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        //Margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
        //contentPadding: EdgeInsets.symmetric(horizontal: 10),
        contentPadding:  new EdgeInsets.all(20.0),
        hintText: 'Type here',
        errorText: 'Wrong',
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            _textFF.clear();
            //FocusScope.of(context).unfocus();
            FocusScope.of(context).addListener(() {});
          },
          icon: Icon(Icons.clear),
        ),
      ),
      //keyboardType: TextInputType.text,
      style: TextStyle(
          backgroundColor: Colors.transparent,
          color: Colors.black,
          fontSize: 20),
      maxLines: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    setChancesDependsLevel();
    wordPair= WordPair.random();  //= WordPair.random();
    _starsTxt = "*" * wordPair.toString().length;
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                  //contentPadding:  new EdgeInsets.all(20.0),
                  children: <Widget>[
                      //Text( 'Word -  ${wordPair.toString()}', style: Theme.of(context).textTheme.headline4,
                      //),
                      Text('Word - ${wordPair.toString()}', style: Theme.of(context).textTheme.headline4
                      //Text('Word - ${wp}', style: Theme.of(context).textTheme.headline4
                      ),
                      SizedBox(height: 5
                      ),
                      Text( '${_starsTxt.toString()}', style: Theme.of(context).textTheme.headline5,
                      ),
                      Text('\n'
                      ),
                      Text('Chances left: $_chances , Level: $level', style: Theme.of(context).textTheme.headline6
                      ),
                      SizedBox(width: 10,height: 20
                      ),
                      inputTextField(),
                    Text(
                        '\n'
                    ),
                    /*
                    CupertinoButton(
                      child: Text("OK"),
                      onPressed: () =>  null,
                    ),*/
                    Text(
                        '\n'
                    ),
                    ListTile(
                //contentPadding: EdgeInsets.all(<some value here>),//change for side padding
                       title: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           SizedBox(width: 10),
                           Expanded(
                             child: _buildRaisedButton_Check(context, wordPair),
                          ),
                           Text('\t\t\t'),
                           SizedBox(width: 50),
                           Expanded(
                             child: _buildRaisedButton_Next(context, wordPair),
                           ),

                         ],
                       ),
                     ),
                  ],
              ),
            ),

            Text(
                '\n\n'
            ),
            Text(
              'Your points',
                style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '$_points', style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '\nYour record',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '$_recordPoints', style: Theme.of(context).textTheme.headline4,
            ),

          ],
        ),
      ),
        floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 20,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          visible: true,
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.6,
          //onOpen: () => print('OPENING DIAL'),
          //onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 10.0,
          shape: CircleBorder(),

          children: [
            SpeedDialChild(
                child: Icon(Icons.save),
                backgroundColor: Colors.red,
                label: 'SAVE',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('FIRST CHILD')
            ),
            SpeedDialChild(
              child: Icon(Icons.collections_bookmark),
              backgroundColor: Colors.blue,
              label: 'LOAD',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('SECOND CHILD'),
            ),
            SpeedDialChild(
              child: Icon(Icons.fiber_new),
              backgroundColor: Colors.amberAccent,
              label: 'NEW GAME',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('THIRD CHILD'),
            ),
            SpeedDialChild(
              //isEnabled = false;
              onTap: () => Intent.doNothing,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            SpeedDialChild(
              child: Icon(Icons.lightbulb_outline),
              backgroundColor: Colors.lightBlueAccent,
              label: 'Add CHANCE',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => ( _incrementChance()
              ),
            ),
            SpeedDialChild(
              child: Icon(Icons.flash_on),
              backgroundColor: Colors.redAccent,
              label: 'Change LEVEL',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => ( null ),
            ),
          ],
        ),
    );
  }

  RaisedButton _buildRaisedButton_Check(BuildContext context, var wordPair) {
    return RaisedButton(onPressed: () {

      if(_checkWord(wordPair)==true) {
        _textFF.clear();
        if(_chances>0 && _chances<7){
          _decrementChance();
        }
        if(_chances<=0) {
          throw new Exception();
        }
        setState(() {
          _checkWord(wordPair);

          if (_points >= 10 && _points < 20) {
            level = 2;
            setChancesDependsLevel();
            if (_points >= 20 && _points < 30) {
              level = 3;
              setChancesDependsLevel();
              if (_points >= 30 && _points < 40) {
                level = 4;
                setChancesDependsLevel();
                if (_points >= 40 && _points < 50) {
                  level = 5;
                  setChancesDependsLevel();
                  if (_points >= 50) {
                    level = 6;
                    setChancesDependsLevel();
                  }
                }
              }
            }
          }


          /*
          if (_chances == 0) {
            setState(() {
              //_checkWord(wordPair);
              _starsTxt = "*" * wordPair
                  .toString()
                  .length;
              if (_starsTxt.contains('*')) {

              }
            });
          }

          if (_chances > 1 && wordPair.contains(_textFF.text.toString())) {

          }

           */

        });
      }

      },
      child: Text("Check",style: Theme.of(context).textTheme.headline6),
      color: Colors.amber,
      textColor: Colors.black,
      focusColor: Colors.black,
      splashColor: Colors.white,
      elevation: 10.0,

      shape: //CircleBorder(),
      Border.all(
        color: Colors.amberAccent,
      width: 1.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }

  RaisedButton _buildRaisedButton_Next(BuildContext context, var wordPair) {
    return RaisedButton(onPressed: () {
        setState(() {
          var wptmp = wordPair.toString();
          if(_points>=10 && _points<20) {
            level=2;
            setChancesDependsLevel();
            if(_points>=20 && _points<30) {
              level=3;
              setChancesDependsLevel();
              if(_points>=30 && _points<40) {
                level=4;
                setChancesDependsLevel();
                if(_points>=40 && _points<50) {
                  level=5;
                  setChancesDependsLevel();
                  if(_points>=50 ) {
                    level=6;
                    setChancesDependsLevel();
                  }}}}}

          _starsTxt = "*" * wordPair.toString().length;
          return Text(wordPair.asPascalCase);
        });
        wordPair = WordPair.random();
      },
      child: Text("Next",style: Theme.of(context).textTheme.headline6),
      color: Colors.amber,
      textColor: Colors.black,
      splashColor: Colors.white,
      shape: Border.all(
          color: Colors.amberAccent,
          width: 1.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      elevation: 10.0,
    );
  }

  bool _checkWord(var wordPair) {

    if (_textFF.text == wordPair.toString()) {
      _points++;
      if(_recordPoints<=_points) {
        _recordPoints=_points;
      }
      return true;
    }
    else {
      _textFF.clear();
      return false;
    }
  }

  void _hideWord(var wordPair, var tmp){
      tmp = wordPair.toString();

  }

  void _showLetter(var wordPair, var tmp){
    for(int o=0; o<_textFF.text.length; o++)
    {
      for(int t=0; t<wordPair.toString().length; t++)
      {
        if(_textFF.text[o] == wordPair.toString()[t])
        {
          tmp.replaceRange(t, t, _textFF.text[o]);// =_textFF.text[o];
        }
      }
    }

  }

  void _showWord(var wordPair){
  }

  void textFieldArea_Changed(var key) {

  }

}

class _MyHomeWidgetState extends State<MyHomePage>
{
  var _textFieldwStars =  new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    try {
      Widget inputTextField() {
        return new TextField(
          // controller: _textFieldwStars,
          controller: _textFieldwStars,
          onChanged: (text) {

          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            //Margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
            //contentPadding: EdgeInsets.symmetric(horizontal: 10),
            contentPadding: new EdgeInsets.all(20.0),
            hintText: 'Type here',
            errorText: 'Wrong',
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                //FocusScope.of(context).unfocus();
                FocusScope.of(context).addListener(() {});
              },
              icon: Icon(Icons.clear),
            ),
          ),
          //keyboardType: TextInputType.text,
          style: TextStyle(
              backgroundColor: Colors.transparent,
              color: Colors.black,
              fontSize: 20),
          maxLines: 1,
        );
      }
    }
    finally{

    }

    if(context == null) throw UnimplementedError();
  }

}

changeWord(BuildContext context)
{
  Widget widget = Text(
    '${generateWordPairs()}'
  );
}

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () { },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

/*

                   FlatButton(
                      onPressed: () {
                        setState(() {

                        });
                      },
                      child: const Text('Check'),
                        color: Colors.amber,
                        textColor: Colors.black,

                      ),

floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(
                    Icons.delete
                ),
                onPressed: () {
                  //...
                },
                heroTag: null,
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                child: Icon(
                    Icons.star
                ),
                onPressed: () => _incrementCounter(),
                heroTag: null,
              )
            ]


      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),


 */
