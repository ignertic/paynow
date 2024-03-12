import 'dart:async';

import 'package:example/common/injection/injection.dart';
import 'package:flutter/material.dart';

import 'package:isar/isar.dart';

class CustomIsarWhereStreamBuilder<T> extends StatefulWidget {
  const CustomIsarWhereStreamBuilder({
    required this.collection,
    required this.queryBuilder,
    required this.onData,
    this.onError,
    this.onWaiting,
  });

  final QueryBuilder<T, T, QWhere> Function(Isar isar) queryBuilder;
  final IsarCollection<T> Function(Isar isar) collection;
  final Widget Function(List<T> data) onData;
  final Widget Function(Object error)? onError;
  final Widget Function()? onWaiting;

  @override
  CustomIsarWhereStreamBuilderState<T> createState() =>
      CustomIsarWhereStreamBuilderState<T>();
}

class CustomIsarWhereStreamBuilderState<T>
    extends State<CustomIsarWhereStreamBuilder<T>> {
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
    _subscription =
        widget.collection.call(getIt<Isar>()).watchLazy().listen((_) async {
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
