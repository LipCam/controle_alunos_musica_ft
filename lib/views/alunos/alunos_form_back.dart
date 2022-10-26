import 'dart:typed_data';

import 'package:controle_alunos_musica_ft/core/my_app.dart';
import 'package:controle_alunos_musica_ft/database/dao/alunos_dao.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/entities/status_alunos.dart';
import 'package:controle_alunos_musica_ft/views/alunos/relatorio/relatorio_alunos.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'alunos_form_back.g.dart';

class AlunosFormBack = _AlunosFormBack with _$AlunosFormBack;

abstract class _AlunosFormBack with Store {
  Alunos? aluno;
  var _dao = AlunosDAO();

  _AlunosFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context)?.settings.arguments;
    aluno = parameter == null ? Alunos() : parameter as Alunos;
    setDataNasc(aluno?.DATA_NASCIMENTO_DTI);
    setDataBatismo(aluno?.DATA_BATISMO_DTI);
    setDataIniGem(aluno?.DATA_INICIO_GEM_DTI);
    setDataOficializacao(aluno?.DATA_OFICIALIZACAO_DTI);
    NovoReg = aluno?.ID_ALUNO_INT == null;
  }

  @observable
  bool NovoReg = true;

  @observable
  DateTime? DataNasc;
  bool TemDataNasc = false;

  setDataNasc(DateTime? dt) {
    DataNasc = dt;
    TemDataNasc = dt != null;
  }

  @observable
  DateTime? DataBatismo;
  bool TemDataBatismo = false;

  setDataBatismo(DateTime? dt) {
    DataBatismo = dt;
    TemDataBatismo = dt != null;
  }

  @observable
  DateTime? DataIniGem;
  bool TemDataIniGem = false;

  setDataIniGem(DateTime? dt) {
    DataIniGem = dt;
    TemDataIniGem = dt != null;
  }

  @observable
  DateTime? DataOficializacao;
  bool TemDataOficializacao = false;

  setDataOficializacao(DateTime? dt) {
    DataOficializacao = dt;
    TemDataOficializacao = dt != null;
  }

  Future<List<StatusAlunos>> GetStatus() {
    return _dao.GetStatus();
  }

  Future<int> Save() async {
    return await _dao.Save(aluno!);
  }

  String? validaNome(String? nome) {
    if (nome == null || nome == "") return "Informe o nome";
    return null;
  }

  Delete(int id) {
    _dao.Delete(id);
  }

  GoToAulasLista(BuildContext context, Alunos aluno) {
    Navigator.of(context).pushNamed(MyApp().AULAS_LISTA, arguments: aluno);
  }

  Future<void> GeraRelatorio(int ID_ALUNO_INT) async {
    RelatorioAlunos().GeraRelatorio(ID_ALUNO_INT);
  }
}
