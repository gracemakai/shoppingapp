import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/shop_controller.dart';
import '../models/product_model.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final ShopController _shopController = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        int total = 0;
        for (var i = 0; i < _shopController.toBuyProducts.length; i++) {
          total =
              total + _shopController.toBuyProducts.elementAt(i).price!;
        }
        return _shopController.checkoutProducts.isNotEmpty
            ? SingleChildScrollView(
              child: Column(
                  children: [
                    SizedBox(height: 0.03.sh,),
                    ListView.builder(
                      itemCount: _shopController.checkoutProducts.length,
                      shrinkWrap: true,

                      itemBuilder: (context, index) {
                        ProductModel product = _shopController
                            .checkoutProducts
                            .elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(() {
                                  return Radio(
                                      value: _shopController.toBuyProducts
                                      .indexWhere((element) => element.id == product.id) == -1,
                                      toggleable: true,
                                      groupValue: false, onChanged: (value) {

                                    if (_shopController.toBuyProducts
                                        .indexWhere((element) => element.id == product.id) == -1) {
                                      _shopController.toBuyProducts.add(product);
                                    }  else {
                                      _shopController.toBuyProducts
                                          .removeWhere((element) => element.id == product.id);
                                    }
                                    _shopController.toBuyProducts.refresh();
                                  });
                                }
                              ),
                              Container(
                                  padding: const EdgeInsets.all(5.0),
                                  width: 0.8.sw,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
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
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          product.imageUrl.toString(),
                                          width: 0.35.sw,
                                          height: 0.15.sh,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(width: 0.03.sw,),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.sp),
                                              ),
                                              SizedBox(height: 0.01.sh,),
                                              Text(
                                                "\$ ${product.price.toString()}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.sp, fontWeight: FontWeight.bold),
                                              ),

                                            ],
                                          ),
                                          SizedBox(height: 0.05.sh,),
                                          Align(

                                            child: InkWell(
                                              onTap: () {
                                                if (_shopController
                                                    .checkoutProducts
                                                    .indexWhere(
                                                        (element) =>
                                                    element.id ==
                                                        product.id) !=
                                                    -1) {
                                                  _shopController
                                                      .checkoutProducts
                                                      .removeWhere(
                                                          (element) =>
                                                      element.id ==
                                                          product.id);
                                                }

                                                _shopController
                                                    .checkoutProducts
                                                    .refresh();
                                                GetSnackBar(
                                                  duration:
                                                  const Duration(seconds: 5),
                                                  messageText: Text(
                                                      "${product.name} has been removed from your cart",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      )),
                                                  backgroundColor:
                                                  Colors.black,
                                                ).show();
                                              },
                                              child: Container(
                                                width: 0.35.sw,
                                                height: 0.03.sh,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                    color: Colors.green,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: const Offset(0, 3), // changes position of shadow
                                                      ),
                                                    ]),
                                                child: Center(
                                                  child: Text(
                                                    "Remove from cart",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.bottomCenter,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text("Total",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.sp)),
                          Text("\$ $total",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {

                        if (_shopController.toBuyProducts.isNotEmpty) {
                          for (var i = 0; i <
                              _shopController.toBuyProducts.length; i++) {
                            _shopController.checkoutProducts
                                .removeWhere((element) =>
                            element.id == _shopController.toBuyProducts
                                .elementAt(i)
                                .id);
                          }

                          _shopController.toBuyProducts.value = [];

                          showDialog(context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10)),
                                  title: Center(
                                    child: Text("Success",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,)),
                                  ),
                                  content: Text(
                                    "You have successfully checked out.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,),
                                  ),
                                  actions: [
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          Get.back();
                                          Get.back();
                                        },
                                        child: Container(
                                          width: 0.2.sw,
                                          height: 0.04.sh,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              color: Colors.green,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: const Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ]),
                                          child: Center(
                                            child: Text("Okay",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,)
                                            ),
                                          ),
                                        ),

                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        width: 0.9.sw,
                        height: 0.07.sh,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _shopController.toBuyProducts.isNotEmpty ? Colors.green : Colors.grey,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Center(
                          child: Text("Checkout".capitalize!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              )),
                        ),
                      ),

                    )
                  ],
                ),
            )
            : SizedBox(
                height: 0.5.sh,
                child: Center(
                  child: Text("No items in cart",
                      style: TextStyle(
                          color: Colors.black, fontSize: 14.sp)),
                ),
              );
      }),
    );
  }
}
