import 'package:example/common/component/base_bloc.dart';
import 'package:isar/isar.dart';

part 'cart_item.model.g.dart';

@collection
class CartItem extends BaseModel<CartItem> {
  Id get isarId => fastHash(id!);
  late String product$id;
  late int quantity;
  double? price;
  String? currency;
  String get stringifiedTotal => "$currency $price";

  @override
  Map<String, dynamic> metadata() {
    return {"collection": "cart_items", "databaseId": "paynow-db"};
  }

  @override
  Map<String, dynamic> mapLocalToRemote() {
    return {};
  }

  @override
  mapRemoteToLocal(Map<String, dynamic> data) {
    return CartItem()
      ..id = data['\$id']
      ..createdAt = data['\$createdAt']
      ..updatedAt = data['\$updatedAt'];
  }
}

extension CalculateSingleItemTotal on CartItem {
  double _getTotal() {
    return double.parse((quantity * (price ?? 0.0)).toStringAsFixed(2));
  }

  double get total => _getTotal();
}

extension CalculateTotal on List<CartItem> {
  double _getTotal() {
    return double.parse(
        fold(0.0, (previousValue, element) => previousValue + element.total)
            .toStringAsFixed(2));
  }

  double get total => _getTotal();

  String _getStringifiedTotal() {
    try {
      return "${first.currency} $total";
    } catch (e) {
      return "0";
    }
  }

  String get stringifiedTotal => _getStringifiedTotal();
}
