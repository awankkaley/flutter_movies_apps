import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv/tv_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv/tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/on_the_air_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants.dart';


class TvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_show';

  @override
  _TvShowPageState createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  @override
  void initState() {
    super.initState();
    context..read<TvNowPlayingBloc>().add(OnTvNowPlayingRequested())
      ..read<TvPopularBloc>().add(OnTvPopularRequested())
      ..read<TvTopRatedBloc>().add(OnTvTopRatedRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TvSearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                  title: 'On The Air',
                  onTap: () =>
                Navigator.pushNamed(context, OnTheAirPage.ROUTE_NAME),
              ),
              BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
                  builder: (context, state) {
                    if (state is TvNowPlayingLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvNowPlayingHasData) {
                      return TvList(state.result);
                    } else if (state is TvNowPlayingError) {
                      return Text('Failed');
                    } else {
                      return Container();
                    }
                  }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TvPopularBloc, TvPopularState>(
                  builder: (context, state) {
                    if (state is TvPopularLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvPopularHasData) {
                      return TvList(state.result);
                    } else if (state is TvPopularError) {
                      return Text('Failed');
                    } else {
                      return Container();
                    }
                  }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                  builder: (context, state) {
                    if (state is TvTopRatedLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvTopRatedHasData) {
                      return TvList(state.result);
                    } else if (state is TvTopRatedError) {
                      return Text('Failed');
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }


Row _buildSubHeading({required String title, required Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: kHeading6,
      ),
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
          ),
        ),
      ),
    ],
  );
}
}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}