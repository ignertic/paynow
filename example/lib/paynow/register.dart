import 'package:injectable/injectable.dart';
import 'package:paynow/paynow.dart';

// petalmafrica
// const String integrationId = '17190';
// const String integrationKey = 'fe360955-4a87-4648-b922-c65ed96f90ae';
const String integrationId = '11287';
const String integrationKey = 'a072bd58-c25e-48cb-8516-3d33b5b85f64';
const String returnUrl = 'https://paynow.app/paynow/return/<payment_id>';

const String resultUrl = 'https://dump.oacey.com/paynow';

@module
abstract class RegisterPaynowModule {
  Paynow get paynow => Paynow(
      integrationId: integrationId,
      integrationKey: integrationKey,
      returnUrl: returnUrl,
      resultUrl: resultUrl);
}
