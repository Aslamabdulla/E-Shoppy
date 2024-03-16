import 'package:e_shoppy/app/components/custom_snackbar.dart';
import 'package:e_shoppy/app/data/models/product_model/product_model.dart';
import 'package:e_shoppy/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_shoppy/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../utils/dummy_helper/dummy_helper.dart';
import '../../favorites/controllers/favorites_controller.dart';

class BaseController extends GetxController {
  static BaseController get find => Get.find();
  // current screen index

  List<ProductModel?> products = [];
  int currentIndex = 0;

  /// change the selected screen index
  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }

  /// when the user press on the favorite button in the product
  onFavoriteButtonPressed({required int productId}) {
    var product = HomeController.find.products
        .firstWhere((product) => product?.id == productId);
    if (product?.isfavourite ?? false) {
      // remove product from favorites
      product?.isfavourite = false;
      Get.find<FavoritesController>().getFavoriteProducts();
    } else {
      // add product to favorites
      product?.isfavourite = true;
      Get.find<FavoritesController>().getFavoriteProducts();
    }
    update(['FavoriteButton']);
  }

  onAddToCartPressed(ProductModel? product) {
    var mProduct =
        HomeController.find.products.firstWhere((p) => p?.id == product?.id);
    mProduct?.quantity = mProduct.quantity ?? 0 + 1;

    final isAdded = CartController.find.addToCart(mProduct);

    Get.back();
    CartController.find.getCartTotal();

    if (isAdded) {
      CustomSnackBar.showCustomSnackBar(title: 'Added', message: 'item Added');
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error', message: 'item Already Exist In Cart');
    }
  }
}
