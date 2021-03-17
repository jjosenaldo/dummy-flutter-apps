import 'package:mobx/mobx.dart';

class AddContactStore {
  final _name = Observable<String>('');
  final _email = Observable<String>('');
  final _phone = Observable<String>('');
  final _photoName = Observable<String?>('');

  set name(String name) => Action(() => _name.value = name)();
  set email(String email) => Action(() => _email.value = email)();
  set phone(String phone) => Action(() => _phone.value = phone)();
  set photoName(String? photoName) =>
      Action(() => _photoName.value = photoName)();
}
