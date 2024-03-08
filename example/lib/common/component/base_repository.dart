part of 'base_bloc.dart';

class BaseRepository<T> {
  Future<T> create(T entity) async {
    return Future.value(entity);
  }

  Future<List<T>> list({required Map<String, dynamic> parameters}) {
    return Future.value(<T>[]);
  }

  Future<T> read(String id) async {
    // Implement read operation based on the entity's ID
    return Future.value(null);
  }

  Future<T> update(String id, T entity) async {
    // Implement update operation based on the entity's ID
    return Future.value(entity);
  }

  Future<void> delete(String id) async {
    // Implement delete operation based on the entity's ID
  }

  Future<void> deleteAll({List<String>? ids}) async {}

  Future<void> fetchAllDocuments(
      {required Function(List<T> documents, int pageNumber)
          onDocuments}) async {}
}
