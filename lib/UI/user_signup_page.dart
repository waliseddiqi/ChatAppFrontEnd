
import 'package:chat_app/UI/select_private.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/viewModels/socketConnet.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import 'chat_main.dart';

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

  API api=new API();


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
         user.age=_birthday;
         print(user.gender);
      socketConnect.emitUserSignup(user.name,user.age);
       
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

  DateTime _birthdaydate=new DateTime(2010);
  Future<DateTime> _showDatepicker(){
    return showDatePicker(
      context: context, 
      initialDate: new DateTime(2000), 
      firstDate: new DateTime(1900), 
      lastDate: new DateTime(2015));
  }
  String _birthday="2000-10-10";

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
              margin: EdgeInsets.only(left: size.width/55,top: size.height/20),
            width: size.width/1.1,
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
             
              children: [
                Text("Username",style:TextStyle(fontSize: size.height/50,fontWeight: FontWeight.w600)),
                SizedBox(height: size.height/110,),
                TextFormField(
                  onSaved: (name) =>user.name=name ,
                  validator: _ageFieldValidator,
                  style: TextStyle(fontSize: size.height/42),
                  decoration: InputDecoration(hintText: "Username",
                  
                ),
                
                ),
              ],
            ),
          ),
           Container(
          
          
           margin: EdgeInsets.only(left: size.width/20),
            child: Row(
          
              children: [
                Container(
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text("Date of Birthday",style:TextStyle(fontSize: size.height/50,fontWeight: FontWeight.w600)),
                      Container(
                        
                        child: Container(
                          width: size.width/2,
                           margin: EdgeInsets.only(top: size.height/30),
                          child: Text("$_birthday",style: TextStyle(fontSize: size.height/42),)
                        ),
                      ),
                    ],
                  ),
                ),
                 Container(
                  margin: EdgeInsets.only(left: size.width/27,top: size.height/30),
                  width: size.height/5,
                  height: size.height/18,
                  child: MaterialButton(
                  color: Colors.blueAccent,
                  child: Text("Select Date",style:TextStyle(color: Colors.white) ,),
                  onPressed: (){
                  _showDatepicker().then((data){
                    setState(() {
                      _birthdaydate=data;
                      _birthday="${_birthdaydate.year}-${_birthdaydate.month}-${_birthdaydate.day}";
                    
                    });
                  }
                  
                  );
                  
                  }),
                        )
              ],
            )
          ),
           Container(
             height: size.height/7,
            margin: EdgeInsets.only(left: size.width/55,top: size.height/15),
            width: size.width/1.1,
            child: Column(
             
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("Password",style:TextStyle(fontSize: size.height/42,fontWeight: FontWeight.w600)),
                SizedBox(height: size.height/110,),
                TextFormField(
                 
                  obscureText: true,
                 // onSaved: ( name)=>user.name=name,
                  validator: _nameFieldValidator,
                  decoration: InputDecoration(
                
               
                ),
                
                ),
              ],
            ),
          ),
           Container(
             height: size.height/7,
            margin: EdgeInsets.only(left: size.width/55),
            width: size.width/1.1,
            child: Column(
             
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("Confirm Password",style:TextStyle(fontSize: size.height/42,fontWeight: FontWeight.w600)),
                SizedBox(height: size.height/110,),
                TextFormField(
                 
                  obscureText: true,
                 // onSaved: ( name)=>user.name=name,
                  validator: _nameFieldValidator,
                  decoration: InputDecoration(
                
               
                ),
                
                ),
              ],
            ),
          ),
            Container(
                   margin: EdgeInsets.only(top: size.height/12),
                  width: size.height/4,
                  height: size.height/15,
                  child: MaterialButton(
          
          color: Colors.blueAccent,
          child: Text("Sign up",style:TextStyle(color: Colors.white) ,),
          onPressed: (){
            _validateAndSubmit();
         
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMain()));
                
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