import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_news/cubit/cubit.dart';
import 'package:today_news/cubit/states.dart';
import 'package:today_news/shared/component_s.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder:(context,state){

        var list = NewsCubit.get(context).sports;

        return state is! NewsGetSportsLoadingState
            ? ListView.separated(
            physics:BouncingScrollPhysics(),
            itemBuilder:(context,index)=>buildArticleItem(list[index],context),
            separatorBuilder:(context,index)=>myDivider(),
            itemCount: list.length)
            :Center(child:CircularProgressIndicator(),);
      },
      listener:(context,state){},
    );
  }
}
