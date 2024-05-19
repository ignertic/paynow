import 'package:auto_route/auto_route.dart';
import 'package:example/common/navigation/navigation.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paynow Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Paynow Example'),
            ElevatedButton(
                onPressed: () {
                  // go to products list page
                  context.router.push(const ProductsListRoute());
                },
                child: Text("BEGIN"))
          ],
        ),
      ),
    );
  }
}
