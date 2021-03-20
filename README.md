Apps developed as assignments for the "PROGRAMACAO PARA DISPOSITIVOS MOVEIS" undergrad course. Do not give the code too much attention; these small projects by no means aim at code quality.

All the projects here are null-safe unless stated otherwise.

## Projects

### [f_count](f_count/)
This project updates the number of occupied seats in a restaurant and checks their availability.

### [f_imc](f_imc/)
This is your average IMC calculator.

### [f_vespa](f_vespa/)
This app shows real-time changes on stock prices from the Bovespa stocks index. It uses data coming from the [hgbrasil](https://www.hgbrasil.com)'s API.

#### Flutter features showcased
- Web API consuming;
- Animations (by extending AnimatedWidget);
- CustomPainter.

#### How to build
If you want to build the project, you have to set the variable `_kApiKey` in the [lib/api/http.dart](f_vespa/lib/api/http.dart) file to an actual API key from hgbrasil.

### [f_list](f_list/)
Your almost-average todo list app. 

#### Features
- Local storage persistence.

#### Flutter features showcased
- Snackbar;
- Dismissible items;
- RefreshIndicator;
- Persistence in the documents path.

### [f_contact](f_contact_ex/) (Flutter 2.0)
Your slightly-above-average contact list app.

This app was built with [mobx](https://pub.dev/packages/mobx) for state management and [flutter_modular](https://pub.dev/packages/flutter_modular) for depency injection and navigation. I had some problems because, by the time I made the app, [mobx_codegen](https://pub.dev/packages/mobx_codegen) didn't have a stable null-safe version, and flutter_modular's latest version was kinda unstable as well.

#### Features
- Local storage persistence with SQLite.
- Saving a photo from camera for each contact.
