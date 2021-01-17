
import 'package:chat_app/UI/contacts.dart';
import 'package:chat_app/core/colors.dart';
import 'package:chat_app/hive/chat_model.dart';
import 'package:chat_app/models/chats.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'chat_message_page.dart';
class ChatMain extends StatefulWidget{
  @override
  _ChatMainState createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> with SingleTickerProviderStateMixin {
TabController tabController;
int tabindex=0;
 int number=0;
void inithive()async{

  var box = await Hive.openBox('testBox');
  


  ChatModelHive mm=box.get("key") as ChatModelHive;
  


}
void additem()async{
   number++;
   Message msg=new Message();
  msg.isOwn=true;
  msg.messagebody="Heyy how are you$number";
  msg.sender="you";
  msg.time="45:00";
  List<Message> msgg=new List<Message>();
  msgg.add(msg);
  msgg.add(msg);
  msgg.add(msg);

  var box = await Hive.openBox('testBox');
  ChatModelHive chat=new ChatModelHive(id: "dfdf0",username: "Sdfsdf0",messages: msgg);
 

 await box.put("key6", chat);

}
@override
void initState() { 
  
  super.initState();
 // inithive();
  tabController=new TabController(length: 2, vsync: this);
} 




  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(

    create: (context) => Chats(),
    child: Scaffold(
      
     body: Center(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height/5.6,
              color: ColorsPallete.colorf,
              child: Center(
                child: Container(
                width: size.width/1.3,
                margin: EdgeInsets.only(top: size.height/11),
                child:TabBar(
                indicatorColor: Colors.transparent,
                  controller:tabController ,
                  onTap: (int index){
                    setState(() {
                      tabindex=index;
                    });
                  },
                  tabs: [
                  tabBarItem(size, "Chats",tabindex==0?Colors.white:Colors.white.withOpacity(0.4)),
                  tabBarItem(size, "Contacts", tabindex==1?Colors.white:Colors.white.withOpacity(0.4))
                ])
              )),
            ),
            Container(
              width: size.width,
              height: size.height/1.22,
              child: TabBarView(
                controller: tabController,
                children: [
                  Container()
                 /*  ValueListenableBuilder(
                      valueListenable: Hive.box('testBox').listenable(),
                        builder: (context, box, widget) {
                        return 
                             Container(
                      child: ListView.builder(
                        itemCount: box.keys.toList().length,
                        itemBuilder: (context, index) {
                          final key=box.keys.toList()[index];
                          final value=box.get(key)  as ChatModelHive;
                           
                          return GestureDetector(
                            onTap: (){
                              print("dfsdf");
                                   
                            },
                              child: Container(
                              child: Text("${value.username}"),
                            ),
                          );
                        },
                       ));
                             
                 


                        }),*/
                        ,Contacts()
                        /*Container( 
              width: size.width,
              height: size.height/1.4,
              child: ValueListenableBuilder(valueListenable: Hive.box("testBox").listenable(), 
              builder:(context,box,widget){
                return Container(
                  child: ListView.builder(
                    itemBuilder: (context,index){

                  }),
                );
              } ),
              )*/
                        ]),
            )
          ],
        ),
     ),
  floatingActionButton: FloatingActionButton(onPressed: (){
    additem();
  }),
    ));
  }

  Widget tabBarItem(Size size,String text,Color color){
    return Container(
      width: size.width/4,
      height: size.height/16,
      decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(size.height/30)
      ),
      child: Center(child: Text(text,style: TextStyle(color: Colors.black,))),
      );
  }
}