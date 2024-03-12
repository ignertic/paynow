import 'dart:async';
import 'package:example/common/injection/injection.dart';
import 'package:flutter/material.dart';

import 'package:isar/isar.dart';

class CustomIsarFilterStreamBuilder<T> extends StatefulWidget {
  const CustomIsarFilterStreamBuilder({
    required this.queryBuilder,
    required this.collection,
    required this.onData,
    this.onError,
    this.onWaiting,
  });

  final QueryBuilder<T, T, QAfterFilterCondition> Function(Isar isar)
      queryBuilder;
  final IsarCollection<T> Function(Isar isar) collection;
  final Widget Function(List<T> data) onData;
  final Widget Function(Object error)? onError;
  final Widget Function()? onWaiting;

  @override
  CustomIsarFilterStreamBuilderState<T> createState() =>
      CustomIsarFilterStreamBuilderState<T>();
}

class CustomIsarFilterStreamBuilderState<T>
    extends State<CustomIsarFilterStreamBuilder<T>> {
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
    _subscription = widget
        .collection(getIt<Isar>())
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
        late Widget _widget;
        if (snapshot.hasData) {
          _widget = widget.onData(snapshot.data!);
        } else if (snapshot.hasError) {
          _widget = Center(
            child: widget.onError?.call(snapshot.error!) ??
                Text(snapshot.error.toString()),
          );
        } else {
          _widget = widget.onWaiting?.call() ??
              const Center(child: CircularProgressIndicator());
        }

        return AnimatedSwitcher(
          duration: Duration(seconds: 2),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: _widget,
        );
      },
    );
  }
}
