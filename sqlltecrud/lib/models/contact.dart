class Contact{

  static const coName='name';
  static const coMobile='mobile';
  static const coId='id';
  static const tblContact='contacts';

  int id;
  String contactName;
  String mobileNo;

  Contact({this.id,this.contactName,this.mobileNo}){}

  Contact.fromMap(Map<String,dynamic> map){
    id=map[coId];
    contactName=map[coName];
    mobileNo=map[coMobile];
  }

  Map<String,dynamic> toMap(){
    var map= <String,dynamic>{coName:contactName,coMobile:mobileNo};
    if (id!=null) map[coId]=id;
    return map;
  }



}