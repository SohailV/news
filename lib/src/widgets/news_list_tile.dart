import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_container.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'dart:async';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({required this.itemId}) {
    //print('news list tile constructor $itemId');
  }

  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    //print(bloc.toString());
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          // print('newslist tile ${snapshot.data}');

          return LoadingContainer();
        }

        return FutureBuilder(
            future: snapshot.data![itemId],
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                // print('futurebuilder $itemId');
                return LoadingContainer();
              }

              return buildTile(context, itemSnapshot.data);
            });
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel? item) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item!.id}');
          },
          title: Text(item!.title),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 6.0,
        ),
      ],
    );
  }
}
