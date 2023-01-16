import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty/cubits/all_characters/character_state.dart';
import 'package:ricky_morty/cubits/single_character/single_character_state.dart';
import 'package:ricky_morty/models/character.dart';

class SingleCharacterCubit extends Cubit<SingleCharacterState> {
  SingleCharacterCubit() : super(SingleCharacterLoading());

  final _dio = Dio();
  final _baseUrl = 'https://rickandmortyapi.com/api/';

  Future<void> getSingleCharacter({required int id}) async {
    try {
      emit(SingleCharacterLoading());
      var response =
      await _dio.get('$_baseUrl/character/$id');

      final characters = Character.fromJson(response.data);

      emit(SingleCharacterLoaded(character: characters));

    } catch (e) {
      print(e);
    }
  }


}