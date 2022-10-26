import 'package:controle_alunos_musica_ft/views/alunos/alunos_form.dart';
import 'package:controle_alunos_musica_ft/views/alunos/alunos_lista.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_form.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_lista.dart';
import 'package:controle_alunos_musica_ft/views/home/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final String HOME = "/";
  final String ALUNOS_LISTA = "alunos_lista";
  final String ALUNOS_FORM = "alunos_form";
  final String AULAS_LISTA = "aulas_lista";
  final String AULAS_FORM = "aulas_form";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle Alunos Música FT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HOME: (context) => HomePage(),
        ALUNOS_LISTA: (context) => AlunosLista(),
        ALUNOS_FORM: (context) => AlunosForm(),
        AULAS_LISTA: (context) => AulasLista(),
        AULAS_FORM: (context) => AulasForm(),
      },
    );
  }

  //testetsete
}
