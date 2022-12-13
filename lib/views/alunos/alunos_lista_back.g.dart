// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alunos_lista_back.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AlunosListaBack on _AlunosListaBack, Store {
  late final _$lstEntitiesAtom =
      Atom(name: '_AlunosListaBack.lstEntities', context: context);

  @override
  Future<List<Alunos>>? get lstEntities {
    _$lstEntitiesAtom.reportRead();
    return super.lstEntities;
  }

  @override
  set lstEntities(Future<List<Alunos>>? value) {
    _$lstEntitiesAtom.reportWrite(value, super.lstEntities, () {
      super.lstEntities = value;
    });
  }

  late final _$isSearchingAtom =
      Atom(name: '_AlunosListaBack.isSearching', context: context);

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  late final _$_AlunosListaBackActionController =
      ActionController(name: '_AlunosListaBack', context: context);

  @override
  dynamic carregaLista([dynamic textPesquisa]) {
    final _$actionInfo = _$_AlunosListaBackActionController.startAction(
        name: '_AlunosListaBack.carregaLista');
    try {
      return super.carregaLista(textPesquisa);
    } finally {
      _$_AlunosListaBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startSearch(BuildContext context) {
    final _$actionInfo = _$_AlunosListaBackActionController.startAction(
        name: '_AlunosListaBack.startSearch');
    try {
      return super.startSearch(context);
    } finally {
      _$_AlunosListaBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lstEntities: ${lstEntities},
isSearching: ${isSearching}
    ''';
  }
}
