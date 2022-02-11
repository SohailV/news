import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    //temp. infinite loop

    // print("newsList");
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        //print('this is build list ${snapshot.data}');
        if (!snapshot.hasData) {
          // print("inside news list streambuilder");
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: (snapshot.data!.length),
            itemBuilder: (context, int index) {
              // print("inside listview builder.");
              bloc.fetchItem(snapshot.data![index]);
              //print('list view $index');
              return NewsListTile(
                itemId: snapshot.data![index],
              );
            },
          ),
        );
      },
    );
  }
}
