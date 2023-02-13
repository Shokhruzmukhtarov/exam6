import 'package:exam5/Blocs_Cubits/Cubit/Multi_Cubit/Random_User_Cubit.dart';
import 'package:exam5/Blocs_Cubits/Cubit/Multi_Cubit/Random_User_State.dart';
import 'package:exam5/Data/Repos/Random_User_Repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageB extends StatelessWidget {
  const PageB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("B Screen",style: TextStyle(color: Colors.blue,fontSize: 28,fontWeight: FontWeight.w800)),
        backgroundColor: Colors.yellow,
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.yellow,
      body: BlocProvider(
          create: (context) =>  MultiRandomUserCubit(randomUserRepository: context.read<RandomUserRepo>()),
        child: BlocBuilder<MultiRandomUserCubit,MultiRandomUserState>(builder: (context,state){
          if(state is LoadInProgress){
            return const Center(child: CircularProgressIndicator(),);
          }else if(state is LoadInFailure){
            return Center(child: Text(state.error));
          }else if(state is LoadInSuccess){
            return Column(
              children: [
                ...List.generate(state.randomUserModel.results.length, (index) {
                  var item = state.randomUserModel!.results[index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(item.login.username.toString(),style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500)),
                        subtitle: Text(item.email.toString(),style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.w500)),
                        trailing: Image.network(item.picture.medium.toString()),
                      )
                  );
                }),
              ],
            );
          }
          return const SizedBox();
        }
        ),
      ),

    );
  }
}
