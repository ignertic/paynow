# paynow

This is an unofficial flutter package for [Paynow](https://paynow.co.zw)

## Getting Started

```
Paynow paynow = Paynow(integrationKey: "XXXX-XXXXX-XXXXX-XXXX", integrationId: "1234", returnUrl: "http://google.com", resultUrl: "http://google.com");
Payment payment = paynow.createPayment(DateTime.now().toString(), "user@email.com");

// add item to cart
payment.add("Banana", 15.9);

// error callback
paynow.onError = (data){
  print(data);
};

// set Transaction check callback
paynow.onCheck = (StatusResponse response){
  print(response.reference);
};

// transaction callback
paynow.onDone = (response){
  print("Checking Transaction Status");
  paynow.checkTransactionStatus(response['pollurl']);
};

try{
  // initiate mobile payment
  paynow._initMobile(payment, "0784442662", "ecocash");
}catch(e){
  print("Client has insufficient funds");
}

```

## NOTE
It's not yet perfect but it works, try out the example.



All contributions and PRs are welcome :) AND don't be shy to open issues.


[SuperCode](https://ignertic.github.io)
