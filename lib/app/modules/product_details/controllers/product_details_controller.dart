import 'package:e_shoppy/app/components/custom_snackbar.dart';
import 'package:e_shoppy/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../utils/dummy_helper/dummy_helper.dart';
import '../../../data/models/product_model/product_model.dart';
import '../../base/controllers/base_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductDetailsController extends GetxController {
  // get product details from arguments
  ProductModel product = Get.arguments;

  // for the product size
  var selectedSize = 'M';

  /// when the user press on the favorite button
  onFavoriteButtonPressed() {
    BaseController.find.onFavoriteButtonPressed(productId: product.id ?? -1);
    update(['FavoriteButton']);
  }

  /// when the user press on add to cart button
  onAddToCartPressed() {
    var mProduct =
        HomeController.find.products.firstWhere((p) => p?.id == product.id);
    mProduct?.quantity = mProduct.quantity ?? 0 + 1;
    mProduct?.size = selectedSize;
    final isAdded = CartController.find.addToCart(mProduct);
    debugPrint(isAdded.toString());
    Get.back();
    CartController.find.getCartTotal();

    if (isAdded) {
      CustomSnackBar.showCustomSnackBar(
          title: 'Added', message: 'Item Added To Cart');
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error', message: 'item Already Exist In Cart');
    }
  }

  /// change the selected size
  changeSelectedSize(String size) {
    if (size == selectedSize) return;
    selectedSize = size;
    update(['Size']);
  }
}
