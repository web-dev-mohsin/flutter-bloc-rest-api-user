import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_rest_api_user/cubit/user_cubit_state.dart';

import '../cubit/user_cubit.dart';
import '../model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<UserCubit>().getAllUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: BlocBuilder<UserCubit, UserCubitState>(builder: ((context, state) {
        if (state is UserCubitLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserCubitError) {
          return Center(
            child: Text(state.message.toString()),
          );
        } else if (state is UserCubitDataLoaded) {
          return ListView.builder(
              itemCount: state.userList.length,
              itemBuilder: (context, index) {
                UserModel userModel = state.userList[index];
                return ListTile(
                  leading: Text(userModel.id.toString()),
                  title: Text(userModel.name.toString()),
                  subtitle: Text(userModel.username.toString()),
                );
              });
        }
        return SizedBox();
      })),
    );
  }
}
