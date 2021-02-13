import 'package:http/http.dart';
import 'package:flut_food_restaurant/food_item/model/models.dart';
import 'package:flut_food_restaurant/food_item/data_provider/food_item_data_provider.dart';

String baseUrl = "https://dry-wildwood-77069.herokuapp.com/v1/admin/";
final client = Client();

void main() async {
  await FoodItemDataProvider(client: client, baseUrl: baseUrl)
      .createItem(Item(
          name: 'Key wet',
          price: 45.0,
          description: "Amazing traditional ethiopian key wot",
          ingredients: [],
          image: 'avatar',
          categories: []));
  final List<Item> items =
      await FoodItemDataProvider(client: client, baseUrl: baseUrl)
          .getFoodItems();
  items.forEach(print);
  print(items);
}
