import 'package:f_contact_ex/model/contact.dart';

import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:f_contact_ex/store/contact_page_store.dart';
import 'package:f_contact_ex/store/contacts_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'contact_page.dart';

class ContactsPage extends StatelessWidget {
  final _contactStore = Modular.get<ContactsStore>();

  @override
  Widget build(BuildContext screenContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Modular.get<ContactPageStore>().setFields(null);

          final maybeContactInsertParams = await Modular.to.pushNamed<Object>(
            'contact',
            arguments: ContactPageParams(pageType: ContactPageType.insert),
          );
          if (maybeContactInsertParams != null &&
              maybeContactInsertParams is ContactInsertParams) {
            _contactStore.insertContact(maybeContactInsertParams);
          }
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Observer(
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => ContactCard(
              contact: _contactStore.contacts[index],
              onTap: () => showModalBottomSheet(
                context: screenContext,
                builder: (modalSheetContext) => BottomSheet(
                  builder: (context) => ContactMenu(
                    callCallback: () {},
                    deleteCallback: () {},
                    editCallback: () => _goToEditPage(
                      _contactStore.contacts[index],
                      modalSheetContext,
                    ),
                  ),
                  onClosing: () {},
                ),
              ),
            ),
            itemCount: _contactStore.contacts.length,
            separatorBuilder: (_, __) => Divider(
              height: 0,
            ),
          ),
        ),
      ),
    );
  }

  void _goToEditPage(Contact contact, BuildContext modalSheetContext) async {
    Navigator.pop(modalSheetContext);

    Modular.get<ContactPageStore>().setFields(contact);

    final returnValue = await Modular.to.pushNamed<Object>(
      'contact',
      arguments: ContactPageParams(
        pageType: ContactPageType.edit,
      ),
    );

    if (returnValue != null && returnValue is ContactUpdateByIdParams) {
      _contactStore.updateContact(returnValue);
    }
  }
}

class ContactMenu extends StatelessWidget {
  const ContactMenu({
    Key? key,
    required this.editCallback,
    required this.callCallback,
    required this.deleteCallback,
  }) : super(key: key);

  final VoidCallback editCallback;
  final VoidCallback callCallback;
  final VoidCallback deleteCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          child: Text('Ligar'),
          onPressed: callCallback,
        ),
        TextButton(
          child: Text('Editar'),
          onPressed: editCallback,
        ),
        TextButton(
          child: Text('Excluir'),
          onPressed: deleteCallback,
        ),
      ],
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({
    required this.contact,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Contact contact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.name, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('${contact.email}\n${contact.phone}'),
      isThreeLine: true,
      onTap: onTap,
    );
  }
}
