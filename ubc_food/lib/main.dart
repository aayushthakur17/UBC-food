import 'package:flutter/material.dart';

void main() => runApp(new FoodApp());

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'UBC Food',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new HomePage(title: 'UBC Food Locations'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Center(
          child: new Text("stuff to go here"),
        ));
  }
}
