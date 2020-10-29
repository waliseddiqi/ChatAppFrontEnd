import 'package:chat_app/UI/chat_main_page.dart';
import 'package:chat_app/UI/select_private.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/viewModels/socketConnet.dart';
import 'package:flutter/material.dart';

class UserSignUpPage extends StatefulWidget{
 

  const UserSignUpPage({Key key}) : super(key: key);
  @override
  _UserSignUpPageState createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  ScrollController scrollController=new ScrollController();
  User user=new User();
  String _gender="Female";

  bool ismale=false;

  bool isfemale=true;

  bool gender=true;

  SocketConnect socketConnect;



  @override
  void initState() {
    SocketConnect.connect();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isValidForm() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {

    if (_isValidForm()) {
         socketConnect=new SocketConnect();
         user.gender=_gender;
         print(user.gender);
      socketConnect.emitUserSignup(user.name,user.age,user.gender);
       
      }}
  String _nameFieldValidator(String name){
    if(name==null||name==""){
      return "Please Enter your name";
    }
  }
   String _ageFieldValidator(String age){
    if(age==null||age==""){
      return "Please Enter your age";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
              child: Center(
          child: Container(
              child: Form(
                key: _formKey,
                child: 
              Container(
             
                margin: EdgeInsets.only(top: size.height/15),
                child: Column(
               
                  children: [
          Container(
                   
            child: Text("Registeration",style:TextStyle(fontSize: size.height/25,fontWeight: FontWeight.w600)),),
                   
          Container(
             height: size.height/7,
            margin: EdgeInsets.only(right: size.width/7,top: size.height/15),
            width: size.width/1.3,
            child: Column(
             
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("Name or Nickname",style:TextStyle(fontSize: size.height/50,fontWeight: FontWeight.w600)),
                SizedBox(height: size.height/110,),
                TextFormField(
                  onSaved: ( name)=>user.name=name,
                  validator: _nameFieldValidator,
                  decoration: InputDecoration(hintText: "Name or Nickname",
                 border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey)),
                ),
                
                ),
              ],
            ),
          ),
           Container(
             height: size.height/7,
              margin: EdgeInsets.only(right: size.width/7,top: size.height/15),
            width: size.width/1.3,
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
             
              children: [
                Text("Age",style:TextStyle(fontSize: size.height/50,fontWeight: FontWeight.w600)),
                SizedBox(height: size.height/110,),
                TextFormField(
                  onSaved: (age) =>user.age=age ,
                  validator: _ageFieldValidator,
                  decoration: InputDecoration(hintText: "Age",
                 border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.grey)),
                ),
                
                ),
              ],
            ),
          ),
           Container(
              margin: EdgeInsets.only(right: size.width/7,top: size.height/15),
            width: size.width/1.3,
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text("Gender",style:TextStyle(fontSize: size.height/50,fontWeight: FontWeight.w600)),
                Container(
                  child: Row(
                    children: [

                      Text("Female"),
                      Radio(value:isfemale, groupValue: gender, onChanged: (bool istrue){
                    
                        setState(() {
                              isfemale=!isfemale;
                                ismale=!ismale;
                                
                            
                        });
                         if(isfemale){
                            _gender="Female";
                           }
                       
                      }),
                      SizedBox(width: size.width/8),
                      Text("Male"),
                       Radio(value:ismale, groupValue: gender, onChanged: (bool istrue){
                    
                        setState(() {
                              ismale=!ismale;
                               isfemale=!isfemale;
                               
                                 
                        });
                        if(ismale){
                                  _gender="Male";
                                }
                        
                      }),
               

                    ],
                  ),
                ),
              ],
            )
          ),
            Container(
              
                  width: size.height/4,
                  height: size.height/15,
                  child: MaterialButton(
          
          color: Colors.blueAccent,
          child: Text("Sign up",style:TextStyle(color: Colors.white) ,),
          onPressed: (){
         //   _validateAndSubmit();
          /// //then navigate
          /// 
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMainPage()));
                
                  }),
                )





                  ],
                ),
              )
              ),
            ),
        ),
      ),
    );
  }
  }