// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aulas_form_back.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AulasFormBack on _AulasFormBack, Store {
  late final _$NovoRegAtom =
      Atom(name: '_AulasFormBack.NovoReg', context: context);

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

  late final _$DataAtom = Atom(name: '_AulasFormBack.Data', context: context);

  @override
  DateTime? get Data {
    _$DataAtom.reportRead();
    return super.Data;
  }

  @override
  set Data(DateTime? value) {
    _$DataAtom.reportWrite(value, super.Data, () {
      super.Data = value;
    });
  }

  late final _$ConcluidoAtom =
      Atom(name: '_AulasFormBack.Concluido', context: context);

  @override
  bool? get Concluido {
    _$ConcluidoAtom.reportRead();
    return super.Concluido;
  }

  @override
  set Concluido(bool? value) {
    _$ConcluidoAtom.reportWrite(value, super.Concluido, () {
      super.Concluido = value;
    });
  }

  @override
  String toString() {
    return '''
NovoReg: ${NovoReg},
Data: ${Data},
Concluido: ${Concluido}
    ''';
  }
}
