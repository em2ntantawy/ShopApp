import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/screens/search/cubit.dart';
import 'package:shop_app/modules/screens/search/states.dart';

import '../../../models/search_model.dart';
import '../../../shared/components.dart';

class search extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: searchController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                            label: Text('Search')),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter text to search';
                          }
                          return null;
                        },
                        onFieldSubmitted: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is SearchInitialState)
                        LinearProgressIndicator(),
                      if (state is SearchSuccesslState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context).model.data.data[index],
                              context,
                            ),
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                            itemCount:
                                SearchCubit.get(context).model.data.data.length,
                          ),
                        ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
