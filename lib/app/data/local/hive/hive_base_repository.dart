import 'package:e_shoppy/app/data/models/product_model/product_model.dart';
import 'package:hive/hive.dart';

abstract class BaseLocalStorageRepository {
  Future<Box?> openBox();
  Future<List<ProductModel>?> getCartItems();
  Future<List<ProductModel>?> addSingleProduct(ProductModel hiveCategory);
  Future<List<ProductModel>?> addtoCart(List<ProductModel>? listCategory);
  Future<bool> deleteProduct(String hiveId);
  Future<void> clearBox(Box box);
  Future<bool> updateProduct(ProductModel? product);
}
