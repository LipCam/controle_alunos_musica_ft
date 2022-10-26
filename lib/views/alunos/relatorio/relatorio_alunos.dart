import 'dart:io';
import 'dart:typed_data';

import 'package:controle_alunos_musica_ft/database/dao/rel_alunos_dao.dart';
import 'package:controle_alunos_musica_ft/entities/alunos.dart';
import 'package:controle_alunos_musica_ft/entities/aulas.dart';
import 'package:intl/intl.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class RelatorioAlunos {
  Future<void> GeraRelatorio(int ID_ALUNO_INT) async {
    var _dao = RelAlunosDAO();
    List<Alunos> lstAluno = await _dao.GetAlunoRelatorio(ID_ALUNO_INT);
    List<Aulas> lstAulas = await _dao.GetAulasAlunoRelatorio(ID_ALUNO_INT);
    DateFormat formatter = DateFormat('ddMMyyyy');
    DateFormat formatter2 = DateFormat('dd/MM/yyyy');

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(lstAluno[0].NOME_STR.toString(),
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text("Fone: " + lstAluno[0].FONE_STR.toString()),
            pw.Text("Instrumento: " +
                lstAluno[0].INSTRUMENTO_STR.toString() +
                "       Método: " +
                lstAluno[0].METODO_STR.toString()),
            pw.Text("Status: " + lstAluno[0].STATUS_STR.toString()),
            pw.Text("Início: " +
                (lstAluno[0].DATA_INICIO_GEM_DTI != null
                    ? formatter2.format(lstAluno[0].DATA_INICIO_GEM_DTI!)
                    : "") +
                "       Oficialização: " +
                (lstAluno[0].DATA_OFICIALIZACAO_DTI != null
                    ? formatter2.format(lstAluno[0].DATA_OFICIALIZACAO_DTI!)
                    : "")),
            pw.Text("Data relatório: " + formatter2.format(DateTime.now())),
            pw.SizedBox(height: 20),
            pw.Center(
                child: pw.Text("Aulas",
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold))),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              headers: ["Data", "Tipo", "Assunto", "Instrutor", "Status"],
              data: lstAulas
                  .map((aula) => [
                        formatter2.format(aula.DATA_DTI),
                        aula.TIPO_STR,
                        aula.ASSUNTO_STR,
                        aula.INSTRUTOR_STR,
                        aula.CONCLUIDO_STR
                      ])
                  .toList(),
            ),
            // pw.Expanded(
            //   child: pw.Column(
            //     children: [
            //       pw.Row(
            //         children: [
            //           pw.Expanded(
            //               child: pw.Text("Data",
            //                   textAlign: pw.TextAlign.left,
            //                   style: pw.TextStyle(
            //                       fontWeight: pw.FontWeight.bold))),
            //           pw.Expanded(
            //               child: pw.Text("Assunto",
            //                   textAlign: pw.TextAlign.left,
            //                   style: pw.TextStyle(
            //                       fontWeight: pw.FontWeight.bold))),
            //           pw.Expanded(
            //               child: pw.Text("Instrutor",
            //                   textAlign: pw.TextAlign.left,
            //                   style: pw.TextStyle(
            //                       fontWeight: pw.FontWeight.bold))),
            //           pw.Expanded(
            //               child: pw.Text("Status",
            //                   textAlign: pw.TextAlign.left,
            //                   style: pw.TextStyle(
            //                       fontWeight: pw.FontWeight.bold))),
            //         ],
            //       ),
            //       for (Aulas aula in lstAulas)
            //         pw.Row(
            //           children: [
            //             pw.Expanded(
            //                 child: pw.Text(formatter2.format(aula.DATA_DTI),
            //                     textAlign: pw.TextAlign.left)),
            //             pw.Expanded(
            //                 child: pw.Text(aula.ASSUNTO_STR.toString(),
            //                     textAlign: pw.TextAlign.left)),
            //             pw.Expanded(
            //                 child: pw.Text(aula.INSTRUTOR_STR.toString(),
            //                     textAlign: pw.TextAlign.left)),
            //             pw.Expanded(
            //                 child: pw.Text(aula.CONCLUIDO_STR.toString(),
            //                     textAlign: pw.TextAlign.left)),
            //           ],
            //         )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );

    final data = await pdf.save();
    String fileName = "Relat " +
        lstAluno[0].NOME_STR.toString() +
        " " +
        formatter.format(DateTime.now());
    savePdfFile(fileName, data);
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    try {
      final directory = (await getExternalStorageDirectories(
              type: StorageDirectory.downloads))
          ?.first;

      //final directory = await getTemporaryDirectory();
      var filePath = "${directory?.path}/$fileName.pdf";
      final file = File(filePath);
      await file.writeAsBytes(byteList);
      await OpenDocument.openDocument(filePath: filePath);
    } catch (e) {
      print(e);
    }
  }
}
