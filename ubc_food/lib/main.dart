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

  final List<String> _locations = ["Totem", "Open Kitchen", "Gather"];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Center(
          child: new ListView(
            children: _buildLocationViews(),
          )
        ));
  }

  List<Widget> _buildLocationViews() {
    List<Widget> views = new List<Widget>();
    for (String name in _locations) {
      views.add(new Card(
        child: new ListTile(
          title: new Text(name)
        )
      ));
    }
    return views;
  }
}
