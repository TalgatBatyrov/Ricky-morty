import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty/cubits/all_characters/character_cubit.dart';
import 'package:ricky_morty/cubits/all_characters/character_state.dart';
import 'package:ricky_morty/pages/single_character_page.dart';

class AllCharactersPage extends StatelessWidget {
  const AllCharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All characters'),
      ),
      body: SafeArea(
        child: BlocBuilder<CharacterCubit, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoaded) {
              return ListView.builder(
                itemCount: state.characters.length,
                itemBuilder: (context, index) {
                  final e = state.characters[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SingleCharacterPage(characterId: e.id),
                        )),
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
                                e.image,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
                            ),
                            Text(e.name),
                            Text(e.id.toString()),
                          ],
                        )),
                  );
                },
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
