// Importing necessary packages and files

import 'package:example/common/component/base_bloc.dart';
import 'package:example/common/injection/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

// Importing the model for 'CartItem'
import 'database/local_database.dart';
import 'cart_item.model.dart';

// Using the @module annotation to declare a module
@module
abstract class RegisterCartItemsModule {
  // Defining a BLoC for managing cartItem-related business logic
  BaseBloc<CartItem> get cartItemsBloc =>
      BaseBloc(repository: cartItemsLocalDatabase);

  // Accessing the Isar collection for cartItems
  IsarCollection<CartItem> get cartItemsCollection => getIt<Isar>().cartItems;

  // Defining a local database for cartItems
  BaseRepository<CartItem> get cartItemsLocalDatabase =>
      CartItemsLocalDatabaseService<CartItem>();
}
