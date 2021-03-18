import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:f_contact_ex/store/contacts_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactsPage extends StatelessWidget {
  final _contactStore = Modular.get<ContactsStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final contactInsertParams =
              await Modular.to.pushNamed<ContactInsertParams>('add');
          if (contactInsertParams != null) {
            _contactStore.insertContact(contactInsertParams);
          }
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Observer(
          builder: (context) => ListView.builder(
            itemBuilder: (context, index) =>
                ContactCard(contact: _contactStore.contacts[index]),
            itemCount: _contactStore.contacts.length,
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({
    required this.contact,
    Key? key,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.name, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('${contact.email}\n${contact.phone}'),
      isThreeLine: true,
    );
  }
}
