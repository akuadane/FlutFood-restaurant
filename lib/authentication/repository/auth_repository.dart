import 'package:flut_food_restaurant/authentication/data_provider/auth_data_provider.dart';
import 'package:flut_food_restaurant/models/models.dart';

class AuthDataRepository {
  final AuthDataProvider dataProvider;

  AuthDataRepository({this.dataProvider});

  User getUser()  {
    return dataProvider.getUser();
  }

  Future<void> storeUser(User user) async {
    return dataProvider.storeUser(user);
  }
}
