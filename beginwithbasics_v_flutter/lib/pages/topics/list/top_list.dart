import 'dart:convert';

import 'package:beginwithbasics_v_flutter/models/model.dart';
import 'package:beginwithbasics_v_flutter/models/subject.dart';
import 'package:beginwithbasics_v_flutter/services/render_html.dart';
import 'package:beginwithbasics_v_flutter/util/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopList extends StatefulWidget {
  @override
  _TopListState createState() => _TopListState();
}

class _TopListState extends State<TopList> {
  String _subName;
  List<Model> _listOfTopics = [];
  Model _model = Subject();
  DBService _dbService;
  bool _isInDetails = false;
  bool _exmpLoaded = false;
  int _modelIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      _dbService = DBService.dbService;
    });
  }

  @override
  void didChangeDependencies() {
    Map data = ModalRoute.of(context).settings.arguments;
    setState(() {
      _subName = data['subject'];
    });
    Model.queryField = Subject.subName;
    _loadList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _isInDetails
            ? null
            : AppBar(
                title: Text(
                  'Choose topic',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                automaticallyImplyLeading: !_isInDetails,
                backgroundColor: Colors.grey[100],
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: Colors.black45,
                ),
              ),
        bottomNavigationBar: _loadBottomNavbar(),
        body: _renderList());
  }

  _loadList() async {
    var topics =
        await _dbService.fetchEntityByField(_model, _subName.toLowerCase());

    setState(() {
      _listOfTopics = topics;
    });
  }

  _renderList() {
    if (_isInDetails) {
      return _renderDetails();
    }
    return ListView.builder(
        itemCount: _listOfTopics.length,
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 300,
              height: 40,
              child: FlatButton(
                color: Colors.black12,
                child: Text(_listOfTopics[index].heading,style: TextStyle(
                  fontSize: 18,
                  color: Colors.red
                ),),
                onPressed: () {
                  setState(() {
                    _model = _listOfTopics[index];
                    _modelIndex = index;
                    _isInDetails = true;
                  });
                },
              ),
            ),
          );
        });
  }

  _renderDetails() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ListView(
      children: [
        Center(
          child: Text(
            _model.heading == null ? '' : _model.heading,
            style: TextStyle(
              fontSize: 30,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(
          color: Colors.black,
          indent: 10,
          endIndent: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(spreadRadius: 3, color: Colors.redAccent),
              ],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.red,
                width: 1,
              ),
              color: Colors.grey[200],
            ),
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                _model.sku == null ? '' : _model.sku,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Quantico',
                ),
              ),
            ),
          ),
        ),
        _model.codeExample == null
            ? SizedBox(
                height: .1,
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(spreadRadius: 3, color: Colors.redAccent),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.red,
                      width: 1,
                    ),
                    color: Colors.grey[200],
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        _model.codeExample == null ? '' : _model.codeExample,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'test',
                        ),
                      )),
                ),
              )
      ],
    );
  }

  _loadBottomNavbar() {
    return !_isInDetails
        ? null
        : BottomAppBar(
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                    elevation: 3,
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.blueGrey, width: 2)),
                    child: Icon(
                      Icons.navigate_before,
                      color: Colors.red,
                    ),
                    onPressed: _modelIndex == 0
                        ? null
                        : () {
                            if (_modelIndex > 0)
                              setState(() {
                                _model = _listOfTopics[--_modelIndex];
                              });
                          }),
                RaisedButton(
                    elevation: 3,
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.blueGrey, width: 2)),
                    child: Icon(
                      Icons.keyboard_return_sharp,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      SystemChrome.setEnabledSystemUIOverlays(
                          SystemUiOverlay.values);
                      setState(() {
                        _isInDetails = false;
                      });
                    }),
                RaisedButton(
                    elevation: 3,
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.blueGrey, width: 2)),
                    child: Icon(
                      Icons.autorenew_rounded,
                      color: Colors.red,
                    ),
                    onPressed: _model.codeExample == null
                        ? null
                        : () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return RenderHtml(
                                    code: _model.codeExample,
                                  );
                                });
                          }),
                RaisedButton(
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.red,
                    ),
                    elevation: 3,
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.blueGrey, width: 2)),
                    onPressed: _modelIndex == _listOfTopics.length - 1
                        ? null
                        : () {
                            if (_modelIndex < _listOfTopics.length - 1)
                              setState(() {
                                _model = _listOfTopics[++_modelIndex];
                              });
                          }),
              ],
            ),
          );
  }
}
