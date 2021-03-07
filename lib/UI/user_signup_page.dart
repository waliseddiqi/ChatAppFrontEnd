
import 'dart:convert';
import 'dart:io';

import 'package:chat_app/UI/select_private.dart';
import 'package:chat_app/core/enums.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/viewModels/socketConnet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../api.dart';
import 'chat_main.dart';
import 'offline_page.dart';

class UserSignUpPage extends StatefulWidget{
 
final BuildContext mainContext;
  const UserSignUpPage({Key key, this.mainContext}) : super(key: key);
  @override
  _UserSignUpPageState createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  ScrollController scrollController=new ScrollController();
  User user=new User();
  String _gender="Female";
  String _password="";
  bool ismale=false;
final picker = ImagePicker();
  bool isfemale=true;
  File file;
  bool gender=true;

  SocketConnect socketConnect;

  API api=new API();
  String email="";
  void getEmail()async{
     SharedPreferences prefs=await SharedPreferences.getInstance();
       email=prefs.getString("email");
  }

  @override
  void initState() {
    SocketConnect.connect();
    super.initState();
    getEmail();
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

    Future getImage(ImageSource source,Size size) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
       // showAcceptDialog(context,size);
      } else {
        print('No image selected.');
      }
    });
  }

      void showDialog(BuildContext context,Size size){
     showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) +   0.2;
          return Material(
            color: Colors.transparent,
                      child: Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * size.height/3.687,0.0),
              child: Opacity(
                opacity: a1.value,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size.height/30)
                      ),
                     
                       height: size.height/3.7,
                        width: size.width/1.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("Profile Photo",style: TextStyle(fontWeight: FontWeight.w700,fontSize: size.height/52.67),),
                           ),
                         ],
                       ),
                        Container(
                       
                       
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          Column(
                            children: [
                              IconButton(icon: Icon(Icons.photo), onPressed: (){
                                getImage(ImageSource.gallery, size);
                                  Navigator.pop(context);

                              }),
                              Text("Gallery")
                            ],
                          ),
                            Column(
                              children: [
                                IconButton(icon: Icon(Icons.photo_camera), onPressed: (){
                                     getImage(ImageSource.camera, size);
                                       Navigator.pop(context);
                                }),
                                Text("Camera")
                              ],
                            )
                          ],
                        ),
                      ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: new FlatButton(
                                child: new Text('Okay',style: TextStyle(fontWeight: FontWeight.w700,fontSize: size.height/52.67)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                           ),
                         ],
                       ),

                        ],
                      ),
                    
                     
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 350),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  Future _validateAndSubmit() async {

    if (_isValidForm()) {
        /* socketConnect=new SocketConnect();
         user.gender=_gender;
   
         print(user.gender);
      socketConnect.emitUserSignup(user.name,user.age);*/
        user.age=_birthday;
        SharedPreferences prefs=await SharedPreferences.getInstance();
        String notificationid=prefs.getString("notificationId");
        print(notificationid);
        if(file!=null){
          api.signupUser(user.name, user.age,file,notificationid).then((value)async{
            if(value.statusCode==200){
              var parsed=json.decode(value.body);
            
              print(parsed);
              prefs.setString("username", parsed["username"]);
              prefs.setString("userid", parsed["userid"]);
           //auth signup
          //after general signup datas saved put userid in personal infos in database
              api.signUp(email, _password,user.name,parsed["userid"],notificationid).then((value)async{
              var parsed=json.decode(value.body);
              print(parsed);
              SharedPreferences prefs=await SharedPreferences.getInstance();
              prefs.setString("token", parsed["token"]);
       
       // print(parsed["token"]);
          });
        }else{
        print("couldnt create user");
        }
      });
      
      }
      else{
          SharedPreferences prefs=await SharedPreferences.getInstance();
          String notificationid=prefs.getString("notificationId");
          print(notificationid);
          api.signupUserwithOutImage(user.name, user.age,notificationid).then((value)async{
            if(value.statusCode==200){
            var parsed=json.decode(value.body);
       
            print(parsed);
            prefs.setString("username", parsed["username"]);
            prefs.setString("userid", parsed["userid"]);
          //auth signup
          //after general signup datas saved put userid in personal infos in database
            api.signUp(email, _password,user.name,parsed["userid"],notificationid).then((value)async{
              var parsed=json.decode(value.body);
              print(parsed);
              SharedPreferences prefs=await SharedPreferences.getInstance();
              prefs.setString("token", parsed["token"]);
       
       // print(parsed["token"]);
      });
          }else{
       
          print("couldnt create user");
          }
      });

      }
     
      }
      
      }
  String _nameFieldValidator(String name){
    if(name==null||name==""){
      return "Please Enter your name";
    }
  }
  String _passswordValidator(String name){
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
    var connectionStatus = Provider.of<ConnectivityStatus>(widget.mainContext);
   return connectionStatus == ConnectivityStatus.Offline?OfflinePage():
     Scaffold(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Container(
                       
                child: Text("Registeration",style:TextStyle(fontSize: size.height/25,fontWeight: FontWeight.w600)),),
                Column(
                  children: [
                    InkWell(
                      splashColor: Colors.black,
                      highlightColor: Colors.redAccent,
                      borderRadius: BorderRadius.circular(100),
                      onTap: (){
                        //print("Add profile");
                        showDialog(context, size);

                      },
                        child: Opacity(
                        opacity: 0.7,
                          child:file!=null?
                           Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              image: DecorationImage(image:FileImage(file) ),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          width: 100,
                          height: 100,
                          child: Icon(Icons.account_circle,color: Colors.black,size: size.height/15,),
                        ):
                           Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                             
                              borderRadius: BorderRadius.circular(100)
                          ),
                          width: 100,
                          height: 100,
                          child: Icon(Icons.account_circle,color: Colors.black,size: size.height/15,),
                        ),
                      ),
                    ),
                    Text("Tap to add Profile Photo",style: TextStyle(fontSize: size.height/70),)
                  ],
                )


            ],
          ),
                   
         
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
                decoration: InputDecoration(hintText: "Username",),),
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
                  onSaved: (pass)=>_password=pass,
                  validator: _passswordValidator,
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
                  validator: _passswordValidator,
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
            _validateAndSubmit().then((value){
              
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMain()));
     
            });
                    
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