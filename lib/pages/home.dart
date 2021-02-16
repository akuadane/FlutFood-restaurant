import 'package:flut_food_restaurant/food_item/model/add_update_screen_arguments.dart';
import 'package:flut_food_restaurant/food_item/screens/add_update_food_item.dart';
import 'package:flut_food_restaurant/food_item/screens/food_item_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController _controller;
  int _index = 0;
  List<Widget> _tabs = [
    Column(
      children: [
        Text('PENDING'),
      ],
    ),
    Column(
      children: [
        Text('PROCESSING'),
      ],
    ),
    Column(
      children: [
        Text('PROCESSED'),
      ],
    ),
  ];
  List<Widget> _tabViews = [
    Text('PENDING ORDERS'),
    Text('PROCESSING ORDERS'),
    Text('PROCESSED ORDERS'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text(_index == 0 ? 'Orders' : 'Food Items'),
        bottom: _index == 0
            ? TabBar(
                controller: _controller,
                tabs: _tabs,
              )
            : null,
        actions: [
          _index == 1
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, AddUpdateFoodItem.routeName,
                        arguments: AddUpdateScreenArgument());
                  },
                )
              : Container(),
        ],
      ),
      body: _index == 0
          ? TabBarView(
              controller: _controller,
              children: _tabViews,
            )
          : FoodItemList(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (idx) => setState(() {
          _index = idx;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder_rounded),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining_sharp),
            label: "Items",
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }
}
