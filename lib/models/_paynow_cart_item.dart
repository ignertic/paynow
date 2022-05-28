// remove

///
/// Represents a product or service
class PaynowCartItem {
  PaynowCartItem({
    required this.title,
    required this.amount
  });
  final String title;
  final double amount;

  factory PaynowCartItem.fromMap(data){
    return PaynowCartItem(
      title: data['title'],
      amount: data['amount']
    );
  }

  @override
  toString(){
    return title;
  }

  toMap()=>{
    'title' : title,
    'amount' : amount
  };

  copyWith({
    String? title,
    double? amount
  }){
    return PaynowCartItem(
      title: title ?? this.title,
      amount: amount ?? this.amount
    );
  }
}
