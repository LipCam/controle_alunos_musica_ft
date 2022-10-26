class Alunos {
  int? ID_ALUNO_INT;
  String? NOME_STR;
  int? ID_STATUS_INT;
  String? INSTRUMENTO_STR;
  String? METODO_STR;
  String? FONE_STR;
  DateTime? DATA_NASCIMENTO_DTI;
  DateTime? DATA_BATISMO_DTI;
  DateTime? DATA_INICIO_GEM_DTI;
  DateTime? DATA_OFICIALIZACAO_DTI;
  String? ENDERECO_STR;
  String? OBSERVACAO_STR;
  DateTime? DATA_IMPORTACAO_DTI;

  String? STATUS_STR;

  Alunos(
      {this.ID_ALUNO_INT,
      this.NOME_STR,
      this.ID_STATUS_INT,
      this.INSTRUMENTO_STR,
      this.METODO_STR,
      this.FONE_STR,
      this.DATA_NASCIMENTO_DTI,
      this.DATA_BATISMO_DTI,
      this.DATA_INICIO_GEM_DTI,
      this.DATA_OFICIALIZACAO_DTI,
      this.ENDERECO_STR,
      this.OBSERVACAO_STR,
      this.DATA_IMPORTACAO_DTI,
      this.STATUS_STR});
}
