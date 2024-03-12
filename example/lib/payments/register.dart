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
  // Defining a remote database repository for payments using Appwrite
  // BaseRemoteDatabase<Payment> get paymentsRemoteRepository =>
  //     BaseAppwriteDatabaseRepository<Payment>(
  //         databaseId: 'paynow-db',
  //         collectionId: 'payments',
  //         mapRemoteToLocal: Payment().mapRemoteToLocal);

  // Defining a BLoC for managing payment-related business logic
  // BaseBloc<Payment> get paymentsBloc =>
  //     BaseBloc(repository: paymentsRemoteRepository);

  // Accessing the Isar collection for payments
  IsarCollection<Payment> get paymentsCollection => getIt<Isar>().payments;

  // Defining a local database for payments
  BaseRepository<Payment> get paymentsLocalDatabase =>
      PaymentsLocalDatabaseService<Payment>();

  // Defining a synchronization service for payments
  // BaseSyncService<Payment> get paymentsSyncService => BaseSyncService(
  //     localRepository: paymentsLocalDatabase,
  //     remoteRepository: paymentsRemoteRepository);

  // Defining a database watcher for payments using Appwrite
  // BaseDatabaseWatcher<Payment> get watcher => AppwriteDatabaseWatcher<Payment>(
  //     channels: ["databases.paynow-db.collections.payments.documents"],
  //     mapRemoteToLocal: Payment().mapRemoteToLocal,
  //     onRemoteUpdate: (payment, action) async {
  //       final isar = getIt<Isar>();
  //       final actionMessage = action.split('.').last;

  //       // Handling different actions (create, update, delete)
  //       switch (actionMessage) {
  //         case 'delete':
  //           isar.writeTxn(() => paymentsCollection.delete(payment.isarId));
  //           break;
  //         case 'create':
  //         case 'update':
  //           isar.writeTxn(() => paymentsCollection.put(payment));
  //           break;
  //       }
  //     });
}
