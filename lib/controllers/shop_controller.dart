import 'package:get/get.dart';
import 'package:shoppingapp/models/product_model.dart';

class ShopController extends GetxController{
  var products = <ProductModel>[].obs;
  var checkoutProducts = <ProductModel>[].obs;
  var toBuyProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    products.add(ProductModel(id: "1", name: "Chicken wings", imageUrl: "assets/image/chicken_wings.jpg", price: 9));
    products.add(ProductModel(id: "2", name: "Pork ribs", imageUrl: "assets/image/pork_ribs.jpg", price: 9));
    products.add(ProductModel(id: "3", name: "Lasagna", imageUrl: "assets/image/lasagna.jpg", price: 6));
    products.add(ProductModel(id: "4", name: "Pizza", imageUrl: "assets/image/pizza.jpg", price: 12));
    products.add(ProductModel(id: "5", name: "Burger", imageUrl: "assets/image/burger.jpg", price: 10));
    products.add(ProductModel(id: "6", name: "French fries", imageUrl: "assets/image/fries.jpg", price: 3));
    products.add(ProductModel(id: "7", name: "French toast", imageUrl: "assets/image/ice_cream.jpg", price: 4));
    products.add(ProductModel(id: "8", name: "Ice cream", imageUrl: "assets/image/french_toast.jpg", price: 4));
    products.add(ProductModel(id: "9", name: "Pasta", imageUrl: "assets/image/pasta.jpg", price: 5));
    products.add(ProductModel(id: "10", name: "Tacos", imageUrl: "assets/image/tacos.jpg", price: 10));

  }
}