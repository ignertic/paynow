// Importing necessary packages and files
import 'package:example/common/component/base_bloc.dart';
import 'package:example/common/injection/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

// Importing the model for 'Payment'
import 'database/local_database.dart';
import 'payment.model.dart';

// Using the @module annotation to declare a module
@module
abstract class RegisterPaymentsModule {
  // Accessing the Isar collection for payments
  IsarCollection<Payment> get paymentsCollection => getIt<Isar>().payments;

  // Defining a local database for payments
  BaseRepository<Payment> get paymentsLocalDatabase =>
      PaymentsLocalDatabaseService<Payment>();
}
