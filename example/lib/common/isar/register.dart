import 'package:example/cart_items/cart_item.model.dart';
import 'package:example/payments/payment.model.dart';
import 'package:example/products/product.model.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

@module
abstract class RegisterModule {
  Future<Isar> _getIsarInstance() async {
    final directory = await getApplicationSupportDirectory();
    return Isar.open([
      ProductSchema,
      CartItemSchema,
      PaymentSchema,
    ], directory: directory.path);
  }

  // @preResolve
  @lazySingleton
  Future<Isar> get isar => _getIsarInstance();
}
