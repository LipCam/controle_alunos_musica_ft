// ignore_for_file: use_key_in_widget_constructors

import 'package:controle_alunos_musica_ft/config/app_colors.dart';
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
        primaryColor: AppColors.appBarFontColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.appBarBackGround,
          foregroundColor: AppColors.appBarFontColor,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.cursorColor, // Cor do cursor piscante
          selectionColor:
              AppColors.cursorColor.withOpacity(0.4), // Cor da seleção
          selectionHandleColor:
              AppColors.cursorColor, // Cor do marcador da seleção
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.cursorColor; // Cor padrão quando selecionado
            }
            return Colors.grey; // Cor padrão quando não selecionado
          }),
        ),
        inputDecorationTheme: InputDecorationTheme(
          // Borda quando focado
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.cursorColor,
              width: 2,
            ),
          ),
          labelStyle: const TextStyle(color: Color(0xFF000000)),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.cursorColor, // Cor do texto do botão
            backgroundColor: Colors.transparent, // Fundo transparente
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ), // Espaçamento interno
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ), // Estilo do texto
          ),
        ),
        tabBarTheme: const TabBarTheme(
          dividerColor: Color.fromARGB(255, 83, 78, 78),
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          circularTrackColor: AppColors.cursorColor,
        ),
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
