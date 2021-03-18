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

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
phone: ${phone},
photoName: ${photoName},
contactInsertParams: ${contactInsertParams}
    ''';
  }
}
