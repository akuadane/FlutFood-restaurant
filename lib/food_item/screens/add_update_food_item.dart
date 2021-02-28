import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flut_food_restaurant/category/bloc/category_bloc.dart';
import 'package:flut_food_restaurant/food_item/bloc/bloc.dart';
import 'package:flut_food_restaurant/food_item/model/add_update_screen_arguments.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/ingredient/bloc/ingredient_bloc.dart';
import 'package:flut_food_restaurant/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddUpdateFoodItem extends StatefulWidget {
  static const String routeName = 'add-update-food-item';

  @override
  _AddUpdateFoodItemState createState() => _AddUpdateFoodItemState();
}

class _AddUpdateFoodItemState extends State<AddUpdateFoodItem> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _item = {};
  final ImagePicker imagePicker = ImagePicker();
  CategoryBloc categoryBloc;
  IngredientBloc ingredientBloc;
  FoodItemBloc foodItemBloc;
  PickedFile pickedFile;
  File picture;
  List<bool> checkboxesCategories;
  List<bool> checkboxesIngredients;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  Future<void> _pickFile(ImageSource src) async {
    pickedFile = await imagePicker.getImage(source: src);
    setState(() {
      picture = File(pickedFile?.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AddUpdateScreenArgument args =
        ModalRoute.of(context).settings.arguments;
    foodItemBloc = BlocProvider.of<FoodItemBloc>(context);
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    ingredientBloc = BlocProvider.of<IngredientBloc>(context);
    checkboxesCategories =
        List.filled(categoryBloc.state.categories.length, false);
    checkboxesIngredients =
        List.filled(ingredientBloc.state.ingredients.length, false);
    if (args.edit) {
      _item['id'] = args.item.id;
      for (int i = 0; i < categoryBloc.state.categories.length; i++) {
        if (args.item.categories.contains(categoryBloc.state.categories[i])) {
          checkboxesCategories[i] = true;
        }
      }
      for (int i = 0; i < ingredientBloc.state.ingredients.length; i++) {
        if (args.item.categories
            .contains(ingredientBloc.state.ingredients[i])) {
          checkboxesIngredients[i] = true;
        }
      }
    }
    final List ingredientFixedList =
        Iterable<int>.generate(ingredientBloc.state.ingredients.length)
            .toList();
    final List categoryFixedList =
        Iterable<int>.generate(categoryBloc.state.categories.length).toList();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(args.edit ? 'Update Item' : "Add Item"),
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
                    initialValue: args.edit ? args.item.name : '',
                    decoration: InputDecoration(
                        hintText: 'Enter item name',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      String error = value.length < 3
                          ? "Item name should be at least 3 characters long"
                          : null;
                      return error;
                    },
                    onSaved: (value) {
                      setState(() {
                        _item['name'] = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: args.edit ? '${args.item.price}' : '',
                    decoration: InputDecoration(
                        hintText: 'Enter item price',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      String error = double.parse(value) <= 0.0
                          ? "Price should be greater than 0"
                          : null;
                      return error;
                    },
                    onSaved: (value) {
                      _item['price'] = double.parse(value);
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    initialValue: args.edit ? args.item.description : '',
                    decoration: InputDecoration(
                        hintText: 'Enter item description',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      String error = value.length < 5
                          ? "Description should be at least 5 characters long"
                          : null;
                      return error;
                    },
                    onSaved: (value) {
                      _item['description'] = value;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    child: Column(
                      children: [
                        categoryFixedList.length != 0
                            ? Text('Select Categories')
                            : Container(),
                        Column(
                          children: categoryFixedList
                              .map((idx) => CheckboxListTile(
                                    value: checkboxesCategories[idx],
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxesCategories[idx] = value;
                                      });
                                    },
                                  ))
                              .toList(),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ingredientFixedList.length != 0
                            ? Text('Select Ingredients')
                            : Container(),
                        Column(
                          children: ingredientFixedList
                              .map((idx) => CheckboxListTile(
                                    value: checkboxesIngredients[idx],
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxesIngredients[idx] = value;
                                      });
                                    },
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  picture != null
                      ? Image.file(
                          picture,
                          fit: BoxFit.cover,
                          height: 250.0,
                          width: double.infinity,
                        )
                      : args.edit && args.item.image != null
                          ? Image.network(
                              args.item.image,
                              fit: BoxFit.cover,
                              height: 250.0,
                              width: double.infinity,
                            )
                          : Container(
                              child: Text('Select food picture'),
                              alignment: Alignment.center,
                            ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        onPressed: () async {
                          _pickFile(ImageSource.camera);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt),
                            Text('Take Picture'),
                          ],
                        ),
                      ),
                      RaisedButton(
                        child: Row(
                          children: [
                            Icon(Icons.upload_outlined),
                            Text('Upload Picture'),
                          ],
                        ),
                        onPressed: () {
                          _pickFile(ImageSource.gallery);
                        },
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
                            // try {
                            if (picture != null) {
                              try {
                                UploadFileResult result =
                                    await Amplify.Storage.uploadFile(
                                        local: picture, key: _item['name']);
                                _item['image'] = (await Amplify.Storage.getUrl(
                                        key: result.key))
                                    .url
                                    .split('?')[0];
                                print(_item['image']);
                              } catch (e) {
                                setState(() {
                                  _isLoading = false;
                                });
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text('Connection failed. try again.'),
                                ));
                                print(e);
                              }
                            }
                            !args.edit
                                ? foodItemBloc.add(AddFoodItemEvent(
                                    foodItem: Item.fromJson(_item)))
                                : foodItemBloc.add(UpdateFoodItemEvent(
                                    foodItem: Item.fromJson(_item)));
                            if (foodItemBloc.state
                                is FoodItemsLoadFailedState) {
                              setState(() {
                                _isLoading = false;
                              });
                            } else if (foodItemBloc.state
                                is FoodItemLoadingState) {
                              setState(() {
                                _isLoading = true;
                              });
                            } else {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(args.edit
                                      ? 'Item updated successfully'
                                      : 'Item added successfully')));
                              foodItemBloc.add(LoadFoodItemsEvent());
                              Navigator.pop(context);
                            }
                            // } catch (e) {
                            //   print("error: $e");
                            //   setState(() {
                            //     _isLoading = false;
                            //   });
                            //   _scaffoldKey.currentState.showSnackBar(SnackBar(
                            //       content: Text(args.edit
                            //           ? 'Updating Item failed'
                            //           : 'Adding Item failed')));
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
    ingredientBloc?.close();
    categoryBloc?.close();
    super.dispose();
  }
}
