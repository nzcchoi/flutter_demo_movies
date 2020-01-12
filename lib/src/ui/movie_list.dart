import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';

class MovieList extends StatelessWidget {
  final _bloc = MoviesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: _bloc.moviesStream,
        builder: (context, AsyncSnapshot<Movies> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }


  void dispose() {
    print('dispose');
    _bloc.dispose();
  }

  Widget buildList(AsyncSnapshot<Movies> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          return _buildBody(snapshot.data.results[index]);
        });
  }

  Widget _buildBody(Movie item) {
    return new Container(
        constraints: new BoxConstraints.expand(
          height: 200.0,
        ),
        alignment: Alignment.bottomCenter,
        padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new NetworkImage(
              'https://image.tmdb.org/t/p/w185${item.posterPath}',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: new Column(
          children: <Widget>[
          new Text("${item.title} (${item.voteCount})",
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.7)
              )),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: Colors.green,
                ),
                onPressed: () => _bloc.vote(item, 1),
              ),
              new IconButton(
                icon: Icon(Icons.thumb_down, color: Colors.red),
                onPressed: () => _bloc.vote(item, -1),
              ),
            ],
          )
        ]));
  }
}
