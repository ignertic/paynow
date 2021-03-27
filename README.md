---
id: flutter_quickstart
title: Flutter Guide
sidebar_label: Dart
-------------------

## Sign in to Paynow and get integration details

> Before you can start making requests to Paynow's API, you need to get an integration ID and integration Key from Paynow. Details about how you can retrieve the ID and key are explained in detail on [this page](generation.md)

## Prerequisites

In order to make use of this project, the following prerequisites must be met for it to work.

1. Latest Flutter SDK Version

## Installation
To use the Flutter Paynow SDK, you need to add the latest release as a dependency to your project by updating your `pubspec.yaml`.  
The latest release will be on the [pub.dev](https://pub.dev/packages/paynow).


#### pubspec.yaml
```yaml
  paynow: ^latest_version
```


## Getting started
Create an instance of `Paynow` associated with your integration ID and integration key as supplied by Paynow.

## Import the *paynow* package

```
    import 'package:paynow/paynow.dart';
```

## Initialise Paynow

```
    Paynow paynow = Paynow(integrationKey: "INTEGRATION_KEY", integrationId: "INTEGRATION_ID", returnUrl: "http://yourReturnUrl.com", resultUrl: "http://yourResultUrl.com");
```

## Create Payment Instance

Create a new payment using any of the `createPayment(...)` methods, ensuring you pass your own unique reference for that payment (e.g invoice id). If you also pass in the email address, Paynow will attempt to auto login the customer at the Paynow website using this email address if it is associated with a registered account.

```
    Payment payment = paynow.createPayment("Invoice 32", "client@email.com");
```

## Add item(s) to cart
```
    payment.add("Banana", 2.0);
```


## Initiating a web based transaction
A web based transaction is made over the web, via the Paynow website.

You can optionally set the result and return URLs.

* Result URL is the URL on the merchant website where Paynow will post transaction results to.
* Return URL is the URL where the customer will be redirected to after the transaction has been processed. If you do not specify a return URL, you will have to rely solely on polling status updates to determine if the transaction has been paid.

```dart
    paynow.setResultUrl("http://example.com/gateways/paynow/update");
    paynow.setReturnUrl("http://example.com/return?gateway=paynow&merchantReference=1234");
```

```dart
    InitResponse response  = await paynow.send(payment);
```

The `InitResponse` response from Paynow will contain various information including:
* url to redirect your customer to complete payment.
* poll URL to check if the transaction has been paid



## Initiating a mobile based transaction
A mobile transaction is a transaction made using mobile money e.g. using Ecocash

> Note: Mobile based transactions currently only work for Ecocash with Econet numbers and OneMoney with Netone numbers

Create a new payment using the `createPayment(...)` method that requires a unique merchant reference and the email address of the user making the payment.

```
    InitResponse response = await paynow.sendMobile(payment, "0784442662", "ecocash"); // defaults to ecocash if method not specified
```

## Check Response results

The `InitResponse` response from Paynow will contain various information including:
* url to redirect your customer to complete payment.
* poll URL to check if the transaction has been paid

```
    // Display results
    print(response());

    // Print Instructions
    print(response.instructions);
    
    // For Web Checkout, you get your [redirect_url] to redirect your client to
    String redirectuUrl = response.redirectUrl
```

## Poll the transaction to check for the payment status
It is possible to check the status of a transaction i.e. if the payment has been paid. To do this, make sure after initiating the transaction, you take note of the poll URL in the response. With this URL, call the `pollTransaction(...)` method of the `Paynow` object you created as follows. Note that checking transaction status is the same for web and mobile based transasctions.

If the request was successful, you should consider saving the poll URL sent from Paynow in your database so that you can use it later to check if the transaction has been paid.

```
    InitResponse response = await paynow.send(payment);
    StatusResponse statusResponse = await paynow.checkTransactionStatus(response.pollUrl);

    if (statusResponse.paid){
        print("Client Paid");
    }
    else{
        print("Transaction was unsuccessful");
    }
```

## Serverless Express Checkout in `v1.1.x` (stream transaction for payment status)
You are now able to `stream` poll url transaction status as opposed to using delay for a serverless checkout. 
This is useful when you dont have a server to check paynow result url as set by `resultUrl` and `returnUrl` attributes
- Full test example can be found [here](test/test_express_checkout_status_stream.dart) under test folder
- `paynow.streamTransactionStatus(..)` takes a required `pollUrl` string and optional `streamInterval` in seconds which is the interval to poll the url, default to `20` sec
- You can stream status and show current transaction status on UI to user with a `StreamBuilder(..)`
- Check [example folder](example) for a full example
```dart
 // grab poll url from `StatusResponse` object or database
 var pollUrl = statusResponse.pollUrl;

 // in Widget build(..) method
 // you can do something like
 StreamBuilder(
     stream: paynow.streamTransactionStatus(pollUrl),
     builder: (context, AsyncSnapshot<StatusResponse> snapshot) {
         if(snapshot.hasData) {
             var response = snapshot.data;

             // check status or bool flag here
             return _trxnStatus(response.status);
         }

         else {
             return CircularProgressIndicator();
         }
     }
 )

 // return a widget based on status from stream
 Widget _trxnStatus(String status) {
    switch(status) {
        case 'Paid':
            return Text('Transaction Successfully Paid');
            break;

        case 'Sent':
            return Container(
                height: 130, 
                Column(
                    children: [
                        Text('Payment request sent'),
                        SizedBox(height: 20),
                        CircularProgressIndicator(),
                        Text('waiting for response...'),
                    ],
                ),
            );
            break;

        case 'Cancelled':
            return Text('You have cancelled payment request');
            break;

        default:
            return SizedBox.shrink();
     }
 }

```

## Full usage example
The following is a usage example for mobile based transactions.
For a full usage example please check the `example` folder.

```dart
   import 'package:paynow/paynow.dart';
   
   main()async{
      Paynow paynow = Paynow(integrationId: '', integrationKey: '', resultUrl: '', returnUrl :'');
      Payment payment = paynow.createPayment('Invoice 32', 'user@email.com');
      
      // add something to cart
      payment.add('Banana', 10.0);
      
      // start web checkout
      InitResponse response = await payment.sendMobile(payment, '0784442662');
      
      //delay
      await Future.delayed(Duration(seconds: 3));
      
      // check transaction status
      StatusResponse status = await paynow.checkTransactionStatus(response.pollUrl);
      
      if (status.paid){
        print('Yes!!!!!');
      }else{
        print('You didn\'t pay');
      }
   }
```

A