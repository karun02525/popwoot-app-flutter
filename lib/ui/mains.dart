import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/ui/theme.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrangeAccent[100],
        body: Row(
          children: <Widget>[
            addGestureDetector(),
            Expanded(
            child:AnimatedList(
              scrollDirection: Axis.horizontal,
              key: _key,
              controller: _scrollController,
              shrinkWrap: true,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                if (index == _items.length - 1) {
                  //return addGestureDetector();
                }
                return _buildItem(_items[index], animation, index);
              },
            )),
          ],
        ));
  }

  Widget _buildItem(String item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.horizontal,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(8.0),
          width: 130.0,
          height: 130.0,
          child:Align(
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
          ),

          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent,),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              new BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                  offset: new Offset(1.0, 1.0))
            ],
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://i.guim.co.uk/img/media/837cd5e75bcfae578c8aaab1c948685c8fa447cd/310_531_3659_2196/master/3659.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=12b76b5207a96b2c79c25a90d1e064f1')
            ),
          ),
        ),
      ),
    );
  }

  Widget addGestureDetector() {
    return GestureDetector(
        onTap: _addItem,
          child: Container(
            margin: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            width: 130.0,
            height: 130.0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add_a_photo,size: 32.0,color: Colors.white,),
                  Text('Add Photos', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontFamily: font),)
                ],
              )


            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent,),
                borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    offset: new Offset(1.0, 1.0))
              ],
            ),

        )
    );
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
      _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

    });
  }
}
