// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:controle_alunos_musica_ft/config/app_images.dart';
import 'package:controle_alunos_musica_ft/views/alunos/alunos_lista.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_lista.dart';
import 'package:controle_alunos_musica_ft/views/home/home_page_back.dart';
import 'package:controle_alunos_musica_ft/views/instrutores/instrutores_lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatelessWidget {
  HomePageBack back = HomePageBack();
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Controle Alunos"),
      // ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.wallpaperHome), fit: BoxFit.fill),
            ),
          ),
          AlunosLista(),
          InstrutoresLista(),
          AulasLista()
        ],
      ),
      bottomNavigationBar: Observer(
        builder: (context) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: back.currentPage,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap: (value) {
            back.currentPage = value;
            pageController.jumpToPage(back.currentPage);
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Alunos",
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              label: "Instrutores",
              icon: Icon(Icons.school),
            ),
            BottomNavigationBarItem(
              label: "Aulas",
              icon: Icon(Icons.music_note_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
