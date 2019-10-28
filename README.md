# paynow

This is an unofficial flutter package for [Paynow](https://paynow.co.zw)

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

To use this plugin on iOS you need to opt-in for the embedded views preview by adding a boolean property to the app's Info.plist file, with the key io.flutter.embedded_views_preview and the value YES.






All contributions and PRs are welcome :) AND don't be shy to open issues.


Demo Video
https://drive.google.com/open?id=0B6_hKkaW57fmc3dGQXdGY0RaZUNuNU5rRmJGZEZPNUJXeHY4


[SuperCode](https://ignertic.github.io)
