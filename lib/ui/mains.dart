import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListScrolls extends StatefulWidget {
  @override
  _ListScrollsState createState() => _ListScrollsState();
}

class _ListScrollsState extends State<ListScrolls> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  ScrollController _scrollController = new ScrollController();

  List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrangeAccent[100],
        body: Container(
          width: double.infinity,
          child: AnimatedList(
            scrollDirection: Axis.horizontal,
            key: _key,
            initialItemCount: _items.length,
            itemBuilder: (context, index, animation) {
              if (index == _items.length - 1) {
                return addGestureDetector();
              }
              return _buildItem(_items[index], animation, index);
            },
          ),
        ));
  }

  Widget _buildItem(String item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 130.0,
        height: 130.0,
        child: Stack(children: <Widget>[
          Image.network(
              "https://i.guim.co.uk/img/media/837cd5e75bcfae578c8aaab1c948685c8fa447cd/310_531_3659_2196/master/3659.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=12b76b5207a96b2c79c25a90d1e064f1"),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                removeItem(index);
              },
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget addGestureDetector() {
    return GestureDetector(
        onTap: _addItem,
        child: Center(
            child: Container(
            alignment:Alignment.centerLeft,
            margin: EdgeInsets.all(8.0),
            width: 130.0,
            height: 130.0,
            padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
            color: Colors.green,
            child: new Column(children: [
              new Text("Ableitungen"),
            ]),
          ),
        ));
  }

  void removeItem(int index) {
    String removeItem = _items.removeAt(index);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removeItem, animation, index);
    };
    _key.currentState.removeItem(index, builder);
  }

  void _addItem() {
    setState(() {
      int i = _items.length > 0 ? _items.length : 0;
      _items.insert(i, 'Items ${_items.length + 1}');
      _key.currentState.insertItem(i);
    });

  }
}
