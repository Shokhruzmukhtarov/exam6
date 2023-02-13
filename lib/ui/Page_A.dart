import 'package:exam5/Blocs_Cubits/Cubit/Single_Cubit/Single_random_User_State.dart';
import 'package:exam5/ui/Page_D.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs_Cubits/Cubit/Single_Cubit/Single_Random_User_Cubit.dart';

class PageA extends StatefulWidget {
  const PageA({Key? key}) : super(key: key);

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  _handleFirebaseNotificationMessages() async {
    //Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Notification bor: ${message.notification}');
      }
    });
  }

  _setupInteractedMessage() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      if (initialMessage.data['route'] == 'chat') {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const PageD()));
      }
    }

    //Backgound
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['route'] == 'chat') {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const PageD()));
      }
    });
  }

  @override
  void initState() {
    _handleFirebaseNotificationMessages();
    _setupInteractedMessage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A Screen",style: TextStyle(color: Colors.red,fontSize: 28,fontWeight: FontWeight.w800),),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.green,
      body:  BlocBuilder<SingleRandomUserCubit,SingleRandomUserState>(builder: (context,state){
        if(state.status == ContactStatus.loading){
          return const Center(child: CircularProgressIndicator(),);
        }else if(state.status == ContactStatus.failure){
          return Center(child: Text(state.errorText));
        }else if(state.status == ContactStatus.success){
          return Column(
            children: [
              ...List.generate(state.randomUsers!.results.length, (index) {
                var item = state.randomUsers!.results[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(item.login.username.toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                    subtitle: Text(item.email.toString(),style: TextStyle(color: Colors.yellow,fontSize: 20,fontWeight: FontWeight.w500)),
                    trailing: Image.network(item.picture.medium.toString()),
                  )
                );
              }),
            ],
          );
        }
        return const SizedBox();
      }),
    );
  }
}
