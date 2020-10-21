import 'package:chat_app/UI/chat_page.dart';
import 'package:chat_app/UI/select_private.dart';
import 'package:flutter/material.dart';




class MainPage extends StatefulWidget{
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MainPage> {

int _index=0;


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
  return Scaffold(
     body: Center(
       child: Container(
         child: Stack(
                    children:[ PageView(
            onPageChanged: (index){
              setState(() {
                _index=index;
              });
            },
             children: [
               SelectPrivate(),
               Chat(),

             ],
             
           ),
           pageIndex(size)
        
           ]
         ),
       ),
     ),
   );
  }

  Widget pageIndex(Size size){
return
   Positioned(
             top: size.height/1.05,
             left: size.width/2.2,

                        child: Container(
                          width: size.width/10,
               child: Row(
                
                 children: [
                   AnimatedContainer(
                     margin: EdgeInsets.only(right: size.width/100),
                     duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                        color:_index==0?Colors.red.withOpacity(0.6):Colors.grey.withOpacity(0.6),
                       borderRadius: BorderRadius.circular(size.height/15)),
                       height:_index==0?15:10,
                     width: _index==0?15:10,
                     ),
                   AnimatedContainer(
                     margin: EdgeInsets.only(left: size.width/100),
                     duration: Duration(milliseconds: 300),
                    
                     height:_index==1?15:10,
                     width: _index==1?15:10,
                     decoration: BoxDecoration(
                     color:_index==1?Colors.red.withOpacity(0.6):Colors.grey.withOpacity(0.6),
                     borderRadius: BorderRadius.circular(size.height/15)),
                     
                     ),
                 ],
               ),
             ),
           );
  }
}