// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/config/app_dimensions.dart';
import 'package:controle_alunos_musica_ft/views/home/alunos_dash_tab.dart';
import 'package:controle_alunos_musica_ft/views/home/aulas_dash_tab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final void Function()? setAulaFiltroHoje;
  final void Function()? setAulaFiltroMes;
  final void Function()? setAulaFiltroAno;

  const HomePage({
    super.key,
    this.setAulaFiltroHoje,
    this.setAulaFiltroMes,
    this.setAulaFiltroAno,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Controle Alunos"),
          backgroundColor: AppColors.appBarBackGround,
          foregroundColor: AppColors.appBarFontColor,
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.music),
                    SizedBox(width: 10),
                    Text(
                      "Aulas",
                      style: TextStyle(fontSize: AppDimensions.homeTabFontSize),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.person),
                    SizedBox(width: 10),
                    Text(
                      "Alunos",
                      style: TextStyle(fontSize: AppDimensions.homeTabFontSize),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          AulasDashTab(
            setAulaFiltroHoje: widget.setAulaFiltroHoje,
            setAulaFiltroMes: widget.setAulaFiltroMes,
            setAulaFiltroAno: widget.setAulaFiltroAno,
          ),
          AlunosDashTab(),
        ]),
      ),
    );
  }
}
