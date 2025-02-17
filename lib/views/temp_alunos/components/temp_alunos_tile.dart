// ignore_for_file: must_be_immutable

import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:controle_alunos_musica_ft/config/app_dimensions.dart';
import 'package:controle_alunos_musica_ft/models/temp_alunos.dart';
import 'package:controle_alunos_musica_ft/views/temp_alunos/temp_alunos_lista_back.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TempAlunosTile extends StatefulWidget {
  TempAlunos tempAluno;
  TempAlunosListaBack back;

  TempAlunosTile({
    super.key,
    required this.tempAluno,
    required this.back,
  });

  @override
  State<TempAlunosTile> createState() => _TempAlunosTileState();
}

class _TempAlunosTileState extends State<TempAlunosTile> {
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
          widget.tempAluno.nome.toString(),
          style: const TextStyle(
            fontSize: AppDimensions.listTileTitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.tempAluno.instrumento!,
          style: const TextStyle(
            fontSize: AppDimensions.listTileSubtitleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: onSelectTempAlunoIcon(),
        onTap: () => onSelectTempAluno(),
      ),
    );
  }

  Widget onSelectTempAlunoIcon() {
    return IconButton(
      icon: widget.tempAluno.flag
          ? const Icon(FontAwesomeIcons.solidSquareCheck)
          : const Icon(FontAwesomeIcons.squareCheck),
      color: AppColors.checkTileIcon,
      onPressed: () => onSelectTempAluno(),
    );
  }

  onSelectTempAluno() {
    widget.back.onSelectTempAluno(widget.tempAluno.idAluno);
    setState(() {});
  }
}
