import 'package:flutter/material.dart';

class CustomStreamBuilder<T> extends StatelessWidget {
  const CustomStreamBuilder({
    required this.stream,
    required this.onData,
    this.onError,
    this.onWaiting,
  });

  final Widget Function(T data) onData;
  final Widget Function(Object error)? onError;
  final Widget Function()? onWaiting;
  final Stream<T?> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T?>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return onData(snapshot.data as T);
        } else if (snapshot.hasError) {
          return Center(
            child: onError?.call(snapshot.error!) ??
                Text(snapshot.error.toString()),
          );
        } else {
          return onWaiting?.call() ??
              const Center(
                child: CircularProgressIndicator(),
              );
        }
      },
    );
  }
}
