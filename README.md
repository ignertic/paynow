# paynow
<img src="https://img.shields.io/pub/v/paynow?style=for-the-badge">
<img src="https://img.shields.io/github/last-commit/ignertic/paynow">
<img src="https://img.shields.io/twitter/url?label=SuperQode&style=social&url=https%3A%2F%2Ftwitter.com%2Fiamsupercode">

# Getting Started

Make sure to add the paynow dependency to your pubspec.yaml file

    paynow: ^latest_version

## Import the *paynow* package

```
    import 'package:paynow/paynow.dart' show Paynow;
```

## Initialise Paynow

```
    Paynow paynow = Paynow(integrationKey: "INTEGRATION_KEY", integrationId: "INTEGRATION_ID", returnUrl: "http://yourReturnUrl.com", resultUrl: "http://yourResultUrl.com");
```

## Create Payment Instance
```
    Payment payment = paynow.createPayment("Client", "client@email.com");
```

## Add item(s) to cart
```
    payment.add("Banana", 1.9);
```


## Initiate Paynow Transaction (Web Checkout)

```
    InitResponse response  = await paynow.send(payment);
```

## Initiate Express Checkout

```
    InitResponse response = await paynow.sendMobile(payment, "0784442662", "ecocash"); // defaults to ecocash if blank
```

## Check Response results

```
    // Display results
    print(response());

    // Print Instructions
    print(response.instructions);
    
    // For Web Checkout, you get your [redirect_url] to redirect your client to
    String redirectuUrl = response.redirectUrl
```

## Check Transaction Status

```
    StatusResponse statusResponse = await paynow.checkTransactionStatus(response.pollUrl);

    if (statusResponse.paid){
        print("Client Paid");
    }else{
        print("Transaction was unsuccessful");
    }
```


NB: *This is an unofficial API for [Paynow](paynow.co.zw). The paynow community does not host a Paynow SDK for Flutter so I put up this project for those who want to implement in-app purchases in their flutter apps. All contributions and PR requests are welcome. YES even a typo fix.*

### Experimental..........
[On this branch the Paynow package will automatically open a webview for you](https://github.com/ignertic/paynow/tree/autowebview)

All contributions and PRs are welcome :) AND don't be shy to open issues.

Coded with love by [SuperCode](https://ignertic.github.io)