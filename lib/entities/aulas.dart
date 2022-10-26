class Aulas {
  int? ID_AULA_INT;
  int? ID_ALUNO_INT;
  int? ID_TIPO_INT;
  String? INSTRUTOR_STR;
  DateTime DATA_DTI;
  bool CONCLUIDO_BIT;
  String? ASSUNTO_STR;
  String? OBSERVACAO_STR;
  DateTime? DATA_IMPORTACAO_DTI;

  String? ALUNO_STR;
  String? TIPO_STR;
  String? CONCLUIDO_STR;

  Aulas({
    this.ID_AULA_INT,
    this.ID_ALUNO_INT,
    this.ID_TIPO_INT,
    this.INSTRUTOR_STR,
    required this.DATA_DTI,
    required this.CONCLUIDO_BIT,
    this.ASSUNTO_STR,
    this.OBSERVACAO_STR,
    this.DATA_IMPORTACAO_DTI,
    this.ALUNO_STR,
    this.TIPO_STR,
    this.CONCLUIDO_STR,
  });
}
