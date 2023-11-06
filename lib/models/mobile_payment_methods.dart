// remove

// Mobile Payment options
enum MobilePaymentMethod {
  ecocash('EcoCash'),
  innbucks('Innbucks'),
  onemoney('OneMoney'),
  paygo('PayGo'),
  telecash('Telecash');

  const MobilePaymentMethod(this.name);
  final String name;
}
