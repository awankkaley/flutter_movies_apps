import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist_status/tv_watchlist_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvWatchlistButton extends StatelessWidget {
  final TvDetail tvDetail;

  TvWatchlistButton(this.tvDetail);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TvWatchListStatusBloc, TvWatchListStatusState>(
      listener: (context, state) {
        if (state is TvWatchListStatusSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is TvWatchListStatusError) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: Text(
                  state.message,
                ));
              });
        }
      },
      builder: (BuildContext context, state) {
        context
            .read<TvWatchListStatusBloc>()
            .add(OnTvWatchListStatusFavorited(tvDetail));

        return ElevatedButton(
          onPressed: () async {
            if (state is WatchlistStatusLoaded) {
              context.read<TvWatchListStatusBloc>().add(state.isAdded
                  ? OnTvWatchListStatusRemoved(tvDetail)
                  : OnTvWatchListStatusAdded(tvDetail));
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state is WatchlistStatusLoaded)
                state.isAdded ? Icon(Icons.check) : Icon(Icons.add),
              Text('Watchlist'),
            ],
          ),
        );
      },
    );
  }
}
