import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new FoodApp());

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'UBC Food',
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColorBrightness: Brightness.light,
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

  Location activeLocation;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new StreamBuilder(
            stream: Firestore.instance.collection('locations').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.documents[index];
                    return _buildLocationCard(context, new Location(
                        ds['menu'], // TODO: handle items as separate stream?
                        name: ds['name'],
                        location: ds['location'],
                        logo: new Image.asset(ds['logo_url'])
                    ));
                  });
            }));
  }

  Widget _buildLocationCard(BuildContext context, Location lc) {
    return new Card(
        child: new ListTile(
          leading: lc.logo,
          title: new Text(lc.name),
          subtitle: new Text(lc.location),
          onTap: () {
            setState(() {
              activeLocation = lc;
            });
            _pushLocationScreen();
          },
        ));
  }

  void _pushLocationScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (context) {
            return new Scaffold(
              appBar: new AppBar(
                title: new Text(activeLocation.name),
              ),
              body: new ListView.builder(
                itemCount: activeLocation.menu.length,
                itemBuilder: (context, index) {
                  MenuItem item = activeLocation.menu[index];
                  return new Card(
                    child: new ListTile(
                      title: new Text(item.name),
                      subtitle: new Text('Rating: ${item.rating}'),
                    )
                  );
                },
              )
            );
          })
    );
  }

}

// MODELS

class Location {

  String name, location;
  Widget logo;
  List<MenuItem> menu;

  Location(menuItems, {this.name = "default location", this.location = "default place",
    this.logo = const Icon(Icons.clear)}) {
    menu = new List<MenuItem>();
    for (Map menuItem in menuItems) {
      menu.add(new MenuItem(
        name: menuItem['name'],
        rating: menuItem['rating']
      ));
    }
  }

}

class MenuItem {
  
  String name;
  int rating;
  
  MenuItem({this.name = "default menu item",this.rating = 0});
  
}
