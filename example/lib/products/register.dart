// Importing necessary packages and files
import 'package:example/common/component/base_bloc.dart';
import 'package:example/common/injection/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

// Importing the model for 'Product'
import 'database/local_database.dart';
import 'product.model.dart';

// Using the @module annotation to declare a module
@module
abstract class RegisterProductsModule {
  // Defining a remote database repository for products using Appwrite
  // BaseRemoteDatabase<Product> get productsRemoteRepository =>
  //     BaseAppwriteDatabaseRepository<Product>(
  //         databaseId: 'paynow-db',
  //         collectionId: 'products',
  //         mapRemoteToLocal: Product().mapRemoteToLocal);

  // Defining a BLoC for managing product-related business logic
  BaseBloc<Product> get productsBloc =>
      BaseBloc(repository: productsLocalDatabase);

  // Accessing the Isar collection for products
  IsarCollection<Product> get productsCollection => getIt<Isar>().products;

  // Defining a local database for products
  ProductsLocalDatabaseService<Product> get productsLocalDatabase =>
      ProductsLocalDatabaseService<Product>();

  // Defining a synchronization service for products
  // BaseSyncService<Product> get productsSyncService => BaseSyncService(
  //     localRepository: productsLocalDatabase,
  //     remoteRepository: productsRemoteRepository);

  // Defining a database watcher for products using Appwrite
  // BaseDatabaseWatcher<Product> get watcher => AppwriteDatabaseWatcher<Product>(
  //     channels: ["databases.paynow-db.collections.products.documents"],
  //     mapRemoteToLocal: Product().mapRemoteToLocal,
  //     onRemoteUpdate: (product, action) async {
  //       final isar = getIt<Isar>();
  //       final actionMessage = action.split('.').last;

  //       // Handling different actions (create, update, delete)
  //       switch (actionMessage) {
  //         case 'delete':
  //           isar.writeTxn(() => productsCollection.delete(product.isarId));
  //           break;
  //         case 'create':
  //         case 'update':
  //           isar.writeTxn(() => productsCollection.put(product));
  //           break;
  //       }
  //     });
}
