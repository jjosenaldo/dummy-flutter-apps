import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:mobx/mobx.dart';

part 'contact_page_store.g.dart';

class ContactPageStore = _ContactPageStore with _$ContactPageStore;

abstract class _ContactPageStore with Store {
  _ContactPageStore(Contact? contact)
      : originalName = contact?.name,
        originalPhone = contact?.phone,
        originalPhotoName = contact?.photoName,
        originalEmail = contact?.email;

  final String? originalName;
  final String? originalEmail;
  final String? originalPhone;
  final String? originalPhotoName;

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
