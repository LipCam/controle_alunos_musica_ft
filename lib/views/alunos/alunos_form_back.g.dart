// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alunos_form_back.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AlunosFormBack on _AlunosFormBack, Store {
  late final _$NovoRegAtom =
      Atom(name: '_AlunosFormBack.NovoReg', context: context);

  @override
  bool get NovoReg {
    _$NovoRegAtom.reportRead();
    return super.NovoReg;
  }

  @override
  set NovoReg(bool value) {
    _$NovoRegAtom.reportWrite(value, super.NovoReg, () {
      super.NovoReg = value;
    });
  }

  late final _$DataNascAtom =
      Atom(name: '_AlunosFormBack.DataNasc', context: context);

  @override
  DateTime? get DataNasc {
    _$DataNascAtom.reportRead();
    return super.DataNasc;
  }

  @override
  set DataNasc(DateTime? value) {
    _$DataNascAtom.reportWrite(value, super.DataNasc, () {
      super.DataNasc = value;
    });
  }

  late final _$DataBatismoAtom =
      Atom(name: '_AlunosFormBack.DataBatismo', context: context);

  @override
  DateTime? get DataBatismo {
    _$DataBatismoAtom.reportRead();
    return super.DataBatismo;
  }

  @override
  set DataBatismo(DateTime? value) {
    _$DataBatismoAtom.reportWrite(value, super.DataBatismo, () {
      super.DataBatismo = value;
    });
  }

  late final _$DataIniGemAtom =
      Atom(name: '_AlunosFormBack.DataIniGem', context: context);

  @override
  DateTime? get DataIniGem {
    _$DataIniGemAtom.reportRead();
    return super.DataIniGem;
  }

  @override
  set DataIniGem(DateTime? value) {
    _$DataIniGemAtom.reportWrite(value, super.DataIniGem, () {
      super.DataIniGem = value;
    });
  }

  late final _$DataOficializacaoAtom =
      Atom(name: '_AlunosFormBack.DataOficializacao', context: context);

  @override
  DateTime? get DataOficializacao {
    _$DataOficializacaoAtom.reportRead();
    return super.DataOficializacao;
  }

  @override
  set DataOficializacao(DateTime? value) {
    _$DataOficializacaoAtom.reportWrite(value, super.DataOficializacao, () {
      super.DataOficializacao = value;
    });
  }

  @override
  String toString() {
    return '''
NovoReg: ${NovoReg},
DataNasc: ${DataNasc},
DataBatismo: ${DataBatismo},
DataIniGem: ${DataIniGem},
DataOficializacao: ${DataOficializacao}
    ''';
  }
}
