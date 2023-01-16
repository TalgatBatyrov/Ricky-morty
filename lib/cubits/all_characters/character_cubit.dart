import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty/cubits/all_characters/character_state.dart';
import 'package:ricky_morty/models/character.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit() : super(CharacterLoading());

  final _dio = Dio();
  final _baseUrl = 'https://rickandmortyapi.com/api/';

  Future<void> getAllCharacters() async {
    try {
      emit(CharacterLoading());
      var response =
      await _dio.get('$_baseUrl/character');

      final characters = response.data['results']
          .map<Character>((res) => Character.fromJson(res))
          .toList();

      emit(CharacterLoaded(characters: characters));
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSingleCharacter ({required String id}) async {

  }
}