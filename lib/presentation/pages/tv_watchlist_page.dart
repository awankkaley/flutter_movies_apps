import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context..read<TvWatchListBloc>().add(OnTvWatchListRequested());

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context..read<TvWatchListBloc>().add(OnTvWatchListRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchListBloc, TvWatchListState>(
            builder: (context, state) {
              if (state is TvWatchListLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvWatchListSuccess) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.result[index];
                    return TvCard(movie);
                  },
                  itemCount: state.result.length,
                );
              } else if (state is TvWatchListError) {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
