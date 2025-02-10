// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors

import 'package:controle_alunos_musica_ft/components/date_picker.dart';
import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/models/aulas.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_lista_back.dart';
import 'package:controle_alunos_musica_ft/views/aulas/components/aulas_aluno_tile.dart';
import 'package:controle_alunos_musica_ft/views/aulas/components/aulas_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AulasLista extends StatefulWidget {
  DateTime? dtIniFiltro;
  DateTime? dtFimFiltro;

  AulasLista({super.key, this.dtIniFiltro, this.dtFimFiltro});

  @override
  State<AulasLista> createState() => _AulasListaState();
}

class _AulasListaState extends State<AulasLista> {
  @override
  Widget build(BuildContext context) {
    var back = AulasListaBack(context, widget.dtIniFiltro, widget.dtFimFiltro);
    back.dataIni = widget.dtIniFiltro ?? DateTime.now();
    back.dataFim = widget.dtFimFiltro ?? DateTime.now();

    return Scaffold(
      backgroundColor: AppColors.scafoldBackGround,
      appBar: AppBar(
          title: Text(
              "Aulas${back.aluno != null ? " - ${back.aluno!.nome}" : ""}"),
          actions: [
            IconButton(
                icon: const Icon(FontAwesomeIcons.plus),
                tooltip: "Novo",
                onPressed: () {
                  Aulas aula = Aulas(
                      idAluno: back.aluno?.idAluno,
                      concluido: false,
                      data: DateTime.now());
                  back.onGoToForm(
                      context, aula, back.dataIni!, back.dataFim!, back.aluno);
                })
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Observer(
          builder: (a) => Column(
            children: [
              Visibility(
                visible: back.aluno == null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DatePicker(
                      label: "Início",
                      dateInit: back.dataIni!,
                      tipoData: 0,
                      onDateTimeChanged: (dt) {
                        widget.dtIniFiltro = dt;
                        back.onCarregaLista(
                          back.dataIni!,
                          back.dataFim!,
                        );
                      },
                    ),
                    DatePicker(
                      label: "Fim",
                      dateInit: back.dataFim!,
                      tipoData: 0,
                      onDateTimeChanged: (dt) {
                        widget.dtFimFiltro = dt;
                        back.onCarregaLista(
                          back.dataIni!,
                          back.dataFim!,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(child: aulasLista(back)),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder aulasLista(AulasListaBack back) {
    return FutureBuilder(
      future: back.lstEntities,
      builder: (context, future) {
        if (future.hasData) {
          List<Aulas> lst = future.data;
          return ListView.builder(
              itemCount: lst.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                Aulas aula = lst[i];
                return back.aluno == null
                    ? AulasTile(aula: aula, back: back)
                    : AulasAlunoTile(aula: aula, back: back);
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
