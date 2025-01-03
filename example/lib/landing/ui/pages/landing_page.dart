import 'package:auto_route/auto_route.dart';
import 'package:example/common/navigation/navigation.dart';
import 'package:flutter/material.dart';
// Add this import

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Base64 string of the image
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paynow Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Paynow Example',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'This example is a demo of using the Paynow plugin for a simple shop. '
                'You can add items to the cart and perform a web checkout.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Text(
                  'Warning: The return URL for using a custom scheme that would return your customer back to the app '
                  'no longer works unless using a scheme that starts with https as required by Paynow.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // go to products list page
                  context.router.push(const ProductsListRoute());
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text("BEGIN"),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.8, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
