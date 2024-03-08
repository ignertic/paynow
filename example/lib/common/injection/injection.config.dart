// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:appwrite/appwrite.dart' as _i3;
import 'package:dio/dio.dart' as _i24;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i25;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i27;
import 'package:logger/logger.dart' as _i29;

import '../../currencys/currency.model.dart' as _i9;
import '../../currencys/database/local_database.dart' as _i22;
import '../../currencys/register.dart' as _i45;
import '../../dependents/database/local_database.dart' as _i23;
import '../../dependents/dependent.model.dart' as _i12;
import '../../dependents/register.dart' as _i48;
import '../../global_configurations/database/local_database.dart' as _i26;
import '../../global_configurations/global_configuration.model.dart' as _i7;
import '../../global_configurations/register.dart' as _i43;
import '../../local_files/database/local_database.dart' as _i28;
import '../../local_files/file_watcher.dart' as _i40;
import '../../local_files/local_file.model.dart' as _i6;
import '../../local_files/register.dart' as _i42;
import '../../loyalty_points/database/local_database.dart' as _i30;
import '../../loyalty_points/loyalty_point.model.dart' as _i15;
import '../../loyalty_points/register.dart' as _i51;
import '../../member_account_events/database/local_database.dart' as _i31;
import '../../member_account_events/member_account_event.model.dart' as _i18;
import '../../member_account_events/register.dart' as _i54;
import '../../member_accounts/database/local_database.dart' as _i32;
import '../../member_accounts/member_account.model.dart' as _i13;
import '../../member_accounts/register.dart' as _i49;
import '../../members/database/local_database.dart' as _i33;
import '../../members/member.model.dart' as _i16;
import '../../members/register.dart' as _i52;
import '../../notifications/database/local_database.dart' as _i34;
import '../../notifications/notification.model.dart' as _i17;
import '../../notifications/register.dart' as _i53;
import '../../service_provider_addresss/database/local_database.dart' as _i35;
import '../../service_provider_addresss/register.dart' as _i47;
import '../../service_provider_addresss/service_provider_address.model.dart'
    as _i11;
import '../../service_provider_categorys/database/local_database.dart' as _i36;
import '../../service_provider_categorys/register.dart' as _i44;
import '../../service_provider_categorys/service_provider_category.model.dart'
    as _i8;
import '../../service_providers/database/local_database.dart' as _i37;
import '../../service_providers/register.dart' as _i46;
import '../../service_providers/service_provider.model.dart' as _i10;
import '../../towns/database/local_database.dart' as _i38;
import '../../towns/register.dart' as _i50;
import '../../towns/town.model.dart' as _i14;
import '../appwrite/register.dart' as _i41;
import '../authentication/bloc/authentication.bloc.dart' as _i39;
import '../component/base_bloc.dart' as _i5;
import '../component/base_database_watcher.dart' as _i19;
import '../component/base_remote_database.dart' as _i20;
import '../component/base_sync_service.dart' as _i21;
import '../dio/register.dart' as _i55;
import '../isar/register.dart' as _i56;
import '../logger/register.dart' as _i57;
import '../navigation/guards/authentication.guard.dart' as _i4;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerAppwriteModule = _$RegisterAppwriteModule();
  final registerLocalFilesModule = _$RegisterLocalFilesModule();
  final registerGlobalConfigurationsModule =
      _$RegisterGlobalConfigurationsModule();
  final registerServiceProviderCategorysModule =
      _$RegisterServiceProviderCategorysModule();
  final registerCurrencysModule = _$RegisterCurrencysModule();
  final registerServiceProvidersModule = _$RegisterServiceProvidersModule();
  final registerServiceProviderAddresssModule =
      _$RegisterServiceProviderAddresssModule();
  final registerDependentsModule = _$RegisterDependentsModule();
  final registerMemberAccountsModule = _$RegisterMemberAccountsModule();
  final registerTownsModule = _$RegisterTownsModule();
  final registerLoyaltyPointsModule = _$RegisterLoyaltyPointsModule();
  final registerMembersModule = _$RegisterMembersModule();
  final registerNotificationsModule = _$RegisterNotificationsModule();
  final registerMemberAccountEventsModule =
      _$RegisterMemberAccountEventsModule();
  final dioModule = _$DioModule();
  final registerModule = _$RegisterModule();
  final registerLoggerModule = _$RegisterLoggerModule();
  gh.factory<_i3.Account>(() => registerAppwriteModule.account);
  gh.singleton<_i4.AuthenticationGuard>(_i4.AuthenticationGuard());
  gh.factory<_i5.BaseBloc<_i6.LocalFile>>(
      () => registerLocalFilesModule.localFilesBloc);
  gh.factory<_i5.BaseBloc<_i7.GlobalConfiguration>>(
      () => registerGlobalConfigurationsModule.globalConfigurationsBloc);
  gh.factory<_i5.BaseBloc<_i8.ServiceProviderCategory>>(() =>
      registerServiceProviderCategorysModule.serviceProviderCategorysBloc);
  gh.factory<_i5.BaseBloc<_i9.Currency>>(
      () => registerCurrencysModule.currencysBloc);
  gh.factory<_i5.BaseBloc<_i10.ServiceProvider>>(
      () => registerServiceProvidersModule.serviceProvidersBloc);
  gh.factory<_i5.BaseBloc<_i11.ServiceProviderAddress>>(
      () => registerServiceProviderAddresssModule.serviceProviderAddresssBloc);
  gh.factory<_i5.BaseBloc<_i12.Dependent>>(
      () => registerDependentsModule.dependentsBloc);
  gh.factory<_i5.BaseBloc<_i13.MemberAccount>>(
      () => registerMemberAccountsModule.memberAccountsBloc);
  gh.factory<_i5.BaseBloc<_i14.Town>>(() => registerTownsModule.townsBloc);
  gh.factory<_i5.BaseBloc<_i15.LoyaltyPoint>>(
      () => registerLoyaltyPointsModule.loyaltyPointsBloc);
  gh.factory<_i5.BaseBloc<_i16.Member>>(
      () => registerMembersModule.membersBloc);
  gh.factory<_i5.BaseBloc<_i17.Notification>>(
      () => registerNotificationsModule.notificationsBloc);
  gh.factory<_i5.BaseBloc<_i18.MemberAccountEvent>>(
      () => registerMemberAccountEventsModule.memberAccountEventsBloc);
  gh.factory<_i19.BaseDatabaseWatcher<_i16.Member>>(
      () => registerMembersModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i12.Dependent>>(
      () => registerDependentsModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i14.Town>>(
      () => registerTownsModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i17.Notification>>(
      () => registerNotificationsModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i10.ServiceProvider>>(
      () => registerServiceProvidersModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i9.Currency>>(
      () => registerCurrencysModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i13.MemberAccount>>(
      () => registerMemberAccountsModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i11.ServiceProviderAddress>>(
      () => registerServiceProviderAddresssModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i8.ServiceProviderCategory>>(
      () => registerServiceProviderCategorysModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i7.GlobalConfiguration>>(
      () => registerGlobalConfigurationsModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i18.MemberAccountEvent>>(
      () => registerMemberAccountEventsModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i6.LocalFile>>(
      () => registerLocalFilesModule.watcher);
  gh.factory<_i19.BaseDatabaseWatcher<_i15.LoyaltyPoint>>(
      () => registerLoyaltyPointsModule.watcher);
  gh.factory<_i20.BaseRemoteDatabase<_i15.LoyaltyPoint>>(
      () => registerLoyaltyPointsModule.loyaltyPointsRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i17.Notification>>(
      () => registerNotificationsModule.notificationsRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i13.MemberAccount>>(
      () => registerMemberAccountsModule.memberAccountsRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i14.Town>>(
      () => registerTownsModule.townsRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i8.ServiceProviderCategory>>(() =>
      registerServiceProviderCategorysModule
          .serviceProviderCategorysRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i12.Dependent>>(
      () => registerDependentsModule.dependentsRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i7.GlobalConfiguration>>(() =>
      registerGlobalConfigurationsModule.globalConfigurationsRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i16.Member>>(
      () => registerMembersModule.membersRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i18.MemberAccountEvent>>(() =>
      registerMemberAccountEventsModule.memberAccountEventsRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i10.ServiceProvider>>(
      () => registerServiceProvidersModule.serviceProvidersRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i11.ServiceProviderAddress>>(() =>
      registerServiceProviderAddresssModule
          .serviceProviderAddresssRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i6.LocalFile>>(
      () => registerLocalFilesModule.localFilesRemoteRepository);
  gh.factory<_i20.BaseRemoteDatabase<_i9.Currency>>(
      () => registerCurrencysModule.currencysRemoteRepository);
  gh.factory<_i21.BaseSyncService<_i18.MemberAccountEvent>>(
      () => registerMemberAccountEventsModule.memberAccountEventsSyncService);
  gh.factory<_i21.BaseSyncService<_i7.GlobalConfiguration>>(
      () => registerGlobalConfigurationsModule.globalConfigurationsSyncService);
  gh.factory<_i21.BaseSyncService<_i13.MemberAccount>>(
      () => registerMemberAccountsModule.memberAccountsSyncService);
  gh.factory<_i21.BaseSyncService<_i17.Notification>>(
      () => registerNotificationsModule.notificationsSyncService);
  gh.factory<_i21.BaseSyncService<_i14.Town>>(
      () => registerTownsModule.townsSyncService);
  gh.factory<_i21.BaseSyncService<_i11.ServiceProviderAddress>>(() =>
      registerServiceProviderAddresssModule.serviceProviderAddresssSyncService);
  gh.factory<_i21.BaseSyncService<_i6.LocalFile>>(
      () => registerLocalFilesModule.localFilesSyncService);
  gh.factory<_i21.BaseSyncService<_i9.Currency>>(
      () => registerCurrencysModule.currencysSyncService);
  gh.factory<_i21.BaseSyncService<_i15.LoyaltyPoint>>(
      () => registerLoyaltyPointsModule.loyaltyPointsSyncService);
  gh.factory<_i21.BaseSyncService<_i10.ServiceProvider>>(
      () => registerServiceProvidersModule.serviceProvidersSyncService);
  gh.factory<_i21.BaseSyncService<_i12.Dependent>>(
      () => registerDependentsModule.dependentsSyncService);
  gh.factory<_i21.BaseSyncService<_i8.ServiceProviderCategory>>(() =>
      registerServiceProviderCategorysModule
          .serviceProviderCategorysSyncService);
  gh.factory<_i21.BaseSyncService<_i16.Member>>(
      () => registerMembersModule.membersSyncService);
  gh.factory<_i3.Client>(() => registerAppwriteModule.client);
  gh.factory<_i22.CurrencysLocalDatabaseService<_i9.Currency>>(
      () => registerCurrencysModule.currencysLocalDatabase);
  gh.factory<_i3.Databases>(() => registerAppwriteModule.database);
  gh.factory<_i23.DependentsLocalDatabaseService<_i12.Dependent>>(
      () => registerDependentsModule.dependentsLocalDatabase);
  await gh.factoryAsync<_i24.Dio>(
    () => dioModule.dio,
    preResolve: true,
  );
  gh.lazySingleton<_i25.FlutterSecureStorage>(() => dioModule.storage);
  gh.factory<_i3.Functions>(() => registerAppwriteModule.functions);
  gh.factory<
          _i26
          .GlobalConfigurationsLocalDatabaseService<_i7.GlobalConfiguration>>(
      () =>
          registerGlobalConfigurationsModule.globalConfigurationsLocalDatabase);
  gh.factory<_i3.Graphql>(() => registerAppwriteModule.graphql);
  gh.lazySingletonAsync<_i27.Isar>(() => registerModule.isar);
  gh.factory<_i27.IsarCollection<_i11.ServiceProviderAddress>>(() =>
      registerServiceProviderAddresssModule.serviceProviderAddresssCollection);
  gh.factory<_i27.IsarCollection<_i15.LoyaltyPoint>>(
      () => registerLoyaltyPointsModule.loyaltyPointsCollection);
  gh.factory<_i27.IsarCollection<_i14.Town>>(
      () => registerTownsModule.townsCollection);
  gh.factory<_i27.IsarCollection<_i13.MemberAccount>>(
      () => registerMemberAccountsModule.memberAccountsCollection);
  gh.factory<_i27.IsarCollection<_i6.LocalFile>>(
      () => registerLocalFilesModule.localFilesCollection);
  gh.factory<_i27.IsarCollection<_i8.ServiceProviderCategory>>(() =>
      registerServiceProviderCategorysModule
          .serviceProviderCategorysCollection);
  gh.factory<_i27.IsarCollection<_i10.ServiceProvider>>(
      () => registerServiceProvidersModule.serviceProvidersCollection);
  gh.factory<_i27.IsarCollection<_i9.Currency>>(
      () => registerCurrencysModule.currencysCollection);
  gh.factory<_i27.IsarCollection<_i16.Member>>(
      () => registerMembersModule.membersCollection);
  gh.factory<_i27.IsarCollection<_i18.MemberAccountEvent>>(
      () => registerMemberAccountEventsModule.memberAccountEventsCollection);
  gh.factory<_i27.IsarCollection<_i17.Notification>>(
      () => registerNotificationsModule.notificationsCollection);
  gh.factory<_i27.IsarCollection<_i12.Dependent>>(
      () => registerDependentsModule.dependentsCollection);
  gh.factory<_i27.IsarCollection<_i7.GlobalConfiguration>>(
      () => registerGlobalConfigurationsModule.globalConfigurationsCollection);
  gh.factory<_i28.LocalFilesLocalDatabaseService<_i6.LocalFile>>(
      () => registerLocalFilesModule.localFilesLocalDatabase);
  gh.factory<_i29.Logger>(() => registerLoggerModule.logger);
  gh.factory<_i30.LoyaltyPointsLocalDatabaseService<_i15.LoyaltyPoint>>(
      () => registerLoyaltyPointsModule.loyaltyPointsLocalDatabase);
  gh.factory<
          _i31
          .MemberAccountEventsLocalDatabaseService<_i18.MemberAccountEvent>>(
      () => registerMemberAccountEventsModule.memberAccountEventsLocalDatabase);
  gh.factory<_i32.MemberAccountsLocalDatabaseService<_i13.MemberAccount>>(
      () => registerMemberAccountsModule.memberAccountsLocalDatabase);
  gh.factory<_i33.MembersLocalDatabaseService<_i16.Member>>(
      () => registerMembersModule.membersLocalDatabase);
  gh.factory<_i34.NotificationsLocalDatabaseService<_i17.Notification>>(
      () => registerNotificationsModule.notificationsLocalDatabase);
  gh.factory<_i3.Realtime>(() => registerAppwriteModule.realtime);
  gh.factory<
      _i35.ServiceProviderAddresssLocalDatabaseService<
          _i11.ServiceProviderAddress>>(() =>
      registerServiceProviderAddresssModule
          .serviceProviderAddresssLocalDatabase);
  gh.factory<
      _i36.ServiceProviderCategorysLocalDatabaseService<
          _i8.ServiceProviderCategory>>(() =>
      registerServiceProviderCategorysModule
          .serviceProviderCategorysLocalDatabase);
  gh.factory<_i37.ServiceProvidersLocalDatabaseService<_i10.ServiceProvider>>(
      () => registerServiceProvidersModule.serviceProvidersLocalDatabase);
  gh.factory<_i3.Storage>(() => registerAppwriteModule.storage);
  gh.factory<String>(
    () => dioModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.factory<_i38.TownsLocalDatabaseService<_i14.Town>>(
      () => registerTownsModule.townsLocalDatabase);
  gh.singletonAsync<_i39.AbstractUsersRepository>(
    () async => _i39.UsersDevelopmentRepository(
      get<_i3.Account>(),
      await get.getAsync<_i27.Isar>(),
    ),
    registerFor: {_dev},
  );
  gh.singletonAsync<_i39.AbstractUsersRepository>(
    () async => _i39.UsersProductionRepository(
      get<_i24.Dio>(),
      await get.getAsync<_i27.Isar>(),
    ),
    registerFor: {_prod},
  );
  gh.singletonAsync<_i39.AuthenticationBloc>(() async =>
      _i39.AuthenticationBloc(
          usersRepository: await get.getAsync<_i39.AbstractUsersRepository>()));
  gh.singleton<_i40.FileWatcher>(_i40.FileWatcher(
    storage: get<_i3.Storage>(),
    realtime: get<_i3.Realtime>(),
  ));
  return get;
}

class _$RegisterAppwriteModule extends _i41.RegisterAppwriteModule {}

class _$RegisterLocalFilesModule extends _i42.RegisterLocalFilesModule {}

class _$RegisterGlobalConfigurationsModule
    extends _i43.RegisterGlobalConfigurationsModule {}

class _$RegisterServiceProviderCategorysModule
    extends _i44.RegisterServiceProviderCategorysModule {}

class _$RegisterCurrencysModule extends _i45.RegisterCurrencysModule {}

class _$RegisterServiceProvidersModule
    extends _i46.RegisterServiceProvidersModule {}

class _$RegisterServiceProviderAddresssModule
    extends _i47.RegisterServiceProviderAddresssModule {}

class _$RegisterDependentsModule extends _i48.RegisterDependentsModule {}

class _$RegisterMemberAccountsModule
    extends _i49.RegisterMemberAccountsModule {}

class _$RegisterTownsModule extends _i50.RegisterTownsModule {}

class _$RegisterLoyaltyPointsModule extends _i51.RegisterLoyaltyPointsModule {}

class _$RegisterMembersModule extends _i52.RegisterMembersModule {}

class _$RegisterNotificationsModule extends _i53.RegisterNotificationsModule {}

class _$RegisterMemberAccountEventsModule
    extends _i54.RegisterMemberAccountEventsModule {}

class _$DioModule extends _i55.DioModule {}

class _$RegisterModule extends _i56.RegisterModule {}

class _$RegisterLoggerModule extends _i57.RegisterLoggerModule {}
