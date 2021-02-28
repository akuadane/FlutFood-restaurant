import 'package:flut_food_restaurant/models/models.dart';
import 'package:flut_food_restaurant/role/data_provider/role_data_provider.dart';
import 'dart:async';

import 'package:flut_food_restaurant/models/models.dart';
import 'package:flutter/foundation.dart';

class RoleRepository {
  final RoleDataProvider roleDataProvider;

  RoleRepository({@required this.roleDataProvider});

  Future<List<Role>> getRoles() {
    return roleDataProvider.getRoles();
  }

  Future<Role> getRole(int id) {
    return roleDataProvider.getRole(id);
  }

  Future<void> updateRole(Role cat) {
    return roleDataProvider.updateRole(cat);
  }

  Future<void> createRole(Role cat) {
    return roleDataProvider.createRole(cat);
  }

  Future<void> deleteRole(int id) {
    return roleDataProvider.deleteRole(id);
  }
}
