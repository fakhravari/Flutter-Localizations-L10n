import 'package:flutter/material.dart';
import 'package:localizations/Localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  localRepository.Loadlocal();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: LocalizationsApp.localChangeNotifier,
      builder: (BuildContext context, value, Widget? child) {
        print(value.toString());
        return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: value,
            debugShowCheckedModeBanner: false,
            home: RegistrationForm());
      },
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  DateTime? _birthdate;
  String? _gender;
  String? _city;
  String? _state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                await localRepository.Setlocal('ar');
                setState(() {});
              },
              child: const Text('Ar')),
          const SizedBox(
            width: 5,
          ),
          ElevatedButton(
              onPressed: () async {
                await localRepository.Setlocal('fa');
                setState(() {});
              },
              child: const Text('Fa')),
          const SizedBox(
            width: 5,
          ),
          ElevatedButton(
              onPressed: () async {
                await localRepository.Setlocal('en');
                setState(() {});
              },
              child: const Text('En')),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: context.l10n.name,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return context.l10n.plaseentername;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: context.l10n.email,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return context.l10n.plaseenteremail;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: context.l10n.password,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return context.l10n.plaseenterpass;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text(context.l10n.dateofbirth),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            _birthdate = value;
                          });
                        }
                      });
                    },
                    child: Text(
                      _birthdate == null
                          ? context.l10n.selectdateofbirth
                          : '${_birthdate!.day}/${_birthdate!.month}/${_birthdate!.year}',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(context.l10n.gender),
                  Row(
                    children: <Widget>[
                      Radio(
                        value: context.l10n.male,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text(context.l10n.male),
                      Radio(
                        value: context.l10n.femele,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      Text(context.l10n.femele),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: context.l10n.city,
                    ),
                    onSaved: (value) {
                      _city = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: context.l10n.state,
                    ),
                    onSaved: (value) {
                      _state = value;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                      child: Text(context.l10n.submit),
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
