import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class RegisterLoggerModule {
  Logger get logger => Logger();
}
