import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:f_contact_ex/store/add_contact_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddContactPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _addContactStore = Modular.get<AddContactStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to
              .pop<ContactInsertParams>(_addContactStore.contactInsertParams);
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
                    onChanged: (newName) => _addContactStore.name = newName,
                  ),
                ),
                Observer(
                  builder: (_) => TextFormField(
                    decoration: const InputDecoration(hintText: 'Email'),
                    onChanged: (newEmail) => _addContactStore.email = newEmail,
                  ),
                ),
                Observer(
                  builder: (_) => TextFormField(
                    decoration: const InputDecoration(hintText: 'Telefone'),
                    onChanged: (newPhone) => _addContactStore.phone = newPhone,
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
