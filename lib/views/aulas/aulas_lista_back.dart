// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:controle_alunos_musica_ft/config/my_app.dart';
import 'package:controle_alunos_musica_ft/database/dao/aulas_dao.dart';
import 'package:controle_alunos_musica_ft/models/alunos.dart';
import 'package:controle_alunos_musica_ft/models/aulas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'aulas_lista_back.g.dart';

class AulasListaBack = _AulasListaBack with _$AulasListaBack;

abstract class _AulasListaBack with Store {
  final _dao = AulasDAO();
  Alunos? aluno;
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  _AulasListaBack(BuildContext context, DateTime? dtIni, DateTime? dtFim) {
    var arguments = ModalRoute.of(context)?.settings.arguments;
    aluno = arguments != null ? arguments as Alunos : null;
    dataIni = dtIni ?? DateTime.now();
    dataFim = dtFim ?? DateTime.now();
    onCarregaLista(
        formatter.format(dataIni!), formatter.format(dataFim!), aluno?.idAluno);
  }

  @observable
  Future<List<Aulas>>? lstEntities;

  @action
  onCarregaLista([dynamic dataIni, dynamic dataFim, int? iD_ALUNO_INT]) {
    dataIni = dataIni ?? formatter.format(this.dataIni!);
    dataFim = dataFim ?? formatter.format(this.dataFim!);
    lstEntities = _dao.onGetLista(dataIni, dataFim, iD_ALUNO_INT);
  }

  @observable
  DateTime? dataIni;

  @observable
  DateTime? dataFim;

  onGoToForm(BuildContext context, Aulas? aula, String dataIni, String dataFim,
      Alunos? aluno) {
    Navigator.of(context)
        .pushNamed(MyApp().aulasForm, arguments: aula)
        .then(((value) => onCarregaLista(dataIni, dataFim, aluno?.idAluno)));
  }

  onDelete(int id, String dataIni, String dataFim, Alunos? aluno) {
    _dao.onDelete(id);
    onCarregaLista(dataIni, dataFim, aluno?.idAluno);
  }
}
