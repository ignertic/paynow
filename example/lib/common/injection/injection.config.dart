// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i8;
import 'package:logger/logger.dart' as _i9;
import 'package:paynow/paynow.dart' as _i10;

import '../../cart_items/cart_item.model.dart' as _i5;
import '../../cart_items/database/local_database.dart' as _i7;
import '../../cart_items/register.dart' as _i13;
import '../../payments/payment.model.dart' as _i6;
import '../../payments/register.dart' as _i14;
import '../../paynow/register.dart' as _i17;
import '../../products/database/local_database.dart' as _i11;
import '../../products/product.model.dart' as _i4;
import '../../products/register.dart' as _i12;
import '../component/base_bloc.dart' as _i3;
import '../isar/register.dart' as _i15;
import '../logger/register.dart'
    as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerProductsModule = _$RegisterProductsModule();
  final registerCartItemsModule = _$RegisterCartItemsModule();
  final registerPaymentsModule = _$RegisterPaymentsModule();
  final registerModule = _$RegisterModule();
  final registerLoggerModule = _$RegisterLoggerModule();
  final registerPaynowModule = _$RegisterPaynowModule();
  gh.factory<_i3.BaseBloc<_i4.Product>>(
      () => registerProductsModule.productsBloc);
  gh.factory<_i3.BaseBloc<_i5.CartItem>>(
      () => registerCartItemsModule.cartItemsBloc);
  gh.factory<_i3.BaseRepository<_i6.Payment>>(
      () => registerPaymentsModule.paymentsLocalDatabase);
  gh.factory<_i7.CartItemsLocalDatabaseService<_i5.CartItem>>(
      () => registerCartItemsModule.cartItemsLocalDatabase);
  gh.lazySingletonAsync<_i8.Isar>(() => registerModule.isar);
  gh.factory<_i8.IsarCollection<_i6.Payment>>(
      () => registerPaymentsModule.paymentsCollection);
  gh.factory<_i8.IsarCollection<_i4.Product>>(
      () => registerProductsModule.productsCollection);
  gh.factory<_i8.IsarCollection<_i5.CartItem>>(
      () => registerCartItemsModule.cartItemsCollection);
  gh.factory<_i9.Logger>(() => registerLoggerModule.logger);
  gh.factory<_i10.Paynow>(() => registerPaynowModule.paynow);
  gh.factory<_i11.ProductsLocalDatabaseService<_i4.Product>>(
      () => registerProductsModule.productsLocalDatabase);
  return get;
}

class _$RegisterProductsModule extends _i12.RegisterProductsModule {}

class _$RegisterCartItemsModule extends _i13.RegisterCartItemsModule {}

class _$RegisterPaymentsModule extends _i14.RegisterPaymentsModule {}

class _$RegisterModule extends _i15.RegisterModule {}

class _$RegisterLoggerModule extends _i16.RegisterLoggerModule {}

class _$RegisterPaynowModule extends _i17.RegisterPaynowModule {}
