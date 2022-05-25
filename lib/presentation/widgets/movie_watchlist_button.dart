import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_status/movie_watchlist_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieWatchlistButton extends StatelessWidget {
  final MovieDetail movieDetail;

  MovieWatchlistButton(this.movieDetail);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieWatchListStatusBloc, MovieWatchListStatusState>(
      listener: (context, state) {
        if (state is MovieWatchListStatusSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is MovieWatchListStatusError) {
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
            .read<MovieWatchListStatusBloc>()
            .add(OnMovieWatchListStatusFavorited(movieDetail));

        return ElevatedButton(
          onPressed: () async {
            if (state is WatchlistStatusLoaded) {
              context.read<MovieWatchListStatusBloc>().add(state.isAdded
                  ? OnMovieWatchListStatusRemoved(movieDetail)
                  : OnMovieWatchListStatusAdded(movieDetail));
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
