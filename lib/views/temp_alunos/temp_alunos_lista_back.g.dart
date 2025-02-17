// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temp_alunos_lista_back.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TempAlunosListaBack on _TempAlunosListaBack, Store {
  late final _$lstEntitiesAtom =
      Atom(name: '_TempAlunosListaBack.lstEntities', context: context);

  @override
  List<TempAlunos>? get lstTempAlunos {
    _$lstEntitiesAtom.reportRead();
    return super.lstTempAlunos;
  }

  @override
  set lstTempAlunos(List<TempAlunos>? value) {
    _$lstEntitiesAtom.reportWrite(value, super.lstTempAlunos, () {
      super.lstTempAlunos = value;
    });
  }

  late final _$isSearchingAtom =
      Atom(name: '_TempAlunosListaBack.isSearching', context: context);

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

  late final _$carregaTempAlunosListaAsyncAction = AsyncAction(
      '_TempAlunosListaBack.carregaTempAlunosLista',
      context: context);

  @override
  Future carregaTempAlunosLista([dynamic textPesquisa]) {
    return _$carregaTempAlunosListaAsyncAction
        .run(() => super.carregaTempAlunosLista(textPesquisa));
  }

  late final _$_TempAlunosListaBackActionController =
      ActionController(name: '_TempAlunosListaBack', context: context);

  @override
  dynamic onSelectTempAluno(int idAluno) {
    final _$actionInfo = _$_TempAlunosListaBackActionController.startAction(
        name: '_TempAlunosListaBack.onSelectTempAluno');
    try {
      return super.onSelectTempAluno(idAluno);
    } finally {
      _$_TempAlunosListaBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startSearch(BuildContext context) {
    final _$actionInfo = _$_TempAlunosListaBackActionController.startAction(
        name: '_TempAlunosListaBack.startSearch');
    try {
      return super.startSearch(context);
    } finally {
      _$_TempAlunosListaBackActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lstEntities: ${lstTempAlunos},
isSearching: ${isSearching}
    ''';
  }
}
