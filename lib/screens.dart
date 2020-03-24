import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learning/AppRoutes.dart';

class NavigationErrorScreen extends StatelessWidget {
  final RouteSettings routeSettings;

  const NavigationErrorScreen({Key key, this.routeSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Wrong route"),
    );
  }
}

class SecondScreen extends StatelessWidget {
  SecondScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("This is second screen"),
          FlatButton(
            child: Text("Return 42"),
            onPressed: () => Navigator.of(context).pop("42"),
          ),
          FlatButton(
            child: Text("Return abrahadabra"),
            onPressed: () => Navigator.of(context).pop("abrahadabra"),
          )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<bool> showExitDialog(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Question"),
            content: Text("Are you sure you want to exit?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Yes"),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No"),
              )
            ],
          ));

  Future<bool> showInfoDialog(BuildContext context, text) async =>
      showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Second screen says:"),
                content: Text("$text"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Ok, got it"),
                  )
                ],
              ));

  Future goToSecondScreenAndHandleAnswer(BuildContext context) async {
    final answer = await Navigator.of(context).pushNamed(AppRoutes.second);
    showInfoDialog(context, answer);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
      onWillPop: () {
        if (Navigator.of(context).canPop())
          return Future.value(true);
        return showExitDialog(context);
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('My perfect header'),
                decoration: BoxDecoration(color: Colors.lightGreen),
              ),
              ListTile(
                title: Text('Hello world'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.home);
                },
              ),
              ListTile(
                title: Text('Yeap, that\'s line with character escaping'),
                onTap: () => goToSecondScreenAndHandleAnswer(context),
              )
            ],
          ),
        ),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
              Center(
                  child: GestureDetector(
                    onTap: () => goToSecondScreenAndHandleAnswer(context),
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: 10, right: 10, left: 10, top: 10),
                        color: Colors.limeAccent[200],
                        child: FlutterLogo(
                          size: 300.0,
                        )),
                  )),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Column(
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Text('Text 1'),
                      Text('Text 2'),
                      Text('Text 3')
                    ],
                  ),
                  Column(
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Text('Text 1'),
                      Text('Text 2'),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
