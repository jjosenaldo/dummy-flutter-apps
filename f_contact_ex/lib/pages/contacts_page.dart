import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/store/contact_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactsPage extends StatelessWidget {
  final _contactStore = Modular.get<ContactStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('add');
        },
        child: Icon(Icons.add),
      ),
      body: Observer(
        builder: (context) => ListView.builder(
          itemBuilder: (context, index) =>
              ContactCard(contact: _contactStore.contacts[index]),
          itemCount: _contactStore.contacts.length,
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
      title: Text(contact.name),
      subtitle: Text('${contact.email}\n${contact.phone}'),
      isThreeLine: true,
    );
  }
}
