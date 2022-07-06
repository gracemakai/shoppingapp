import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoppingapp/controllers/shop_controller.dart';
import 'package:shoppingapp/models/product_model.dart';
import 'package:shoppingapp/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final ShopController _shopController = Get.put<ShopController>(ShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shop",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          Obx((){
              return InkWell(
                  onTap: () {
                    Get.to(() => CartScreen());
                  },
                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          height: 0.02.sh,
                          width: 0.05.sw,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: Text(
                                _shopController.checkoutProducts.length.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 10.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ));
            }
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              itemCount: _shopController.products.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                ProductModel product = _shopController.products.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.all(5.0),
                      width: 0.4.sw,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  const Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        children: [
                          Image.asset(
                            product.imageUrl.toString(),
                            width: 0.4.sw,
                            height: 0.15.sh,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            product.name.toString(),
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ ${product.price.toString()}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.sp),
                              ),
                              InkWell(
                                onTap: () {
                                  if(_shopController.checkoutProducts
                                      .indexWhere((element) => element.id == product.id) == -1) {
                                    _shopController.checkoutProducts.add(product);
                                  }

                                  GetSnackBar(duration: Duration(seconds: 5),
                                    messageText: Text("${product.name} has been added to your cart",
                                        style:
                                        TextStyle(color: Colors.white,)),
                                    backgroundColor: Colors.black,
                                  ).show();
                                },
                                child: Container(
                                  width: 0.25.sw,
                                  height: 0.03.sh,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.shopping_cart,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 0.01.sw,
                                      ),
                                      Text(
                                        "Add to cart",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
