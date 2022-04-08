abstract class Model{

  //common properties for all inheried classes
  final Map map={};
  int id;
  static dynamic queryField;

  //properties for class Subject
  String subjectName;
  String heading;
  String sku;
  String codeExample;


  Model fromMap(Map<String,dynamic> map);
  Map<String,dynamic> toMap();


}