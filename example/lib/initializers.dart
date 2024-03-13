import 'package:example/products/product.model.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import 'common/injection/injection.dart';

void populateDummyProductsData() async {
  // wait for isar to be ready first
  await getIt.isReady<Isar>();

  final List<Map<String, dynamic>> productsRawData = [
    {
      'title': "Platinum Service",
      "price": 4999.99,
      "description": "Unlock comprehensive access.",
      "imageUrl": "https://avatars.githubusercontent.com/u/60399578?s=200&v=4"
    },
    {
      "title": "Gold Service",
      "price": 4000.50,
      "description": "Experience superior features.",
      "imageUrl": "https://avatars.githubusercontent.com/u/60399578?s=200&v=4"
    },
    {
      "title": "Silver Service",
      "price": 3000.50,
      "description": "Enjoy enhanced privileges.",
      "imageUrl": "https://avatars.githubusercontent.com/u/60399578?s=200&v=4"
    },
    {
      "title": "Bronze Service",
      "price": 2000.50,
      "description": "Access an advanced level of expertise.",
      "imageUrl": "https://avatars.githubusercontent.com/u/60399578?s=200&v=4"
    }
  ];

  final isar = getIt<Isar>();
  final existingProducts = await isar.products.filter().idIsNotNull().findAll();

  if (existingProducts.isEmpty) {
    // create new products
    for (final productRawData in productsRawData) {
      final newProduct = Product()
        ..id = const Uuid().v1()
        ..title = productRawData['title']
        ..description = productRawData['description']
        ..price = productRawData['price']
        ..imageUrl = productRawData['imageUrl']
        ..currency = 'ZWL';
      isar.writeTxn(() => isar.products.put(newProduct));
    }
  }
}
