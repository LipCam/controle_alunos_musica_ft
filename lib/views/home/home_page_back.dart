// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'home_page_back.g.dart';

class HomePageBack = _HomePageBack with _$HomePageBack;

abstract class _HomePageBack with Store {
  @observable
  int currentPage = 0;
}
