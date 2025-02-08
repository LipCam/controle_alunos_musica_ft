// ignore_for_file: must_be_immutable

import 'package:controle_alunos_musica_ft/components/custom_confirmdialog.dart';
import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/config/app_dimensions.dart';
import 'package:controle_alunos_musica_ft/models/alunos.dart';
import 'package:controle_alunos_musica_ft/views/alunos/alunos_lista_back.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlunosTile extends StatelessWidget {
  Alunos aluno;
  AlunosListaBack back;
  AlunosTile({super.key, required this.aluno, required this.back});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.cardTileHorizontalMargin,
        vertical: AppDimensions.cardTileVerticalMargin,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          left: AppDimensions.listTileContPadLeft,
          right: AppDimensions.listTileContPadRight,
        ),
        title: Text(
          aluno.nome.toString(),
          style: const TextStyle(
            fontSize: AppDimensions.listTileTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              aluno.status!,
              style: const TextStyle(
                  fontSize: AppDimensions.listTileSubtitleFontSize),
            ),
            Text(
              aluno.instrumento!,
              style: const TextStyle(
                fontSize: AppDimensions.listTileSubtitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: deleteButton(context),
        onTap: () {
          back.goToForm(context, aluno);
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
          message: "Deseja excluir ${aluno.nome}?",
          functionYes: () {
            back.onDelete(aluno.idAluno!);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
