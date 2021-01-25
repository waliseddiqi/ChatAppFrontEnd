
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/local_message.dart';
import 'package:chat_app/models/local_messages.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/messages.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class MessagesField extends StatefulWidget {
 final GlobalKey<AnimatedListState> animatedListKey;
 final String id;
 final String username;
final List<LocalMessage> messages;
  MessagesField({Key key, this.animatedListKey, this.id, this.username, this.messages}) : super(key: key);


  @override
  _MyMessagesFieldState createState() => _MyMessagesFieldState();
}

class _MyMessagesFieldState extends State<MessagesField> {

LocalMessages messagesmodel;
bool _isLoading=false;
@override
  void initState() {
     
    super.initState();
   // _getMessages(widget.username, widget.id, messages)
   _getMessages();
  }
 void _getMessages()async{
  var box =  Hive.box(messages_Box);
      
setState(() {
    messagesmodel=box.get(widget.id)  as LocalMessages;
  });
if(messagesmodel!=null){
for (var i = 0; i < messagesmodel.messages.length; i++) {
        print(messagesmodel.messages[i].messagebody);
      }
  if(messagesmodel.messages.length>0){
    setState(() {
      
       widget.messages.addAll(messagesmodel.messages);
    });
 
  //widget.animatedListKey.currentState.insertItem(widget.messages.length-1,duration: Duration(milliseconds: 180));
  
       }
}
  
       }




  @override
  Widget build(BuildContext context) {
   
    Size size=MediaQuery.of(context).size;
    return
           
      Center(
       child: Container(

              height: size.height*0.80,
              child: ListView.builder(
                reverse: true,
                itemCount: widget.messages.length,
                //key: widget.animatedListKey,
               // initialItemCount: widget.messages.length,
                padding: EdgeInsets.zero,
              
                itemBuilder: (context,index)=>
             
                  listItems(context, index, widget.messages, size)
               
                
                ),
            
          ),
     
      
    );
  }
  Widget listItems(context,int index,List<LocalMessage> messages,Size size){
    return
    
    Container(
                child: Row(
                  children: [
                    Expanded(
                        
                      child: Align(
                        alignment: messages[messages.length-index-1].isOwn?Alignment.centerRight:Alignment.centerLeft,
                          child: Container(
                               constraints: BoxConstraints(minWidth: size.width*0.15, maxWidth: size.width*0.8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.height/70),
                            color: messages[messages.length-index-1].isOwn?Colors.green:Colors.blueGrey
                          ),
                          
                         
                          margin: EdgeInsets.only(left: size.width*0.01,bottom: size.height/70),
                          child: Padding(
                            padding: EdgeInsets.all(size.height/70),
                                      child: Container(
                              
                            
                              child: RichText(text: TextSpan(
                                children: [
                                
                                
                                  TextSpan(text:"${messages[messages.length-index-1].messagebody}",style: TextStyle(color: Colors.white,fontSize: size.height/50),)
                                  ,TextSpan(text: "    ${messages[messages.length-index-1].time}",style: TextStyle(color: Colors.white,fontSize: size.height/90,),)
                                ]
                              ))
                              ),
                          )),
                      ),
                    ),
                  ],
                ),
              );
  }
}