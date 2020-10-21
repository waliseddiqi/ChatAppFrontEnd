import 'package:chat_app/models/messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagesField extends StatefulWidget {
 final GlobalKey<AnimatedListState> animatedListKey;
  MessagesField({Key key, this.animatedListKey}) : super(key: key);


  @override
  _MyMessagesFieldState createState() => _MyMessagesFieldState();
}

class _MyMessagesFieldState extends State<MessagesField> {

List<String>messages=new List<String>();

@override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return
   Consumer<Messages>(
             builder: (context,data,child)
          
     =>  Center(
       child: Container(
              height: size.height*0.80,
              child: AnimatedList(
                reverse: true,
                key: widget.animatedListKey,
                initialItemCount: data.messages.length,
                padding: EdgeInsets.zero,
              
                itemBuilder: (context,index,Animation<double> animation)=>
                  listItems(context, index, animation, data, size)
               
                
                ),
            
          ),
     ),
      
    );
  }
  Widget listItems(context,int index,animation,Messages data,Size size){
    return 
    
    FadeTransition(opacity: animation,
  
    child:  Container(
                child: Row(
                  children: [
                    Expanded(
                        
                      child: Align(
                        alignment: data.messages[data.messages.length-index-1].isOwn?Alignment.centerRight:Alignment.centerLeft,
                          child: Container(
                               constraints: BoxConstraints(minWidth: size.width*0.15, maxWidth: size.width*0.8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.height/70),
                            color: data.messages[data.messages.length-index-1].isOwn?Colors.green:Colors.blueGrey
                          ),
                          
                         
                          margin: EdgeInsets.only(left: size.width*0.01,bottom: size.height/70),
                          child: Padding(
                            padding: EdgeInsets.all(size.height/70),
                                      child: Container(
                              
                            
                              child: RichText(text: TextSpan(
                                children: [
                                
                                
                                  TextSpan(text:"${data.messages[data.messages.length-index-1].messagebody}",style: TextStyle(color: Colors.white,fontSize: size.height/50),)
                                  ,TextSpan(text: "    ${data.messages[data.messages.length-index-1].time}",style: TextStyle(color: Colors.white,fontSize: size.height/90,),)
                                ]
                              ))
                              ),
                          )),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}