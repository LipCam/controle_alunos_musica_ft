// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aulas_lista_back.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AulasListaBack on _AulasListaBack, Store {
  late final _$lstEntitiesAtom =
      Atom(name: '_AulasListaBack.lstEntities', context: context);

  @override
  Future<List<Aulas>>? get lstEntities {
    _$lstEntitiesAtom.reportRead();
    return super.lstEntities;
  }

  @override
  set lstEntities(Future<List<Aulas>>? value) {
    _$lstEntitiesAtom.reportWrite(value, super.lstEntities, () {
      super.lstEntities = value;
    });
  }

  late final _$dataIniAtom =
      Atom(name: '_AulasListaBack.dataIni', context: context);

  @override
  DateTime? get dataIni {
    _$dataIniAtom.reportRead();
    return super.dataIni;
  }

  @override
  set dataIni(DateTime? value) {
    _$dataIniAtom.reportWrite(value, super.dataIni, () {
      super.dataIni = value;
    });
  }

  late final _$dataFimAtom =
      Atom(name: '_AulasListaBack.dataFim', context: context);

  @override
  DateTime? get dataFim {
    _$dataFimAtom.reportRead();
    return super.dataFim;
  }

  @override
  set dataFim(DateTime? value) {
    _$dataFimAtom.reportWrite(value, super.dataFim, () {
      super.dataFim = value;
    });
  }

  late final _$_AulasListaBackActionController =
      ActionController(name: '_AulasListaBack', context: context);

  @override
  dynamic onCarregaLista(
      [dynamic dataIni, dynamic dataFim, int? iD_ALUNO_INT]) {
    final _$actionInfo = _$_AulasListaBackActionController.startAction(
        name: '_AulasListaBack.onCarregaLista');
    try {
      return super.onCarregaLista(dataIni, dataFim, iD_ALUNO_INT);
    } finally {
      _$_AulasListaBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lstEntities: ${lstEntities},
dataIni: ${dataIni},
dataFim: ${dataFim}
    ''';
  }
}
