import 'dart:io';
import 'dart:typed_data';

import 'package:android_intent_plus/android_intent.dart';
import 'package:controle_alunos_musica_ft/config/app_string_formats.dart';
import 'package:controle_alunos_musica_ft/config/app_toast.dart';
import 'package:controle_alunos_musica_ft/database/repositories/rel_alunos_repository.dart';
import 'package:controle_alunos_musica_ft/models/alunos.dart';
import 'package:controle_alunos_musica_ft/models/aulas.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class RelatorioAlunos {
  Future<void> onGeraRelatorio(int idAluno) async {
    var dao = RelAlunosRepository();
    List<Alunos> lstAluno = await dao.onGetAlunoRelatorio(idAluno);
    List<Aulas> lstAulas = await dao.onGetAulasAlunoRelatorio(idAluno);

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          ///Cabeçalho
          pw.Text(
            lstAluno[0].nome.toString(),
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),

          pw.RichText(
            text: pw.TextSpan(
              text: "Fone: ",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
              children: [
                pw.TextSpan(
                  text: lstAluno[0].fone,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          pw.RichText(
            text: pw.TextSpan(
              text: "Instrumento: ",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
              children: [
                pw.TextSpan(
                  text: lstAluno[0].instrumento,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
                pw.TextSpan(
                  text: "       Método: ",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.TextSpan(
                  text: lstAluno[0].metodo,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          pw.RichText(
            text: pw.TextSpan(
              text: "Início: ",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
              children: [
                pw.TextSpan(
                  text: lstAluno[0].dataInicioGEM != null
                      ? getDateFormat_dd_MM_yyyy(lstAluno[0].dataInicioGEM!)
                      : "",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
                pw.TextSpan(
                  text: "       Status: ",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.TextSpan(
                  text: lstAluno[0].status,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          pw.RichText(
            text: pw.TextSpan(
              text: "Oficialização: ",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
              children: [
                pw.TextSpan(
                  text: lstAluno[0].dataOficializacao != null
                      ? getDateFormat_dd_MM_yyyy(lstAluno[0].dataOficializacao!)
                      : "",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          pw.RichText(
            text: pw.TextSpan(
              text: "Data relatório: ",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
              children: [
                pw.TextSpan(
                  text: getDateFormat_dd_MM_yyyy(DateTime.now()),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 10),

          ///Título
          pw.Center(
            child: pw.Text(
              "Aulas",
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 10),

          ///Conteúdo/tabela
          pw.Table.fromTextArray(
            headers: ["Data", "Tipo", "Assunto", "Instrutor", "Status"],
            data: lstAulas
                .map((aula) => [
                      getDateFormat_dd_MM_yyyy(aula.data),
                      aula.tipo,
                      aula.assunto,
                      aula.instrutor,
                      aula.concluidoStr
                    ])
                .toList(),
            headerStyle: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.grey300,
            ),
            cellStyle: const pw.TextStyle(
              fontSize: 9,
            ),
            cellAlignment: pw.Alignment.centerLeft,
            border: pw.TableBorder.all(
              color: PdfColors.grey700,
              width: 0.5,
            ),
            columnWidths: {
              0: const pw.FixedColumnWidth(57), // Data
              1: const pw.FixedColumnWidth(42), // Tipo
              2: const pw.FlexColumnWidth(2), // Assunto
              3: const pw.FlexColumnWidth(1.5), // Instrutor
              4: const pw.FixedColumnWidth(53), // Status
            },
          ),
        ],
      ),
    );

    final data = await pdf.save();
    String fileName =
        "Relat ${lstAluno[0].nome} ${getDateFormat_ddMMyyyy(DateTime.now())}";
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
