import 'package:example/common/component/base_bloc.dart';
import 'package:isar/isar.dart';

part 'payment.model.g.dart';

@collection
class Payment extends BaseModel<Payment> {
  Id get isarId => fastHash(id!);
  String? redirectUrl;
  String? pollUrl;
  String? additionalInformation;
  String? status;
  String? instructions;
  String? error;
  String? reference;

  String? currency;

  late double total;

  String get stringifiedTotal => "$currency $total";

  @override
  Map<String, dynamic> metadata() {
    return {"collection": "payments", "databaseId": "paynow-db"};
  }

  @override
  Map<String, dynamic> mapLocalToRemote() {
    return {};
  }

  @override
  mapRemoteToLocal(Map<String, dynamic> data) {
    return Payment()
      ..id = data['\$id']
      ..createdAt = data['\$createdAt']
      ..updatedAt = data['\$updatedAt'];
  }
}
