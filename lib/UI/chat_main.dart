import 'package:chat_app/UI/chat_main_page.dart';
import 'package:chat_app/core/colors.dart';
import 'package:flutter/material.dart';

class ChatMain extends StatefulWidget{
  @override
  _ChatMainState createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> with SingleTickerProviderStateMixin {
TabController tabController;
int tabindex=0;

@override
void initState() { 
  super.initState();
  tabController=new TabController(length: 2, vsync: this);
}


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
   return  Scaffold(
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
              height: size.height/1.4,
              child: TabBarView(
                controller: tabController,
                children: [
                   Container(color: Colors.blueGrey,),
                  ChatMainPage(),
                 


              ]),
            )
          ],
        ),
     ),
    );
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