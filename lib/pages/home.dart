import 'package:flut_food_restaurant/authentication/bloc/authentication_bloc.dart';
import 'package:flut_food_restaurant/authentication/screens/login.dart';
import 'package:flut_food_restaurant/food_item/model/add_update_screen_arguments.dart';
import 'package:flut_food_restaurant/food_item/screens/add_update_food_item.dart';
import 'package:flut_food_restaurant/food_item/screens/food_item_list.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/order/screens/order_list_screen.dart';
import 'package:flut_food_restaurant/role/screens/role_list.dart';
import 'package:flut_food_restaurant/user/screens/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  final User user;

  static const String routeName = "/home";

  Home({@required this.user});

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
    OrderListScreen(orderType: "PENDING"),
    OrderListScreen(orderType: "PROCESSING"),
    OrderListScreen(orderType: "PROCESSED"),
  ];

  @override
  Widget build(BuildContext context) {
    final user =
        (context.read<AuthenticationBloc>().state as AuthenticationSuccess)
            ?.user;
    return Scaffold(
      appBar: AppBar(
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
              : IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(LogOutEvent());
                  },
                ),
        ],
      ),
      body: _index == 0
          ? BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (_, state) {
                if (state is AuthenticationFailed) {
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                }
              },
              child: TabBarView(
                controller: _controller,
                children: _tabViews,
              ),
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
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 35.0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add_a_photo,
                  size: 32.0,
                ),
              ),
              accountName: Text(
                user.fullName,
                style: TextStyle(fontSize: 24.0),
              ),
              accountEmail: Text(user.email),
              otherAccountsPictures: <Widget>[
                Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                )
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.group_add),
                  title: Text('Users'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => UserListScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.group_add),
                  title: Text('Roles'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RoleListScreen()));
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Setting'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                AboutListTile(
                  icon: Icon(Icons.info_outline),
                  applicationName: 'Flut Food',
                  applicationVersion: '1.0.0',
                  applicationLegalese:
                      'Flut Food restaurant application, developed by the best team in section 1',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }
}
