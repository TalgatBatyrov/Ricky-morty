import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty/cubits/single_character/single_character_cubit.dart';
import 'package:ricky_morty/cubits/single_character/single_character_state.dart';

class SingleCharacterPage extends StatelessWidget {
  final int characterId;

  const SingleCharacterPage({Key? key, required this.characterId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      SingleCharacterCubit()..getSingleCharacter(id: characterId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Details page')),
        body: BlocBuilder<SingleCharacterCubit, SingleCharacterState>(
          builder: (context, state) {
            if (state is SingleCharacterLoaded) {
              return Center(
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            state.character.image,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                        Text(state.character.name),
                        Text(state.character.status),
                        Text(state.character.species),
                        Text(state.character.id.toString()),
                      ],
                    )),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}