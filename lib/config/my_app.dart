// ignore_for_file: use_key_in_widget_constructors

import 'package:controle_alunos_musica_ft/views/alunos/alunos_form.dart';
import 'package:controle_alunos_musica_ft/views/alunos/alunos_lista.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_form.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_lista.dart';
import 'package:controle_alunos_musica_ft/views/base/base_page.dart';
import 'package:controle_alunos_musica_ft/views/home/home_page.dart';
import 'package:controle_alunos_musica_ft/views/instrutores/instrutores_form.dart';
import 'package:controle_alunos_musica_ft/views/instrutores/instrutores_lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  final String base = "base";
  final String home = "home";
  final String alunosLista = "alunos_lista";
  final String alunosForm = "alunos_form";
  final String instrutoresLista = "instrutores_lista";
  final String instrutoresForm = "instrutores_form";
  final String aulasLista = "aulas_lista";
  final String aulasForm = "aulas_form";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Controle Alunos Música FT',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale("pt", "BR")],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: base,
      routes: {
        base: (context) => BasePage(),
        home: (context) => const HomePage(),
        alunosLista: (context) => AlunosLista(),
        alunosForm: (context) => AlunosForm(),
        instrutoresLista: (context) => InstrutoresLista(),
        instrutoresForm: (context) => InstrutoresForm(),
        aulasLista: (context) => AulasLista(),
        aulasForm: (context) => AulasForm(),
      },
    );
  }
}
