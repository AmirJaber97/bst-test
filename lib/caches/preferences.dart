import 'package:bsttest/app/logger.dart';
import 'package:hive/hive.dart';

class Preferences {
  var logger = getLogger('Preferences');

  static const _preferencesBox = '_preferencesBox';
  static const _token = '_token';

  Box<dynamic> _box;

  Future openBox() async {
    this._box = await Hive.openBox<dynamic>(_preferencesBox);
  }

  String token() => _getValue(_token);

  Future<void> setToken(String token) => _setValue(_token, token);

  T _getValue<T>(dynamic key, {T defaultValue}) {
    logger.i(
        "Cache => Received ${_box.get(key, defaultValue: defaultValue) as T} from $key");
    return _box.get(key, defaultValue: defaultValue) as T;
  }

  Future<void> _setValue<T>(dynamic key, T value) {
    logger.i("Cache => Setting $key to $value");
    return _box.put(key, value);
  }

  Future<void> clearCache() {
    return _box.clear();
  }
}
