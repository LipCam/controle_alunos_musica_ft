import 'package:controle_alunos_musica_ft/components/custom_confirmdialog.dart';
import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/config/app_dimensions.dart';
import 'package:controle_alunos_musica_ft/config/app_string_formats.dart';
import 'package:controle_alunos_musica_ft/models/aulas.dart';
import 'package:controle_alunos_musica_ft/views/aulas/aulas_lista_back.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AulasTile extends StatelessWidget {
  final Aulas aula;
  final AulasListaBack back;
  const AulasTile({super.key, required this.aula, required this.back});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.cardTileHorizontalMargin,
        vertical: AppDimensions.cardTileVerticalMargin,
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(
          left: AppDimensions.listTileContPadLeft,
          right: AppDimensions.listTileContPadRight,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                aula.aluno.toString(),
                style: const TextStyle(
                  fontSize: AppDimensions.listTileTitleFontSize,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              getDateFormat_dd_MM_yyyy(aula.data),
              style: const TextStyle(
                fontSize: AppDimensions.listTileTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              aula.assunto!,
              maxLines: 2,
              style: const TextStyle(
                fontSize: AppDimensions.listTileSubtitleFontSize,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    aula.tipo.toString(),
                    style: const TextStyle(
                      fontSize: AppDimensions.listTileSubtitleFooterFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    aula.instrutor.toString(),
                    style: const TextStyle(
                      fontSize: AppDimensions.listTileSubtitleFooterFontSize,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  aula.concluidoStr.toString(),
                  style: TextStyle(
                    fontSize: AppDimensions.listTileSubtitleFooterFontSize,
                    color: aula.concluidoStr == "Concluído"
                        ? AppColors.stAulaConcluido
                        : AppColors.stAulaPendente,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: deleteButton(context),
        onTap: () {
          back.onGoToForm(
              context, aula, back.dataIni!, back.dataFim!, back.aluno);
        },
      ),
    );
  }

  Widget deleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(FontAwesomeIcons.solidTrashCan),
      color: AppColors.deleteIcon,
      onPressed: () {
        customConfirmDialog(
          context: context,
          title: "Exclusão",
          message:
              "Deseja excluir este registro?\nAluno: ${aula.aluno}\nData: ${getDateFormat_dd_MM_yyyy(aula.data)}\nAssunto: ${aula.assunto}",
          functionYes: () {
            back.onDelete(
                aula.idAula!, back.dataIni!, back.dataFim!, back.aluno);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
