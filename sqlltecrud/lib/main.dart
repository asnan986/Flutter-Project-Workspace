import 'package:flutter/material.dart';
import 'package:sqlltecrud/models/contact.dart';
import 'package:sqlltecrud/utils/database_helper.dart';

const darkBlueColor = Color(0xff486579);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: darkBlueColor,
      ),
      home: MyHomePage(title: 'SQLite CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Contact _contact = Contact();
  List<Contact> _contacts = [];
  DatabaseHelper _dbHelper;
  final _formkey = GlobalKey<FormState>();
  final _ctrName = TextEditingController();
  final _ctrMobile = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
    _refreshedContactList();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            widget.title,
            style: TextStyle(color: darkBlueColor),
          )),
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[_form(), _list()])));
  }

  _form() => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _ctrName,
                decoration: InputDecoration(labelText: 'Full Name'),
                onSaved: (val) => setState(() => _contact.contactName = val),
                validator: (value) =>
                    (value.length == 0 ? 'This field is required' : null),
              ),
              TextFormField(
                controller: _ctrMobile,
                decoration: InputDecoration(
                    labelText: 'Mobile No',
                //errorText: value.length < 10 ? 'Provide Valid Mob No' : null),
                ),
                onSaved: (val) => setState(() => _contact.mobileNo = val),
                validator: (value) =>
                    (value.length < 10 ? 'Provide Valid Mob No' : null),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () => _onSubmit(),
                  child: Text('submit'),
                  color: darkBlueColor,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      );

  _refreshedContactList() async {
    var x = await _dbHelper.fetchContact();
    setState(() {
      _contacts = x;
    });
  }

  _onSubmit() async {
    var form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      if (_contact.id == null)
        await _dbHelper.insertContact(_contact);
      else
        await _dbHelper.updateContact(_contact);
      _refreshedContactList();
      print(_contact.contactName);
    }
    _resetForm();
  }

  _resetForm(){
    setState(() {
      _formkey.currentState.reset();
      _ctrMobile.clear();
      _ctrName.clear();
      _contact.id=null;
    });
  }

  _list() => Expanded(
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: darkBlueColor,
                        size: 40,
                      ),
                      title: Text(
                        _contacts[index].contactName,
                        style: TextStyle(
                            color: darkBlueColor, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(_contacts[index].mobileNo),
                      onTap: () {
                        setState(() {
                          _contact = _contacts[index];
                          _ctrName.text=_contact.contactName;
                          _ctrMobile.text=_contact.mobileNo;
                        });
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete,color: darkBlueColor,),
                        onPressed: ()async{
                          await _dbHelper.deleteContact(_contacts[index].id);
                          _resetForm();
                          _refreshedContactList();
                        },
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    )
                  ],
                );
              }),
        ),
      );
}
