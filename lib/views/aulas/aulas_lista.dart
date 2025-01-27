// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors

import 'package:controle_alunos_musica_ft/components/date_picker.dart';
import 'package:controle_alunos_musica_ft/models/aulas.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_lista_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AulasLista extends StatefulWidget {
  DateTime? dtIniFiltro;
  DateTime? dtFimFiltro;

  AulasLista({super.key, this.dtIniFiltro, this.dtFimFiltro});

  @override
  State<AulasLista> createState() => _AulasListaState();
}

class _AulasListaState extends State<AulasLista> {
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateFormat formatter2 = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    var back = AulasListaBack(context, widget.dtIniFiltro, widget.dtFimFiltro);
    back.dataIni = widget.dtIniFiltro ?? DateTime.now();
    back.dataFim = widget.dtFimFiltro ?? DateTime.now();

    return Scaffold(
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
                      context,
                      aula,
                      formatter.format(back.dataIni!),
                      formatter.format(back.dataFim!),
                      back.aluno);
                })
          ]),
      body: Column(children: [
        const SizedBox(height: 10),
        Observer(
          builder: (a) => Column(
            children: [
              Visibility(
                visible: back.aluno == null,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DatePicker(
                          label: "Início",
                          dateInit: back.dataIni!,
                          tipoData: 0,
                          onDateTimeChanged: (dt) {
                            widget.dtIniFiltro = dt;
                            back.onCarregaLista(
                              formatter.format(back.dataIni!),
                              formatter.format(back.dataFim!),
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
                              formatter.format(back.dataIni!),
                              formatter.format(back.dataFim!),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              aulasLista(back),
            ],
          ),
        ),
      ]),
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
                    ? tileAulas(aula, context, back)
                    : tileAulasAluno(aula, context, back);
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListTile tileAulas(Aulas aula, BuildContext context, AulasListaBack back) {
    return ListTile(
      dense: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            aula.aluno.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            formatter2.format(aula.data),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(aula.tipo.toString(), style: const TextStyle(fontSize: 15)),
              Text(aula.concluidoStr.toString(),
                  style: const TextStyle(fontSize: 15)),
            ],
          ),
          Text(aula.assunto!,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
      trailing: DeleteButton(context, back, aula),
      onTap: () {
        back.onGoToForm(context, aula, formatter.format(back.dataIni!),
            formatter.format(back.dataFim!), back.aluno);
      },
    );
  }

  ListTile tileAulasAluno(
      Aulas aula, BuildContext context, AulasListaBack back) {
    return ListTile(
      dense: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatter2.format(aula.data),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            aula.tipo.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            aula.concluidoStr.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(aula.assunto.toString(),
                  style: const TextStyle(fontSize: 15)),
            ],
          ),
        ],
      ),
      trailing: DeleteButton(context, back, aula),
      onTap: () {
        back.onGoToForm(context, aula, formatter.format(back.dataIni!),
            formatter.format(back.dataFim!), back.aluno);
      },
    );
  }

  Widget DeleteButton(BuildContext context, AulasListaBack back, Aulas aula) {
    return IconButton(
      icon: const Icon(FontAwesomeIcons.solidTrashCan),
      color: Colors.red,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exclusão"),
            content: const Text("Deseja excluir este registro?"),
            actions: [
              TextButton(
                  child: const Text("Não"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              TextButton(
                child: const Text("Sim"),
                onPressed: () {
                  back.onDelete(aula.idAula!, formatter.format(back.dataIni!),
                      formatter.format(back.dataFim!), back.aluno);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
