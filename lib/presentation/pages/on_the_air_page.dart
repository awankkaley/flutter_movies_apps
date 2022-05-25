import 'package:ditonton/presentation/bloc/now_playing_tv/tv_now_playing_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnTheAirPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air';

  @override
  _OnTheAirPageState createState() => _OnTheAirPageState();
}

class _OnTheAirPageState extends State<OnTheAirPage> {
  @override
  void initState() {
    super.initState();
    context..read<TvNowPlayingBloc>().add(OnTvNowPlayingRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
            builder: (context, state) {
          if (state is TvNowPlayingLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvNowPlayingHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.result[index];
                return TvCard(movie);
              },
              itemCount: state.result.length,
            );
          } else if (state is TvNowPlayingError) {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
