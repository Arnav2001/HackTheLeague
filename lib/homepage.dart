import 'package:flutter/material.dart';
import 'package:hacktheleague/colorscheme.dart';
import 'package:hacktheleague/notification.dart';


class Topic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Course_Progress()
          ],
        ),
      ),
    );
  }
}

class Course_Progress extends StatelessWidget {
  final modulesList=Module.generateModules();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          Image.asset("asset/dog.jpg",fit: BoxFit.fill,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('The progress',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kFont
              ),),
            ],
          ),
          SizedBox(height: 20,),
          ...modulesList.map((e) => CourseModule(e)).toList()
        ],
      ),
    );
  }
}

class Module{
  late Color iconBorder;
  late Color iconBg;
  late Color iconColor;
  late IconData icon;
  late String desc;
  late Color moduleBg;
  late Color buttonColor;
  late Color buttonFont;
  late DateTime time;
  late String lesson;

  Module(
      this.iconBorder,this.iconBg,this.iconColor,this.icon,this.desc,this.moduleBg,
      this.buttonColor,this.buttonFont,this.time,this.lesson
      );
  DateTime now=new DateTime.now();
  static List<Module> generateModules(){
    return [
      Module(kAccent,
          kAccent,
          Colors.white,
          Icons.play_arrow_rounded,
          'Medicine 1',
          lightBlue,
          Colors.white,
          kPrimaryDark,
          DateTime.now(),
          '1 lesson'),

      Module(kFontLight.withOpacity(0.3),
          Colors.white,
          kFontLight.withOpacity(0.7),
          Icons.lock_outline_rounded,
          'Medicine 2',
          Colors.white,
          Colors.grey.withOpacity(0.2),
          Colors.grey,
          DateTime.now(),
          '5 Questions'),
    ];
  }
}

class CourseModule extends StatelessWidget {
  final Module module;
  CourseModule(this.module);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Row(
        children: [
          Flexible(flex: 1,
            child: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: module.iconBorder,
                            width: 2,),
                          color: module.iconBg,
                          shape: BoxShape.circle
                      ),
                      child: Icon(module.icon,size: 30,color: module.iconColor,),
                    ),
                    Expanded(child: Column(
                        children:
                        List.generate(20, (index) => Expanded(
                          child: Container(
                            width: 2,
                            color: index%2==0?Colors.transparent:module.iconBorder,
                          ),
                        ))
                    ))
                  ],
                )
            ),),
          Flexible(flex: 5,child: GestureDetector(
            onTap: (){print('tap');},
            child: Container(
              height: 160,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                  border: Border.all(color: darkBlue,width: 2),
                  color: module.moduleBg,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${module.time.hour}:${module.time.minute}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: darkBlue,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(module.desc,
                    style: TextStyle(
                        fontSize: 18,
                        color: kFont.withOpacity(0.7),
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(height: 15,),
                  _buildButton()
                ],
              ),
            ),
          ),)
        ],
      ),
    );
  }

  _buildButton(){
    return GestureDetector(
      child: Container(width: 60,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: module.buttonColor,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            //image
            SizedBox(width: 5,),
            Text("Done",style: TextStyle(color: module.buttonFont,
                fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      onTap: (){
        NotificationAPI.showNotification(
          title:'hi',
          body: 'hello',
          payload: 'hi.abs'
        );
      },
    );
  }
}