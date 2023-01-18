import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ricky_morty/cubits/all_characters/character_cubit.dart';
import 'package:ricky_morty/cubits/all_characters/character_state.dart';
import 'package:ricky_morty/pages/single_character_page.dart';

class AllCharactersPage extends StatefulWidget {
  const AllCharactersPage({Key? key}) : super(key: key);

  @override
  State<AllCharactersPage> createState() => _AllCharactersPageState();
}

class _AllCharactersPageState extends State<AllCharactersPage> {

  void _onRefresh() {
    context.read<CharacterCubit>().clear();
    context.read<CharacterCubit>().refreshController.refreshCompleted();
  }

  void _onLoading() {
    context.read<CharacterCubit>().getAllCharacters();
    context.read<CharacterCubit>().refreshController.loadComplete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All characters'),
      ),

      body: SafeArea(
        child: BlocBuilder<CharacterCubit, CharacterState>(
          builder: (context, state) {
            if (state is CharacterError) {
              if (state.error != null) {
                return Center(
                  child: Text(state.error!),
                );
              }
            }
            if (state is CharacterLoaded) {
              return SmartRefresher(
                header: const WaterDropHeader(
                  refresh: CupertinoActivityIndicator(),
                complete: CupertinoActivityIndicator(),
                ),
                enablePullDown: true,
                enablePullUp: true,
                controller: context.read<CharacterCubit>().refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: state.characters
                      .map((e) => GestureDetector(
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
                      child: Stack(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              e.image,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const Center(
                                  child:  CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            left: 5,
                            bottom: 10,
                            child: Text(
                              e.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Text(
                              e.id.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                      .toList(),
                ),
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
