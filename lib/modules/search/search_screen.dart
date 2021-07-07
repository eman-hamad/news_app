import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  text: 'Search',
                  fillColor: Colors.white,
                  isFilled: true,
                  
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  prefix: Icons.search,
                  onChange: (value) {
                    NewsCubit.get(context).getSearchData(value);
                  }),
            ),
            Expanded(
              child: itemBuilder(NewsCubit.get(context).search_data, context , isInSearch : true),
            )
          ],
        ),
      ),
    );
  }
}
