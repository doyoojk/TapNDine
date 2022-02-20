import 'package:tpndine/services/cart_service.dart';

class CartViewModel {
  CartService cartService = CartService();

  void createUploadMap(List<String> orders) {
    Map<String, dynamic> newMap = {"items": orders, "table": 3};
    cartService.uploadCartFirestore(newMap);
  }
}
