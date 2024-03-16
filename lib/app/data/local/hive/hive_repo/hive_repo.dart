import 'package:e_shoppy/app/data/local/hive/hive_base_repository.dart';
import 'package:e_shoppy/app/data/models/product_model/product_model.dart';
import 'package:hive/hive.dart';

class HiveStorageRepo extends BaseLocalStorageRepository {
  HiveStorageRepo._();
  static HiveStorageRepo? _instance;
  factory HiveStorageRepo() => _instance ??= HiveStorageRepo._();
  String boxName = 'e_shoppy_box';
  String boxCategory = 'e_shoppy_collection';

  Type boxType = List<ProductModel>;

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<ProductModel>(boxName);

    return box;
  }

  @override
  Future<void> clearBox(Box box) async {
    await box.clear();
  }

  @override
  Future<List<ProductModel>?> getCartItems() async {
    final box = await openBox();

    return box.values.toList() as List<ProductModel>?;
  }

  @override
  Future<List<ProductModel>?> addtoCart(
      List<ProductModel>? listCategory) async {
    final box = await openBox();
    final model = box.values as List<ProductModel>?;
    await box.addAll(listCategory?.map((e) => e.toJson()) ?? {});
    return model;
  }

  @override
  Future<List<ProductModel>?> addSingleProduct(
      ProductModel? hiveCategory) async {
    try {
      final box = await openBox();
      await box.put(hiveCategory?.id.toString(), hiveCategory);

      return box.values.toList() as List<ProductModel>;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> deleteProduct(String hiveId) async {
    try {
      final box = await openBox();
      await box
          .delete(
            hiveId,
          )
          .whenComplete(() => true);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateProduct(ProductModel? product) async {
    try {
      final box = await openBox();
      await box.put(product?.id.toString(), product);
      return true;
    } catch (e) {
      return false;
    }
  }
}
