import '../src/paynow.dart';

class InitResponse {
  /// Boolean indicating whether initiate request was successful or not.
  final bool? success;

  /// Instruction for transcation status.
  final String? instructions;

  /// Boolean indicating whether the response contains a url to redirect to
  final bool hasRedirect;

  /// Transaction Hash
  final String? hash;

  /// The url the user should be taken to so they can make a payment
  final String? redirectUrl;

  /// Error String
  final String error;

  /// The poll URL sent from Paynow
  final String? pollUrl;

  InitResponse(
      {
      required this.redirectUrl,
      required this.hasRedirect,
      required this.pollUrl,
      required this.error,
      required this.success,
      required this.hash,
      required this.instructions
    });

  Map<String, dynamic> call() {
    Map<String, dynamic> data = {
      "redirect": this.redirectUrl,
      "hasRedirect": this.hasRedirect,
      "pollUrl": this.pollUrl,
      "error": this.error,
      "success": this.success,
      "hash": this.hash,
      "instructions": this.instructions
    };
    // TODO:/// Refactor
    return data;
  }

  /// Returns [InitResponse]
  static fromJson(Map<String, dynamic> data) {
    return InitResponse(
        success: data['status'] != "error",
        error: data['error'].toString().toLowerCase(),
        hash: data['hash'],
        hasRedirect: data['browserurl'] != null,
        redirectUrl: data['browserurl']==null ? null : Paynow.notQuotePlus(data['browserurl'].toString()),
        instructions: data['instructions'],
        pollUrl: data['pollurl'] == null
            ? ""
            : Paynow.notQuotePlus(data['pollurl']));
  }

  @override
  String toString() {
    return 'InitResponse(success: $success, instructions: $instructions, hasRedirect: $hasRedirect, hash: $hash, redirectUrl: $redirectUrl, error: $error, pollUrl: $pollUrl)';
  }
}
