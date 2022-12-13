// ignore_for_file: use_key_in_widget_constructors

import 'package:controle_alunos_musica_ft/config/app_images.dart';
import 'package:controle_alunos_musica_ft/config/my_app.dart';
import 'package:controle_alunos_musica_ft/views/home/widgets/menu_button_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double espacamento = 20;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Controle Alunos"),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.wallpaperHome),
                  fit: BoxFit.fill)),
          padding: EdgeInsets.all(espacamento),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: espacamento,
            crossAxisSpacing: espacamento,
            children: [
              MenuButtonWidget(
                  "Aluno", AppImages.icMenuAlunos, MyApp().alunosLista),
              MenuButtonWidget(
                  "Aulas", AppImages.icMenuAulas, MyApp().aulasLista),
            ],
          ),
        ));
  }
}
