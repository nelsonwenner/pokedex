import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/stores/poke.api.store.dart';
import 'package:pokedex/models/pokemon.model.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class PokemonDetailView extends StatefulWidget {

  final int index;

  PokemonDetailView({Key key, this.index}) : super(key: key);

  @override
  _PokemonDetailViewState createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {
  PokeApiStore _pokeApiStore;
  
  @override
  void initState() {
    super.initState();
    _pokeApiStore = GetIt.instance<PokeApiStore>();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (BuildContext context) {
            return AppBar(
              title: Opacity(
                child: Text(
                  _pokeApiStore.currentPokemon.name,
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ),
                opacity: 1,
              ),
              elevation: 0,
              backgroundColor: _pokeApiStore.currentColorPokemon,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ],
            );
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (context) {
              return Container(color: _pokeApiStore.currentColorPokemon);
            },
          ),
          Container(height: MediaQuery.of(context).size.height / 3),
          SlidingSheet(
            elevation: 0,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
              );
            },
          ),
          Padding(
            child: SizedBox(
                height: 150,
                child: PageView.builder(
                  onPageChanged: (index) {
                    _pokeApiStore.setCurrentPokemon(index: index);
                  },
                  itemCount: _pokeApiStore.pokedexModel.pokemon.length,
                  itemBuilder: (BuildContext context, int _index) {
                    PokemonModel _getPokemon = _pokeApiStore.getPokemon(index: _index);
                    return _pokeApiStore.getImagePokemon(number: _getPokemon.num, width: 60, height: 60);
                  },
                )),
            padding: EdgeInsets.only(top: 50),
          )
        ],
      ),
    );
  }
}