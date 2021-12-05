import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_news/cubit/cubit.dart';
import 'package:today_news/cubit/states.dart';
import 'package:today_news/shared/component_s.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.all(20.0),
                child: defaultFormField(
                    onChange: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'search must not be empty';
                      }
                    }),
              ),
              Expanded(
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildArticleItem(list[index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: list.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
