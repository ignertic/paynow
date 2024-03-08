import 'package:bloc/bloc.dart';

part 'base_events.dart';
part 'base_states.dart';
part 'base_repository.dart';
part 'base_model.dart';

class BaseBloc<T> extends Bloc<BaseEvent<T>, BaseState<T>> {
  final BaseRepository<T> repository;
  Map<String, dynamic>? _lastLoadedParameters;

  BaseBloc({required this.repository}) : super(BaseState<T>()) {
    on<LoadEvent<T>>((event, emit) async {
      // try {
      _lastLoadedParameters = event.parameters;
      emit(LoadedState<T>(
          data: await repository.list(parameters: event.parameters)));
      // } catch (error) {
      //   emit(FailedState<T>(error: error.toString()));
      // }
    });

    on<CreateEvent<T>>((event, emit) async {
      try {
        emit(CreatedState<T>(entity: await repository.create(event.entity)));
        if (_lastLoadedParameters != null) {
          emit(LoadedState<T>(
              data: await repository.list(parameters: _lastLoadedParameters!)));
        }
      } catch (error) {
        emit(FailedState<T>(error: error.toString()));
      }
    });

    on<ReadEvent<T>>((event, emit) async {
      try {
        emit(ReadState<T>(entity: await repository.read(event.id)));
      } catch (error) {
        emit(FailedState<T>(error: error.toString()));
      }
    });

    on<UpdateEvent<T>>((event, emit) async {
      try {
        emit(UpdatedState<T>(
            entity: await repository.update(event.id, event.entity)));
        if (_lastLoadedParameters != null) {
          emit(LoadedState<T>(
              data: await repository.list(parameters: _lastLoadedParameters!)));
        }
      } catch (error) {
        emit(FailedState<T>(error: error.toString()));
      }
    });

    on<DeleteEvent<T>>((event, emit) async {
      try {
        await repository.delete(event.id);
        emit(DeletedState<T>(entity: null, entityId: event.id));
        if (_lastLoadedParameters != null) {
          emit(LoadedState<T>(
              data: await repository.list(parameters: _lastLoadedParameters!)));
        }
      } catch (error) {
        emit(FailedState<T>(error: error.toString()));
      }
    });
  }
}

// void main() {
//   final demoRepo = BaseRepository<Demo>();
//   final demoBloc = BaseBloc<Demo>(repository: demoRepo);

//   demoBloc.stream.listen((state) {
//     if (state is LoadedState<Demo>) {
//       print(state.data);
//     } else if (state is CreatedState<Demo>) {
//       print(state.entity);
//     } else if (state is FailedState<Demo>) {
//       print("Error: ${state.error}");
//     }
//   });

//   demoBloc.add(LoadEvent<Demo>(parameters: {'category': 5}));
//   demoBloc.add(CreateEvent<Demo>(entity: Demo()));
//   demoBloc.add(ReadEvent<Demo>(id: 'some_id'));
//   demoBloc.add(UpdateEvent<Demo>(id: 'some_id', entity: Demo()));
//   demoBloc.add(DeleteEvent<Demo>(id: 'some_id'));
// }
