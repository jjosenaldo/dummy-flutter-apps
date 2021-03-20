import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:f_contact_ex/store/contact_page_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum ContactPageType {
  insert,
  edit,
}

class ContactPageParams {
  ContactPageParams({required this.pageType});
  final ContactPageType pageType;
}

class ContactPage extends StatelessWidget {
  ContactPage(
    this.params, {
    Key? key,
  })  : _pageType = params.pageType,
        super(key: key);

  final ContactPageType _pageType;
  final ContactPageParams params;

  final _formKey = GlobalKey<FormState>();
  final _contactStore = Modular.get<ContactPageStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (_pageType) {
            case ContactPageType.insert:
              Modular.to.pop<ContactInsertParams>(
                _contactStore.contactInsertParams,
              );
              break;
            case ContactPageType.edit:
              Modular.to.pop<ContactUpdateByIdParams>(
                _contactStore.contactUpdateByIdParams,
              );
              break;
          }
        },
        child: Icon(Icons.save),
      ),
      appBar: AppBar(
        title: Text('Novo contato'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.person),
                Observer(
                  builder: (_) => TextFormField(
                    decoration: const InputDecoration(hintText: 'Nome'),
                    onChanged: (newName) => _contactStore.name = newName,
                    initialValue: _contactStore.originalName,
                  ),
                ),
                Observer(
                  builder: (_) => TextFormField(
                    decoration: const InputDecoration(hintText: 'Email'),
                    onChanged: (newEmail) => _contactStore.email = newEmail,
                    initialValue: _contactStore.originalEmail,
                  ),
                ),
                Observer(
                  builder: (_) => TextFormField(
                    decoration: const InputDecoration(hintText: 'Telefone'),
                    onChanged: (newPhone) => _contactStore.phone = newPhone,
                    initialValue: _contactStore.originalPhone,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
