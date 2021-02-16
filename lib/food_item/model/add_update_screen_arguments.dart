import 'package:flut_food_restaurant/food_item/model/models.dart';

class AddUpdateScreenArgument {
  final Item item;
  final bool edit;

  AddUpdateScreenArgument({this.item, this.edit = false});
}
