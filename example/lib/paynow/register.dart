import 'package:injectable/injectable.dart';
import 'package:paynow/paynow.dart';

const String integrationId = '17190';
const String integrationKey = 'fe360955-4a87-4648-b922-c65ed96f90ae';
const String returnUrl = 'https://supercode.app/paynow/return/<payment_id>';

const String resultUrl = 'https://google.com/id';

@module
abstract class RegisterPaynowModule {
  Paynow get paynow => Paynow(
      integrationId: integrationId,
      integrationKey: integrationKey,
      returnUrl: returnUrl,
      resultUrl: resultUrl);
}
