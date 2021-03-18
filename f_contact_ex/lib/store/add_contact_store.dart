import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:mobx/mobx.dart';

part 'add_contact_store.g.dart';

class AddContactStore = _AddContactStore with _$AddContactStore;

abstract class _AddContactStore with Store {
  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String phone = '';

  @observable
  String? photoName = '';

  @computed
  ContactInsertParams get contactInsertParams => ContactInsertParams(
      name: name, phone: phone, email: email, photoName: photoName);
}
