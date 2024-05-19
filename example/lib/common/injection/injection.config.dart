// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i7;
import 'package:logger/logger.dart' as _i8;
import 'package:paynow/paynow.dart' as _i9;

import '../../cart_items/cart_item.model.dart' as _i5;
import '../../cart_items/register.dart' as _i11;
import '../../payments/payment.model.dart' as _i6;
import '../../payments/register.dart' as _i12;
import '../../paynow/register.dart' as _i15;
import '../../products/product.model.dart' as _i4;
import '../../products/register.dart' as _i10;
import '../component/base_bloc.dart' as _i3;
import '../isar/register.dart' as _i13;
import '../logger/register.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.BaseRepository<_i4.Product>>(
      () => registerProductsModule.productsLocalDatabase);
  gh.factory<_i3.BaseRepository<_i5.CartItem>>(
      () => registerCartItemsModule.cartItemsLocalDatabase);
  gh.lazySingletonAsync<_i7.Isar>(() => registerModule.isar);
  gh.factory<_i7.IsarCollection<_i6.Payment>>(
      () => registerPaymentsModule.paymentsCollection);
  gh.factory<_i7.IsarCollection<_i4.Product>>(
      () => registerProductsModule.productsCollection);
  gh.factory<_i7.IsarCollection<_i5.CartItem>>(
      () => registerCartItemsModule.cartItemsCollection);
  gh.factory<_i8.Logger>(() => registerLoggerModule.logger);
  gh.factory<_i9.Paynow>(() => registerPaynowModule.paynow);
  return get;
}

class _$RegisterProductsModule extends _i10.RegisterProductsModule {}

class _$RegisterCartItemsModule extends _i11.RegisterCartItemsModule {}

class _$RegisterPaymentsModule extends _i12.RegisterPaymentsModule {}

class _$RegisterModule extends _i13.RegisterModule {}

class _$RegisterLoggerModule extends _i14.RegisterLoggerModule {}

class _$RegisterPaynowModule extends _i15.RegisterPaynowModule {}
