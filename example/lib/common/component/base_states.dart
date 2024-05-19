part of 'base_bloc.dart';

class BaseState<T> {}

class FailedState<T> extends BaseState<T> {
  final String error;

  FailedState({required this.error});
}

class ReadState<T> extends BaseState<T> {
  final T entity;

  ReadState({required this.entity});
}

class LoadedState<T> extends BaseState<T> {
  final List<T> data;

  LoadedState({required this.data});
}

class CreatedState<T> extends BaseState<T> {
  final T entity;

  CreatedState({required this.entity});
}

class UpdatedState<T> extends BaseState<T> {
  final T entity;

  UpdatedState({required this.entity});
}

class DeletedState<T> extends BaseState<T> {
  final T? entity;
  final String entityId;

  DeletedState({required this.entity, required this.entityId});
}
