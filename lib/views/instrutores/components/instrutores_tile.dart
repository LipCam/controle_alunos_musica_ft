// ignore_for_file: must_be_immutable

import 'package:controle_alunos_musica_ft/components/custom_confirmdialog.dart';
import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/config/app_dimensions.dart';
import 'package:controle_alunos_musica_ft/models/instrutores.dart';
import 'package:controle_alunos_musica_ft/views/instrutores/instrutores_lista_back.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstrutoresTile extends StatelessWidget {
  Instrutores instrutor;
  InstrutoresListaBack back;
  InstrutoresTile({super.key, required this.instrutor, required this.back});

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
        title: Text(
          instrutor.nome.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              instrutor.instrumento!,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: deleteButton(context),
        onTap: () {
          back.goToForm(context, instrutor);
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
          message: "Deseja excluir ${instrutor.nome}?",
          functionYes: () {
            back.onDelete(instrutor.idInstrutor!);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
