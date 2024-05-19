import 'package:example/common/component/base_bloc.dart';
import 'package:isar/isar.dart';

part 'product.model.g.dart';

@collection
class Product extends BaseModel<Product> {
  Id get isarId => fastHash(id!);

  // All required fields are marked late
  late String title;
  late double price;
  late String description;
  String? imageUrl;
  String? currency;
  String get stringifiedTotal => "$currency $price";

  @override
  Map<String, dynamic> metadata() {
    return {"collection": "products", "databaseId": "paynow-db"};
  }

  @override
  Map<String, dynamic> mapLocalToRemote() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  @override
  mapRemoteToLocal(Map<String, dynamic> data) {
    return Product()
      ..id = data['\$id']
      ..title = data['title']
      ..description = data['description']
      ..price = data['price']
      ..imageUrl = data['imageUrl']
      ..createdAt = data['\$createdAt']
      ..updatedAt = data['\$updatedAt'];
  }
}
