import 'dart:async';

import 'package:example/common/injection/injection.dart';
import 'package:flutter/material.dart';

import 'package:isar/isar.dart';

class CustomIsarSortStreamBuilder<T> extends StatefulWidget {
  const CustomIsarSortStreamBuilder({
    required this.queryBuilder,
    required this.onData,
    this.onError,
    this.onWaiting,
    required this.collection,
  });

  final QueryBuilder<T, T, QAfterSortBy> Function(Isar isar) queryBuilder;
  final IsarCollection<T> Function(Isar isar) collection;
  final Widget Function(List<T> data) onData;
  final Widget Function(Object error)? onError;
  final Widget Function()? onWaiting;

  @override
  CustomIsarSortStreamBuilderState<T> createState() =>
      CustomIsarSortStreamBuilderState<T>();
}

class CustomIsarSortStreamBuilderState<T>
    extends State<CustomIsarSortStreamBuilder<T>> {
  late StreamSubscription<void> _subscription;
  late StreamController<List<T>> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<T>>();
    _subscribeToChanges();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _streamController.close();
    super.dispose();
  }

  void _subscribeToChanges() {
    _subscription = widget.collection
        .call(getIt<Isar>())
        .watchLazy(fireImmediately: true)
        .listen((_) async {
      final queryResult =
          await widget.queryBuilder.call((getIt<Isar>())).findAll();
      _streamController.add(queryResult);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return widget.onData(snapshot.data!);
        } else if (snapshot.hasError) {
          return Center(
            child: widget.onError?.call(snapshot.error!) ??
                Text(snapshot.error.toString()),
          );
        } else {
          return widget.onWaiting?.call() ??
              const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
