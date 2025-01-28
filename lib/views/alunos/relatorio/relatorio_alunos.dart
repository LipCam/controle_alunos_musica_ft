import 'dart:io';
import 'dart:typed_data';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:controle_alunos_musica_ft/config/app_toast.dart';
import 'package:controle_alunos_musica_ft/database/dao/rel_alunos_dao.dart';
import 'package:controle_alunos_musica_ft/models/alunos.dart';
import 'package:controle_alunos_musica_ft/models/aulas.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class RelatorioAlunos {
  Future<void> onGeraRelatorio(int idAluno) async {
    var dao = RelAlunosDAO();
    List<Alunos> lstAluno = await dao.onGetAlunoRelatorio(idAluno);
    List<Aulas> lstAulas = await dao.onGetAulasAlunoRelatorio(idAluno);
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
            ///Cabeçalho
            pw.Text(
              lstAluno[0].nome.toString(),
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text("Fone: ${lstAluno[0].fone}"),
            pw.Text(
                "Instrumento: ${lstAluno[0].instrumento}       Método: ${lstAluno[0].metodo}"),
            pw.Text("Status: ${lstAluno[0].status}"),
            pw.Text(
                "Início: ${lstAluno[0].dataInicioGEM != null ? formatter2.format(lstAluno[0].dataInicioGEM!) : ""}       Oficialização: ${lstAluno[0].dataOficializacao != null ? formatter2.format(lstAluno[0].dataOficializacao!) : ""}"),
            pw.Text("Data relatório: ${formatter2.format(DateTime.now())}"),
            pw.SizedBox(height: 20),

            ///Título
            pw.Center(
              child: pw.Text(
                "Aulas",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 10),

            ///Conteúdo/tabela
            pw.Table.fromTextArray(
              headers: ["Data", "Tipo", "Assunto", "Instrutor", "Status"],
              data: lstAulas
                  .map((aula) => [
                        formatter2.format(aula.data),
                        aula.tipo,
                        aula.assunto,
                        aula.instrutor,
                        aula.concluidoStr
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
    String fileName =
        "Relat ${lstAluno[0].nome} ${formatter.format(DateTime.now())}";
    savePdfFile(fileName, data);
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    try {
      if (await _requestPermission()) {
        String filePath = "/storage/emulated/0/Download/$fileName.pdf";
        File file = File(filePath);
        await file.writeAsBytes(byteList);

        OpenFile.open(filePath);

        await _onLunchFileView();

        onToastMessage("$fileName.pdf salvo em Downloads");
      }
    } catch (e) {
      //print(e);
    }
  }

  Future<void> _onLunchFileView() async {
    const intent = AndroidIntent(
      action: 'android.intent.action.VIEW_DOWNLOADS',
    );
    await intent.launch();
  }

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    }
    return false;
  }
}
