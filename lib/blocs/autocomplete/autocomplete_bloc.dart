



import 'dart:async';

import 'package:nwm_river_forecast/place_autocomplete.dart';
import 'package:nwm_river_forecast/repositories/places/places_repository.dart';


class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubscription;

  AutocomleteBloc({required PlacesRepository placesRepository}) 
  : _placesRepository = placesRepository,
    super(AutocompleteLoading());

  @override 
  Stream<AutocompleteState> mapEventToState(
    AutocompleteEvent event,
  ) async* {
    if (event is LoadAutocomplete) {
      yield* _mapLoadAutocompleteToState(event);
    }
  }

  Stream<AutocompleteState> _mapLoadAutocompleteToState(
    LoadAutocomplete event) async* {
      _placesSubscription?.cancel();

      final List<PlaceAutocomplete> autocomplete = await _placesRepository.getAutocomplete(event.searchInput);

      yield AutocompleteLoaded(autocomplete: autocomplete);
    }
}