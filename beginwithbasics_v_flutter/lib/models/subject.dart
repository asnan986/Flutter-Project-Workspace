import 'package:beginwithbasics_v_flutter/models/model.dart';

class Subject extends Model{

  //static properties of the class to map with database table
  static const subId='id';
  static const subName='topic';
  static const subHead='heading';
  static const subSku='description';
  static const subExmp='codeeg';
  static const tableName='content_table';

  int id;
  String subjectName;
  String heading;
  String sku;
  String codeExample;
  //overrided property
  Map map={'id':subId,'topic':subName,'tableName':tableName};

  Subject({this.id,this.heading,this.codeExample,this.sku,this.subjectName});

  Subject.fromMap(Map<String,dynamic> map){
    id=map[subId];
    subjectName=map[subName];
    heading=map[subHead];
    sku=map[subSku];
    codeExample=map[subExmp];
  }

  @override
  Model fromMap(Map<String,dynamic> map){
    return Subject.fromMap(map);
  }

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{subName:subjectName,subHead:heading,subSku:sku,subExmp:codeExample};
    if(id!=null) map[subId]=id;
    return map;
  }


}