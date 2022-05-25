import 'package:ditonton/presentation/bloc/top_rated_tv/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    context..read<TvTopRatedBloc>().add(OnTvTopRatedRequested());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
            builder: (context, state) {
              if (state is TvTopRatedLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvTopRatedHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.result[index];
                    return TvCard(movie);
                  },
                  itemCount: state.result.length,
                );
              } else if (state is TvTopRatedError) {
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
