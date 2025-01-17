class Aulas {
  int? idAula;
  int? idAluno;
  int? idTipo;
  int? idInstrutor;
  String? instrutor;
  DateTime data;
  bool concluido;
  String? assunto;
  String? observacao;
  DateTime? dataImportacao;

  String? aluno;
  String? tipo;
  String? concluidoStr;

  Aulas({
    this.idAula,
    this.idAluno,
    this.idTipo,
    this.idInstrutor,
    this.instrutor,
    required this.data,
    required this.concluido,
    this.assunto,
    this.observacao,
    this.dataImportacao,
    this.aluno,
    this.tipo,
    this.concluidoStr,
  });
}
