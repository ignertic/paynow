import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

@module
abstract class RegisterModule {
  Future<Isar> _getIsarInstance() async {
    final directory = await getApplicationSupportDirectory();
    return Isar.open([
      MemberSchema,
      DependentSchema,
      NotificationSchema,
      LocalUserSchema,
      GlobalConfigurationSchema,
      MemberAccountSchema,
      MemberAccountEventSchema,
      CurrencySchema,
      ServiceProviderSchema,
      LoyaltyPointSchema,
      TownSchema,
      ServiceProviderCategorySchema,
      ServiceProviderAddressSchema,
      LocalFileSchema
    ], directory: directory.path);
  }

  // @preResolve
  @lazySingleton
  Future<Isar> get isar => _getIsarInstance();
}
