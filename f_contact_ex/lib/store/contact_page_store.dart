import 'dart:io';

import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:mobx/mobx.dart';

part 'contact_page_store.g.dart';

class ContactPageStore = _ContactPageStore with _$ContactPageStore;

abstract class _ContactPageStore with Store {
  _ContactPageStore() {
    setFields(null);
  }

  Future<void> savePhotoToDisk() async {
    if (photo != null && photoName != null) {
      await photo!.writeAsBytes(photo!.readAsBytesSync());
    }
  }

  @action
  void setFields(Contact? maybeContact) {
    originalName = maybeContact?.name;
    originalPhotoName = maybeContact?.photoName;
    originalEmail = maybeContact?.email;
    originalPhone = maybeContact?.phone;

    name = maybeContact?.name ?? '';
    photoName = maybeContact?.photoName;
    email = maybeContact?.email ?? '';
    phone = maybeContact?.phone ?? '';

    if (maybeContact != null) {
      id = maybeContact.id;
    }

    if (maybeContact != null && maybeContact.photoName != null) {
      setPhotoFromPath(maybeContact.photoName!);
    } else {
      setPhotoFromPath(null);
    }
  }

  String? originalName;
  String? originalEmail;
  String? originalPhone;
  String? originalPhotoName;

  late int id;

  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String phone = '';

  @observable
  String? photoName;

  @observable
  File? photo;

  @action
  void setPhotoFromPath(String? maybePath) {
    this.photoName = maybePath;
    this.photo = maybePath != null ? File(maybePath) : null;
  }

  @computed
  ContactInsertParams get contactInsertParams => ContactInsertParams(
        name: name,
        phone: phone,
        email: email,
        photoName: photoName,
      );
  @computed
  ContactUpdateByIdParams get contactUpdateByIdParams =>
      ContactUpdateByIdParams(
        id: id,
        email: email != originalEmail ? email : null,
        name: name != originalName ? name : null,
        photoName: photoName != originalPhotoName ? photoName : null,
        phone: phone != originalPhone ? phone : null,
      );
}
