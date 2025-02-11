// ignore_for_file: library_private_types_in_public_api

import 'package:controle_alunos_musica_ft/database/repositories/alunos_repository.dart';
import 'package:controle_alunos_musica_ft/database/repositories/aulas_repository.dart';
import 'package:controle_alunos_musica_ft/database/repositories/instrutores_repository.dart';
import 'package:controle_alunos_musica_ft/models/alunos.dart';
import 'package:controle_alunos_musica_ft/models/aulas.dart';
import 'package:controle_alunos_musica_ft/models/instrutores.dart';
import 'package:controle_alunos_musica_ft/models/tipos_aula.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'aulas_form_back.g.dart';

class AulasFormBack = _AulasFormBack with _$AulasFormBack;

abstract class _AulasFormBack with Store {
  Aulas? aula;
  final _dao = AulasRepository();
  final _daoAlunos = AlunosRepository();
  final _daoInstrutores = InstrutoresRepository();

  _AulasFormBack(BuildContext context) {
    aula = ModalRoute.of(context)?.settings.arguments as Aulas;
    //var parameter = ModalRoute.of(context)?.settings.arguments;
    // aula = parameter == null
    //     ? Aulas(CONCLUIDO_BIT: false, DATA_DTI: DateTime.now())
    //     : parameter as Aulas;
    novoReg = aula?.idAula == null;
  }

  @observable
  bool novoReg = true;

  Future<List<Alunos>> onGetAlunosCmb() {
    return _daoAlunos.onGetCmb();
  }

  Future<List<TiposAula>> onGetTiposCmb() {
    return _dao.onGetTiposCmb();
  }

  Future<List<Instrutores>> onGetInstrutoresCmb() {
    return _daoInstrutores.onGetCmb();
  }

  Future<int> onSave() async {
    return await _dao.onSave(aula!);
  }

  ///Validadores
  String? validaAluno(dynamic idAluno) {
    if (idAluno == null) return "Informe o Aluno";
    return null;
  }

  String? validaInstrutor(dynamic idInstrutor) {
    if (idInstrutor == null) return "Informe o Instrutor";
    return null;
  }

  String? validaAssunto(dynamic assunto) {
    if (assunto == null || assunto == "") return "Informe o Assunto";
    return null;
  }

  onDelete(int id) {
    _dao.onDelete(id);
  }
}
