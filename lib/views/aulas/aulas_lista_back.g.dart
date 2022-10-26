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

  late final _$DataIniAtom =
      Atom(name: '_AulasListaBack.DataIni', context: context);

  @override
  DateTime? get DataIni {
    _$DataIniAtom.reportRead();
    return super.DataIni;
  }

  @override
  set DataIni(DateTime? value) {
    _$DataIniAtom.reportWrite(value, super.DataIni, () {
      super.DataIni = value;
    });
  }

  late final _$DataFimAtom =
      Atom(name: '_AulasListaBack.DataFim', context: context);

  @override
  DateTime? get DataFim {
    _$DataFimAtom.reportRead();
    return super.DataFim;
  }

  @override
  set DataFim(DateTime? value) {
    _$DataFimAtom.reportWrite(value, super.DataFim, () {
      super.DataFim = value;
    });
  }

  late final _$_AulasListaBackActionController =
      ActionController(name: '_AulasListaBack', context: context);

  @override
  dynamic CarregaLista([dynamic DataIni, dynamic DataFim, int? ID_ALUNO_INT]) {
    final _$actionInfo = _$_AulasListaBackActionController.startAction(
        name: '_AulasListaBack.CarregaLista');
    try {
      return super.CarregaLista(DataIni, DataFim, ID_ALUNO_INT);
    } finally {
      _$_AulasListaBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lstEntities: ${lstEntities},
DataIni: ${DataIni},
DataFim: ${DataFim}
    ''';
  }
}
