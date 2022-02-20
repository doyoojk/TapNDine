import 'dart:developer';

import 'package:tpndine/models/restaurant.dart';
import 'package:tpndine/services/restaurant_service.dart';

class SiteViewModel {
  final RestaurantService _restaurantService = RestaurantService();

  Future<List<RestaurantModel>> getSiteList() async {
    // ignore: deprecated_member_use
    var value = await _restaurantService.request_nearby_sites();
    List<RestaurantModel> list = [];
    for (int i = 0; i < value['sites'].length; i++) {
      RestaurantModel restaurantModel = RestaurantModel();
      restaurantModel.siteName = value['sites'][i]['siteName'];
      restaurantModel.address = value['sites'][i]['address']['city'];
      restaurantModel.contact = value['sites'][i]['contact'].toString();
      restaurantModel.description = value['sites'][i]['description'];
      restaurantModel.status = value['sites'][i]['status'];
      list.add(restaurantModel);
    }
    log("THE LIST IS " + list.length.toString());
    return list;
  }
}
