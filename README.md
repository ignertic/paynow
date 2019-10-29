# paynow

## Getting Started

```
Paynow paynow = Paynow(integrationKey: "XXXXXXXXXXXXXXXXXXXXX", integrationId: "XXXX", returnUrl: "http://google.com", resultUrl: "http://google.com");
Payment payment = paynow.createPayment("user", "user@email.com");

payment.add("Banana", 1.9);


// Initiate Paynow Transaction
paynow.send(payment)
..then((InitResponse response){

  // display results
  print(response());

  // Check Transaction status from pollUrl
  paynow.checkTransactionStatus(response.pollUrl)
  ..then((StatusResponse status){
    print(status.paid);
  });
});


  paynow.sendMobile(payment, "0784442662", "ecocash")
  ..then((InitResponse response){
    // display results
    print(response());

  // Check Transaction status from pollUrl
  paynow.checkTransactionStatus(response.pollUrl)
  ..then((StatusResponse status){
    print(status.paid);
    });
});

```

## NOTE
As of version 1.0 there will be breaking changes from earlier versions.


<img src="https://img.shields.io/pub/v/paynow?style=for-the-badge">
<img src="https://img.shields.io/github/last-commit/ignertic/paynow">
<img src="https://img.shields.io/twitter/url?label=SuperQode&style=social&url=https%3A%2F%2Ftwitter.com%2Fiamsupercode">
This is an unofficial flutter package for [Paynow](https://paynow.co.zw)

All contributions and PRs are welcome :) AND don't be shy to open issues.


Demo Video
https://drive.google.com/open?id=0B6_hKkaW57fmc3dGQXdGY0RaZUNuNU5rRmJGZEZPNUJXeHY4


[SuperCode](https://ignertic.github.io)
