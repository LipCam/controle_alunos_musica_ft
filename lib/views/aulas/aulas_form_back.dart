// ignore_for_file: library_private_types_in_public_api

import 'package:controle_alunos_musica_ft/database/dao/aulas_dao.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/entities/aulas.dart';
import 'package:controle_alunos_musica_ft/entities/tipos_aula.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'aulas_form_back.g.dart';

class AulasFormBack = _AulasFormBack with _$AulasFormBack;

abstract class _AulasFormBack with Store {
  Aulas? aula;
  final _dao = AulasDAO();

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

  Future<List<Alunos>> onGetAlunos() {
    return _dao.onGetAlunos();
  }

  Future<List<TiposAula>> onGetTipos() {
    return _dao.onGetTipos();
  }

  Future<int> onSave() async {
    return await _dao.onSave(aula!);
  }

  onDelete(int id) {
    _dao.onDelete(id);
  }
}
