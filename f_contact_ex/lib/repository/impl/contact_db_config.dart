import 'package:f_contact_ex/model/contact.dart';

const kTableName = 'contacts';
const kIdColumnName = 'id';
const kNameColumnName = 'name';
const kPhoneColumnName = 'phone';
const kEmailColumnName = 'email';
const kPhotoNameColumnName = 'photo_name';

Map<String, dynamic> buildDatabaseInsertJson({
  required String name,
  required String phone,
  required String email,
  String? photoName,
}) =>
    {
      kNameColumnName: name,
      kPhoneColumnName: phone,
      kEmailColumnName: email,
      if (photoName != null) kPhotoNameColumnName: photoName,
    };

Contact buildContactFromQueryJson(Map<String, dynamic> contactJson) {
  return Contact(
    id: contactJson[kIdColumnName],
    name: contactJson[kNameColumnName],
    email: contactJson[kEmailColumnName],
    phone: contactJson[kPhoneColumnName],
    photoName: contactJson[kPhotoNameColumnName],
  );
}
