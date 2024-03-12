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
  // Defining a remote database repository for cartItems using Appwrite
  // BaseRemoteDatabase<CartItem> get cartItemsRemoteRepository =>
  //     BaseAppwriteDatabaseRepository<CartItem>(
  //         databaseId: 'paynow-db',
  //         collectionId: 'cart_items',
  //         mapRemoteToLocal: CartItem().mapRemoteToLocal);

  // Defining a BLoC for managing cartItem-related business logic
  BaseBloc<CartItem> get cartItemsBloc =>
      BaseBloc(repository: cartItemsLocalDatabase);

  // Accessing the Isar collection for cartItems
  IsarCollection<CartItem> get cartItemsCollection => getIt<Isar>().cartItems;

  // Defining a local database for cartItems
  CartItemsLocalDatabaseService<CartItem> get cartItemsLocalDatabase =>
      CartItemsLocalDatabaseService<CartItem>();

  // Defining a synchronization service for cartItems
  // BaseSyncService<CartItem> get cartItemsSyncService => BaseSyncService(
  //     localRepository: cartItemsLocalDatabase,
  //     remoteRepository: cartItemsRemoteRepository);

  // Defining a database watcher for cartItems using Appwrite
  // BaseDatabaseWatcher<CartItem> get watcher => AppwriteDatabaseWatcher<CartItem>(
  //     channels: ["databases.paynow-db.collections.cart_items.documents"],
  //     mapRemoteToLocal: CartItem().mapRemoteToLocal,
  //     onRemoteUpdate: (cartItem, action) async {
  //       final isar = getIt<Isar>();
  //       final actionMessage = action.split('.').last;

  //       // Handling different actions (create, update, delete)
  //       switch (actionMessage) {
  //         case 'delete':
  //           isar.writeTxn(() => cartItemsCollection.delete(cartItem.isarId));
  //           break;
  //         case 'create':
  //         case 'update':
  //           isar.writeTxn(() => cartItemsCollection.put(cartItem));
  //           break;
  //       }
  //     });
}
