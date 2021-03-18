// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactsStore on _ContactsStore, Store {
  Computed<List<Contact>>? _$contactsComputed;

  @override
  List<Contact> get contacts =>
      (_$contactsComputed ??= Computed<List<Contact>>(() => super.contacts,
              name: '_ContactsStore.contacts'))
          .value;

  final _$insertContactAsyncAction =
      AsyncAction('_ContactsStore.insertContact');

  @override
  Future<void> insertContact(ContactInsertParams params) {
    return _$insertContactAsyncAction.run(() => super.insertContact(params));
  }

  @override
  String toString() {
    return '''
contacts: ${contacts}
    ''';
  }
}
