import 'dart:convert';

import 'package:flut_food_restaurant/authentication/bloc/authentication_bloc.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/role/bloc/role_bloc.dart';
import 'package:flut_food_restaurant/user/bloc/user_bloc.dart';
import 'package:flut_food_restaurant/user/models/add_update_user_argument.dart';
import 'package:flut_food_restaurant/user/screens/user_list.dart';
import 'package:flut_food_restaurant/widgets/role_card_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddUpdateUser extends StatefulWidget {
  final User user;
  final bool edit;

  AddUpdateUser({this.user, this.edit = false});

  static const String routeName = 'add-update-user';

  @override
  _AddUpdateUserstate createState() => _AddUpdateUserstate();
}

class _AddUpdateUserstate extends State<AddUpdateUser> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _user = {};
  RoleBloc roleBloc;
  List<bool> roleCheckboxes;
  UserBloc userBloc;
  List<Role> roles;
  List<Role> userRoles;
  List<int> rolesFixedLength;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  void changeRoleToggle(Role newValue) {
    if (userRoles.contains(newValue)) {
      userRoles.remove(newValue);
    } else {
      userRoles.add(newValue);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    roleBloc = context.read<RoleBloc>();
    userBloc = context.read<UserBloc>();
    roles = roleBloc.state.roles;
    userRoles = widget.edit ? widget.user.roles : [];

    rolesFixedLength = Iterable<int>.generate(roles.length).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.edit ? 'Update User' : "Add User"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: BlocListener<UserBloc, UserState>(
          listenWhen: (prev, curr) {
            return !(curr is UserLoadingState);
          },
          listener: (_, state) {
            setState(() {
              _isLoading = false;
            });
            if (state is UserLoadSuccessState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  UserListScreen.routeName, (route) => false);
            }
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text("Full name")),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue:
                                widget.edit ? widget.user.fullName : '',
                            decoration: InputDecoration(
                                hintText: 'Enter user full name',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              String error = value.length < 3
                                  ? "Full name should be at least 3 characters long"
                                  : null;
                              return error;
                            },
                            onSaved: (value) {
                              setState(() {
                                _user['fullname'] = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Username')),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue:
                                widget.edit ? widget.user.userName : '',
                            decoration: InputDecoration(
                                hintText: 'Enter username',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              String error = value.length < 3
                                  ? "User name should be at least 3 characters long"
                                  : null;
                              return error;
                            },
                            onSaved: (value) {
                              setState(() {
                                _user['username'] = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("Email:")),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue: widget.edit ? widget.user.email : '',
                            decoration: InputDecoration(
                                hintText: 'Enter user email',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              String error = value.length < 3
                                  ? "User email should be at least 3 characters long"
                                  : null;
                              return error;
                            },
                            onSaved: (value) {
                              setState(() {
                                _user['email'] = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("Phone")),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue: widget.edit ? widget.user.phone : '',
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Enter user phone',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              String error = value.length < 3
                                  ? "User phone should be at least 3 characters long"
                                  : null;
                              return error;
                            },
                            onSaved: (value) {
                              setState(() {
                                _user['phone'] = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text("Password:")),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue:
                                widget.edit ? widget.user.password : '',
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Enter password',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              String error = value.length < 6
                                  ? "User password should be at least 3 characters long"
                                  : null;
                              return error;
                            },
                            onSaved: (value) {
                              setState(() {
                                _user['password'] = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('Roles')),
                        Expanded(
                          flex: 3,
                          child: FormField(
                            builder: (FormFieldState<dynamic> field) {
                              return ListView(
                                children: rolesFixedLength
                                    .map((idx) => RoleCardEdit(
                                          role: roles[idx],
                                          onChanged: changeRoleToggle,
                                          value: userRoles.contains(roles[idx]),
                                        ))
                                    .toList(),
                                shrinkWrap: true,
                              );
                            },
                            onSaved: (value) {
                              _user['roles'] =
                                  userRoles.map((e) => e.toJson()).toList();
                            },
                          ),
                        ),
                      ],
                    ),
                    ButtonBar(
                      buttonPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      children: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('CANCEL')),
                        RaisedButton(
                          onPressed: () async {
                            _formKey.currentState.save();
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              _user["id"] = widget.edit ? widget.user.id : null;
                              !widget.edit
                                  ? userBloc.add(
                                      UserAddEvent(user: User.fromJson(_user)))
                                  : userBloc.add(UserUpdateEvent(
                                      user: User.fromJson(_user)));
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Please provide valid data")));
                            }
                          },
                          child: Text(widget.edit ? 'UPDATE' : 'ADD',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.deepPurple,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
