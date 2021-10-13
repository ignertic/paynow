// remove

class StatusResponse {
  /// Boolean value indication whether the transaction was paid or not.
  late final bool paid;

  /// The status of the transaction in Paynow.
  late final String status;

  /// The total amount of the transaction.
  late final String amount;

  /// The unique identifier for the transaction.
  late final String reference;

  /// unique traceable transaction reference number from paynow
  /// suitable tracking transaction for reconcilliation
  late final String paynowreference;

  /// The unique identifier for the transaction.
  late final String hash;

  StatusResponse({
    required this.paid,
    required this.status,
    required this.amount,
    required this.reference,
    required this.hash,
    required this.paynowreference,
  });

  /// Return [StatusResponse] from json.
  static fromJson(Map<String, dynamic> data) {
    return StatusResponse(
      paid: data['paid'] == "paid",
      status: data['status'],
      amount: data['amount'],
      reference: data['reference'],
      hash: data['hash'],
      paynowreference: data['paynowreference'],
    );
  }

  @override
  String toString() {
    return 'StatusResponse(paid: $paid, paynowreference: $paynowreference, status: $status, amount: $amount, reference: $reference, hash: $hash)';
  }
}
