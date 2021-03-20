// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactPageStore on _ContactPageStore, Store {
  Computed<ContactInsertParams>? _$contactInsertParamsComputed;

  @override
  ContactInsertParams get contactInsertParams =>
      (_$contactInsertParamsComputed ??= Computed<ContactInsertParams>(
              () => super.contactInsertParams,
              name: '_ContactPageStore.contactInsertParams'))
          .value;
  Computed<ContactUpdateByIdParams>? _$contactUpdateByIdParamsComputed;

  @override
  ContactUpdateByIdParams get contactUpdateByIdParams =>
      (_$contactUpdateByIdParamsComputed ??= Computed<ContactUpdateByIdParams>(
              () => super.contactUpdateByIdParams,
              name: '_ContactPageStore.contactUpdateByIdParams'))
          .value;

  final _$nameAtom = Atom(name: '_ContactPageStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$emailAtom = Atom(name: '_ContactPageStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$phoneAtom = Atom(name: '_ContactPageStore.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$photoNameAtom = Atom(name: '_ContactPageStore.photoName');

  @override
  String? get photoName {
    _$photoNameAtom.reportRead();
    return super.photoName;
  }

  @override
  set photoName(String? value) {
    _$photoNameAtom.reportWrite(value, super.photoName, () {
      super.photoName = value;
    });
  }

  final _$photoAtom = Atom(name: '_ContactPageStore.photo');

  @override
  File? get photo {
    _$photoAtom.reportRead();
    return super.photo;
  }

  @override
  set photo(File? value) {
    _$photoAtom.reportWrite(value, super.photo, () {
      super.photo = value;
    });
  }

  final _$_ContactPageStoreActionController =
      ActionController(name: '_ContactPageStore');

  @override
  void setFields(Contact? maybeContact) {
    final _$actionInfo = _$_ContactPageStoreActionController.startAction(
        name: '_ContactPageStore.setFields');
    try {
      return super.setFields(maybeContact);
    } finally {
      _$_ContactPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhotoFromPath(String? maybePath) {
    final _$actionInfo = _$_ContactPageStoreActionController.startAction(
        name: '_ContactPageStore.setPhotoFromPath');
    try {
      return super.setPhotoFromPath(maybePath);
    } finally {
      _$_ContactPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
phone: ${phone},
photoName: ${photoName},
photo: ${photo},
contactInsertParams: ${contactInsertParams},
contactUpdateByIdParams: ${contactUpdateByIdParams}
    ''';
  }
}
