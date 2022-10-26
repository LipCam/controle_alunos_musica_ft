import 'package:controle_alunos_musica_ft/core/app_images.dart';
import 'package:controle_alunos_musica_ft/core/my_app.dart';
import 'package:controle_alunos_musica_ft/views/home/widgets/menu_button_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double espacamento = 20;

    return Scaffold(
        appBar: AppBar(
          title: Text("Controle Alunos"),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.wallpaper_home),
                  fit: BoxFit.fill)),
          padding: EdgeInsets.all(espacamento),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: espacamento,
            crossAxisSpacing: espacamento,
            children: [
              MenuButtonWidget(
                  "Aluno", AppImages.ic_menu_alunos, MyApp().ALUNOS_LISTA),
              MenuButtonWidget(
                  "Aulas", AppImages.ic_menu_aulas, MyApp().AULAS_LISTA),
            ],
          ),
        ));
  }
}
