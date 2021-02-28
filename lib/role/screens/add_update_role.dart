
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/role/bloc/role_bloc.dart';
import 'package:flut_food_restaurant/role/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddUpdateRole extends StatefulWidget {
  static const String routeName = 'add-update-food-role';

  @override
  _AddUpdateRolestate createState() => _AddUpdateRolestate();
}

class _AddUpdateRolestate extends State<AddUpdateRole> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _role = {};

  RoleBloc roleBloc;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final AddUpdateScreenArgument args =
        ModalRoute.of(context).settings.arguments;
    roleBloc = BlocProvider.of<RoleBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(args.edit ? 'Update Role' : "Add Role"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: args.edit ? args.role.name : '',
                    decoration: InputDecoration(
                        hintText: 'Enter role name',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      String error = value.length < 3
                          ? "Role name should be at least 3 characters long"
                          : null;
                      return error;
                    },
                    onSaved: (value) {
                      setState(() {
                        _role['name'] = value;
                      });
                    },
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
                            !args.edit
                                ? roleBloc.add(
                                    RoleAddEvent(role: Role.fromJson(_role)))
                                : roleBloc.add(RoleUpdateEvent(
                                    role: Role.fromJson(_role)));
                            if (roleBloc.state is RoleLoadFailureState) {
                              setState(() {
                                _isLoading = false;
                              });
                            } else if (roleBloc.state is RoleLoadingState) {
                              setState(() {
                                _isLoading = true;
                              });
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(args.edit
                                      ? 'Role updated successfully'
                                      : 'Role added successfully')));
                              roleBloc.add(LoadRolesEvent());
                              Navigator.pop(context);
                            }
                            // } catch (e) {
                            //   print("error: $e");
                            //   setState(() {
                            //     _isLoading = false;
                            //   });
                            //   _scaffoldKey.currentState.showSnackBar(SnackBar(
                            //       content: Text(args.edit
                            //           ? 'Updating Role failed'
                            //           : 'Adding Role failed')));
                            // }
                          } else {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Please provide valid data")));
                          }
                        },
                        child: Text(args.edit ? 'UPDATE' : 'ADD',
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
