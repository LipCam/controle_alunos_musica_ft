import 'package:controle_alunos_musica_ft/core/my_app.dart';
import 'package:controle_alunos_musica_ft/database/dao/aulas_dao.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/entities/aulas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'aulas_lista_back.g.dart';

class AulasListaBack = _AulasListaBack with _$AulasListaBack;

abstract class _AulasListaBack with Store {
  var _dao = AulasDAO();
  Alunos? aluno;
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  _AulasListaBack(BuildContext context) {
    var arguments = ModalRoute.of(context)?.settings.arguments;
    aluno = arguments != null ? arguments as Alunos : null;
    DataIni = DateTime.now();
    DataFim = DateTime.now();
    CarregaLista(formatter.format(DataIni!), formatter.format(DataFim!),
        aluno?.ID_ALUNO_INT);
  }

  @observable
  Future<List<Aulas>>? lstEntities;

  @action
  CarregaLista([dynamic DataIni, dynamic DataFim, int? ID_ALUNO_INT]) {
    DataIni = DataIni != null ? DataIni : formatter.format(this.DataIni!);
    DataFim = DataFim != null ? DataFim : formatter.format(this.DataFim!);
    lstEntities = _dao.GetLista(DataIni, DataFim, ID_ALUNO_INT);
  }

  @observable
  DateTime? DataIni;

  setDataIni(DateTime dt) {
    DataIni = dt;
  }

  @observable
  DateTime? DataFim;

  setDataFim(DateTime dt) {
    DataFim = dt;
  }

  GoToForm(BuildContext context, Aulas? aula, String DataIni, String DataFim,
      Alunos? aluno) {
    Navigator.of(context)
        .pushNamed(MyApp().AULAS_FORM, arguments: aula)
        .then(((value) => CarregaLista(DataIni, DataFim, aluno?.ID_ALUNO_INT)));
  }

  Delete(int id, String DataIni, String DataFim, Alunos? aluno) {
    _dao.Delete(id);
    CarregaLista(DataIni, DataFim, aluno?.ID_ALUNO_INT);
  }
}
