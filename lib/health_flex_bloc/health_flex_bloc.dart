
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_get/giphy_get.dart';


part 'health_flex_event.dart';
part 'health_flex_state.dart';

class HealthFlexBloc extends Bloc<HealthFlexEvent, HealthFlexState> {

  final api_key = 'eAX6zBlzuVvcLTHHR1Pf13qIbfLwM6Nl';
  GiphyCollection? gif;

  HealthFlexBloc() : super(HealthFlexInitialState()) {
    on<HealthFlexTrendingEvent>(_getHealthTrendingFlex);
  }


  void _getHealthTrendingFlex(HealthFlexTrendingEvent event, Emitter emit) async {
    emit(HealthFlexInitialState());

    GiphyClient client = GiphyClient(apiKey: api_key, randomId: '');
    gif = await client.trending();
    emit(HealthFlexInitialState());
  }



}