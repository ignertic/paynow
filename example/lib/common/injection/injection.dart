import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies()async{
  await $initGetIt(getIt, environment: Env.dev);
}

abstract class Env{
  static const dev = 'dev';
  static const prod = 'prod';
}
