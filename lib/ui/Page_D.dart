

import 'package:exam5/Blocs_Cubits/Cubit/Get_Notification_Cubit/Get_Notification_Cubit.dart';
import 'package:exam5/Blocs_Cubits/Cubit/Get_Notification_Cubit/Get_Notification_State.dart';
import 'package:exam5/ui/widgets/Notification_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PageD extends StatelessWidget {
  const PageD({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GetNotificationCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.purple,
          title:const Text(
            "D Screen",
            style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.purple,
        body: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: BlocConsumer<GetNotificationCubit, GetNotificationState>(
            listener: (context,state){
              if(state is LoadNotificationProgress){
                BlocProvider.of<GetNotificationCubit>(context).getAllNotifications();

              }
            },
            builder: (context, state) {
              if (state is LoadNotificationProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadNotificationSuccess) {
                return Center(
                  child: Column(
                    children: [
                      Text(state.notifications.length.toString(),style: TextStyle(color: Colors.white),),
                      ...List.generate(state.notifications.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: notifications(
                              imgPath: state.notifications[index].image,
                              title: state.notifications[index].title,
                              desc: state.notifications[index].body),
                        );
                      }),
                    ],
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                const  SizedBox(
                    height: 10,
                  ),
                 const Text(
                    'You don`t have an notification',
                    style: TextStyle(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}