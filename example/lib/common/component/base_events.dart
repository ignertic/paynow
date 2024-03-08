part of 'base_bloc.dart';

class BaseEvent<T> {}

class LoadEvent<T> extends BaseEvent<T> {
  final Map<String, dynamic> parameters;

  LoadEvent({required this.parameters});
}

class CreateEvent<T> extends BaseEvent<T> {
  final T entity;

  CreateEvent({required this.entity});
}

class ReadEvent<T> extends BaseEvent<T> {
  final String id;

  ReadEvent({required this.id});
}

class UpdateEvent<T> extends BaseEvent<T> {
  final String id;
  final T entity;

  UpdateEvent({required this.id, required this.entity});
}

class DeleteEvent<T> extends BaseEvent<T> {
  final String id;

  DeleteEvent({required this.id});
}
