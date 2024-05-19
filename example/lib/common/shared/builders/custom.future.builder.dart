import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  const CustomFutureBuilder({
    required this.future,
    required this.onLoaded,
    this.onError,
    this.onLoading,
  });
  final Widget Function(T instance) onLoaded;
  final Widget Function(String error)? onError;
  final Widget Function()? onLoading;
  final Future<T?> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return onLoaded(snapshot.data as T);
          } else if (snapshot.hasError) {
            // throw snapshot.error as Object;
            return Center(
                child: onError?.call(snapshot.error.toString()) ??
                    Text(snapshot.error.toString()));
          } else {
            return onLoading?.call() ??
                const Center(
                  child: CircularProgressIndicator(),
                );
          }
        });
  }
}
