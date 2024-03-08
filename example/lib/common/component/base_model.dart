part of 'base_bloc.dart';

abstract class BaseModel<T> {
  String? id;
  bool? syncToRemote;
  String? createdAt;
  String? updatedAt;

  T mapRemoteToLocal(Map<String, dynamic> data);
  static mapRemote(Map<String, dynamic> data) {}

  Map<String, dynamic> mapLocalToRemote();

  Map<String, dynamic> metadata() {
    return {};
  }

  int fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}

class Demo extends BaseModel<Demo> {
  @override
  Demo mapRemoteToLocal(Map<String, dynamic> data) {
    return Demo();
  }

  @override
  Map<String, dynamic> mapLocalToRemote() {
    return {};
  }

  static Map<String, dynamic> getMetadata() {
    return {
      'collection': 'demos',
    };
  }
}
