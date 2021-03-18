import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:f_contact_ex/store/contact_page_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactPage extends StatelessWidget {
  ContactPage({
    Key? key,
    this.contact,
  }) : super(key: key);

  final Contact? contact;

  final _formKey = GlobalKey<FormState>();
  final _contactStore = Modular.get<ContactPageStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to
              .pop<ContactInsertParams>(_contactStore.contactInsertParams);
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
                  ),
                ),
                Observer(
                  builder: (_) => TextFormField(
                    decoration: const InputDecoration(hintText: 'Email'),
                    onChanged: (newEmail) => _contactStore.email = newEmail,
                  ),
                ),
                Observer(
                  builder: (_) => TextFormField(
                    decoration: const InputDecoration(hintText: 'Telefone'),
                    onChanged: (newPhone) => _contactStore.phone = newPhone,
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
