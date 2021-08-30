import 'package:hive/hive.dart';

class Preferences {
  static const _preferencesBox = '_preferencesBox';
  static const _serverAddress = '_serverAddress';
  static const _login = '_login';
  static const _password = '_password';

  late Box<dynamic> _box;

  Future openBox() async {
    this._box = await Hive.openBox<dynamic>(_preferencesBox);
  }

  String getServerAddress() => _getValue(_serverAddress) ?? "";
  String getLogin() => _getValue(_login) ?? "";
  String getPassword() => _getValue(_password) ?? "";

  Future setServerAddress(String value) => _setValue(_serverAddress, value);
  Future setLogin(String value) => _setValue(_login, value);
  Future setPassword(String value) => _setValue(_password, value);

  T _getValue<T>(dynamic key, {T? defaultValue}) {
    return _box.get(key, defaultValue: defaultValue) as T;
  }

  Future _setValue<T>(dynamic key, T value) {
    return _box.put(key, value);
  }

  Future clearCache() async {
    await _box.clear();
    return Future.wait([
      setServerAddress(""),
      setLogin(""),
      setPassword(""),
    ]);
  }

  Stream<BoxEvent> listenChanges(key) => _box.watch(key: key);
}
