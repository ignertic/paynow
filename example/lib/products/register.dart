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
  // Defining a BLoC for managing product-related business logic
  BaseBloc<Product> get productsBloc =>
      BaseBloc(repository: productsLocalDatabase);

  // Accessing the Isar collection for products
  IsarCollection<Product> get productsCollection => getIt<Isar>().products;

  // Defining a local database for products
  BaseRepository<Product> get productsLocalDatabase =>
      ProductsLocalDatabaseService<Product>();
}
