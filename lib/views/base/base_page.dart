// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/views/alunos/alunos_lista.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_lista.dart';
import 'package:controle_alunos_musica_ft/views/base/base_page_back.dart';
import 'package:controle_alunos_musica_ft/views/home/home_page.dart';
import 'package:controle_alunos_musica_ft/views/instrutores/instrutores_lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BasePage extends StatefulWidget {
  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  BasePageBack back = BasePageBack();
  PageController pageController = PageController();

  DateTime? dtIniFiltro;
  DateTime? dtFimFiltro;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: back.currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(
            setAulaFiltroHoje: () {
              setAulaFiltroHoje();
            },
            setAulaFiltroMes: () {
              setAulaFiltroMes();
            },
            setAulaFiltroAno: () {
              setAulaFiltroAno();
            },
          ),
          AlunosLista(),
          InstrutoresLista(),
          AulasLista(
            dtIniFiltro: dtIniFiltro,
            dtFimFiltro: dtFimFiltro,
          )
        ],
      ),
      bottomNavigationBar: Observer(
        builder: (context) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: back.currentPage,
          backgroundColor: AppColors.appBarBackGround,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap: (value) {
            if (value == back.currentPage) return;

            if (value == 3) {
              setState(() {
                dtIniFiltro = null;
                dtFimFiltro = null;
              });
            }

            back.currentPage = value;
            pageController.jumpToPage(back.currentPage);
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(FontAwesomeIcons.house),
            ),
            BottomNavigationBarItem(
              label: "Alunos",
              icon: Icon(FontAwesomeIcons.person),
              tooltip: "Cad Alunos",
            ),
            BottomNavigationBarItem(
              label: "Instrutores",
              icon: Icon(FontAwesomeIcons.chalkboardUser),
            ),
            BottomNavigationBarItem(
              label: "Aulas",
              icon: Icon(FontAwesomeIcons.music),
            ),
          ],
        ),
      ),
    );
  }

  setAulaFiltroHoje() {
    setState(() {
      back.currentPage = 3;
      pageController.jumpToPage(back.currentPage);
      dtIniFiltro = null;
      dtFimFiltro = null;
    });
  }

  setAulaFiltroMes() {
    setState(() {
      back.currentPage = 3;
      pageController.jumpToPage(back.currentPage);
      dtIniFiltro = DateTime(DateTime.now().year, DateTime.now().month, 1);
      dtFimFiltro = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
    });
  }

  setAulaFiltroAno() {
    setState(() {
      back.currentPage = 3;
      pageController.jumpToPage(back.currentPage);
      dtIniFiltro = DateTime(DateTime.now().year, 1, 1);
      dtFimFiltro = DateTime(DateTime.now().year, 12, 31);
    });
  }
}
