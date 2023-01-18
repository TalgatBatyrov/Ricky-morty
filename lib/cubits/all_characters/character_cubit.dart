import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ricky_morty/cubits/all_characters/character_state.dart';
import 'package:ricky_morty/models/character.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit() : super(CharacterLoading());

  final _dio = Dio();
  final _baseUrl = 'https://rickandmortyapi.com/api/';
  final refreshController = RefreshController(initialRefresh: false);
  final List<Character> _allCharacters = [];
  var pageNumber = 1;

  Future<void> clear() async {
    try {
      // emit(CharacterLoading());
      pageNumber = 2;
      var response = await _dio.get('$_baseUrl/character?page=1');

      final characters = response.data['results']
          .map<Character>((res) => Character.fromJson(res))
          .toList();
      _allCharacters.clear();
      _allCharacters.addAll(characters);
      emit(CharacterLoaded(characters: _allCharacters));
    } on DioError catch (e) {
      emit(
        CharacterError(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<void> getAllCharacters() async {
    try {
      var response = await _dio.get('$_baseUrl/character?page=$pageNumber');
      pageNumber++;

      final characters = response.data['results']
          .map<Character>((res) => Character.fromJson(res))
          .toList();
      _allCharacters.addAll(characters);
      emit(CharacterLoaded(characters: _allCharacters));
    } on DioError catch (e) {
      emit(
        CharacterError(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<void> getSingleCharacter ({required String id}) async {

  }
}