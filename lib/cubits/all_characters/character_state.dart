import 'package:ricky_morty/models/character.dart';

abstract class CharacterState {
  const CharacterState();
}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;

  CharacterLoaded({required this.characters});
}

class CharacterEmpty extends CharacterState {}

class CharacterError extends CharacterState {
  final String? error;

  CharacterError({this.error});
}
