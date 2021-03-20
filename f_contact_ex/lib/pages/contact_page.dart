import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:f_contact_ex/store/contact_page_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  Future<bool> showScreenCloseDialog(BuildContext context) => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Abandonar alteração?'),
          content: Text('Os dados serão perdidos.'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ).then((maybeResult) => maybeResult ?? false);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showScreenCloseDialog(context),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
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
                      validator: (maybeNome) =>
                          (maybeNome == null || maybeNome.isEmpty)
                              ? 'Campo obrigatório'
                              : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Observer(
                    builder: (_) => TextFormField(
                      decoration: const InputDecoration(hintText: 'Email'),
                      onChanged: (newEmail) => _contactStore.email = newEmail,
                      initialValue: _contactStore.originalEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (maybeEmail) => (maybeEmail == null ||
                              maybeEmail.isEmpty)
                          ? 'Campo obrigatório'
                          : RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(maybeEmail)
                              ? null
                              : 'Email inválido',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Observer(
                    builder: (_) => TextFormField(
                      decoration: const InputDecoration(hintText: 'Telefone'),
                      onChanged: (newPhone) => _contactStore.phone = newPhone,
                      initialValue: _contactStore.originalPhone,
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: '(##) #####-####',
                          filter: {"#": RegExp(r'[0-9]')},
                        ),
                      ],
                      keyboardType: TextInputType.number,
                      validator: (maybePhoneNumber) {
                        if (maybePhoneNumber == null ||
                            maybePhoneNumber.isEmpty) {
                          return 'Campo obrigatório';
                        }

                        if (maybePhoneNumber.length < 2 + 5 + 4 + 3 + 1) {
                          return 'Telefone incompleto';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
