import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class ProfileAndSettings extends StatefulWidget{
  final String username;
  final String userid;

  const ProfileAndSettings({Key key, this.username, this.userid}) : super(key: key);
  @override
  _ProfileAndSettingsState createState() => _ProfileAndSettingsState();
}

class _ProfileAndSettingsState extends State<ProfileAndSettings> {
final picker = ImagePicker();
  File file;
  API api=new API();

     Future getImage(ImageSource source,Size size) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        api.updateProfilePhoto(userid: widget.userid,file: file);
      } else {
        print('No image selected.');
      }
    });
  }


@override
Widget build(BuildContext context) {
  Size size=MediaQuery.of(context).size;
  return Stack(
    children: [
       Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                 height: size.height/5,
                  width: size.width,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: size.height/45),
                      child: Center(child: Text("Profile",style: TextStyle(fontSize: size.height/35,color: Colors.white))),
                    ),
                  ),
                  decoration: BoxDecoration(
                  color: Colors.red[400],
                  ///borderRadius: BorderRadius.only(bottomLeft: Radius.circular(300)),
                  ),
                ),
                ),
                Container(
                    margin: EdgeInsets.only(top: size.height/20),
               
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(40),),
                      ),
                      child: Column(
                        
                        children: [
                          Form(

                                                      child: Center(
                              child: Container(
                               
                                width: size.width/1,
                                height: size.height/3,
                                 decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
                      ),
                      ///Picture
                      child:Stack(
                        children: [
                      
                            Center(
                              child: Container(
                                  height: size.height/4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        child: ClipOval(
                                          child:
                                          
                                          file==null? Image.network(
                                          
                                         "http://192.168.1.234:5000/images/"+widget.userid+".jpg",
                                          //placeholder: (context, url) => Icon(Icons.account_circle,size: size.height/30,),
                                          fit: BoxFit.fill,
                                          
                                          ):Image.file(file),
                                        ),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                              Positioned(
                            left: size.width/1.75,
                            top: size.height/4.6,
                            child: IconButton(
                              
                              onPressed: (){
                                showDialog(context, size);
                              },
                              icon: Icon(Icons.camera_enhance,size: size.height/17,color: Colors.orange,
                            
                            ),)),
                        ],
                      ),
                              ),
                            ),
                          ),


                          ///Username field
                          Container(
                            width: size.width/1.1,
                            child: Column(
                              children: [
                               /* Row(
                                  children: [
                                    
                                    Text("Username:  ${widget.username}")
                                  ],
                                )*/
                                TextFormField(
                                  style: TextStyle(fontSize: size.height/35),
                                  decoration: InputDecoration(
                                    labelText: "Username",
                                    
                                    hintText: "${widget.username}"
                                  ),
                                ),
                              ],
                            ),
                          )
                          
                        ],
                      ),
                )
    ],
  );
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

}