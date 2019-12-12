import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nudge/models/deptModel.dart';
import 'package:nudge/providers/updateDeptProvider.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/views/createClass.dart';
import 'package:nudge/widgets/textFields.dart';
import 'package:provider/provider.dart';

class UpdateDepartment extends StatefulWidget {
  @override
  _UpdateDepartmentState createState() => _UpdateDepartmentState();
}

class _UpdateDepartmentState extends State<UpdateDepartment> {
  UpdateDeptProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UpdateDeptProvider>(context);
    provider.homeContext = context;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: white,
      ),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/logo_blue.png',
                scale: 3,
              ),
            ),
            Container(
              height: 120,
              child: Image.asset(
                'assets/images/clip-education.png',
                scale: 5,
              ),
            ),
            const YMargin(20),
            Center(
              child: Text(
                'Select your Department',
                style: TextStyle(
                    fontWeight: FontWeight.w200, fontSize: 14, color: black),
              ),
            ),
            const YMargin(40),
            provider.isLoading
                ? Center(
                    child: Container(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(),
                  ))
                : BuildUI(context, provider: provider)
          ],
        ),
      ),
    );
  }
}

class BuildUI extends StatelessWidget {
  final UpdateDeptProvider provider;
  final homeContext;

  const BuildUI(this.homeContext, {Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: provider.deptsList,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
              child: Container(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(),
          ));
        return BuildFeedList(snapshot.data.documents, provider, homeContext);
      },
    );
  }
}

class BuildFeedList extends StatelessWidget {
  final List<DocumentSnapshot> snapshot;
  final UpdateDeptProvider provider;
  final homeContext;
  const BuildFeedList(this.snapshot, this.provider, this.homeContext);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DepartmentSearch(provider),
          if (snapshot.length > 0)
            for (DocumentSnapshot data in snapshot)
              if (provider.isSearching)
                if (data['name']
                    .toString()
                    .toLowerCase()
                    .contains(provider.searchTEC.text.toLowerCase()))
                  Padding(
                    padding: EdgeInsets.all(14),
                    child: OutlineButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        data['name'],
                        style: TextStyle(
                            fontSize: 16,
                            color: blue,
                            fontWeight: FontWeight.w400),
                      ),
                      onPressed: () {
                        var deptModel = DeptModel.fromSnapshot(data);
                        provider.selectDept(deptModel, context);
                      },
                    ),
                  )
                else
                  Container()
              else
                Padding(
                  padding: EdgeInsets.all(14),
                  child: OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      data['name'],
                      style: TextStyle(
                          fontSize: 16,
                          color: blue,
                          fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {
                      var deptModel = DeptModel.fromSnapshot(data);
                      provider.selectDept(deptModel, context);
                    },
                  ),
                )
          else
            NoDept(),
          snapshot.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 55,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateClass(),
                            ),
                          );
                        },
                        child: Text(
                          'Can\'t find My Department!',
                          style: TextStyle(
                              fontSize: 11, fontFamily: 'GalanoGrotesque2'),
                        ),
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}

class EmptyUI extends StatelessWidget {
  const EmptyUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const YMargin(60),
          Opacity(
            opacity: 0.2,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://media.istockphoto.com/vectors/open-box-icon-vector-id635771440?k=6&m=635771440&s=612x612&w=0&h=IESJM8lpvGjMO_crsjqErVWzdI8sLnlf0dljbkeO7Ig=',
                          scale: 3))),
            ),
          ),
          const YMargin(20),
          Text('No Departments Found'),
        ],
      ),
    );
  }
}

class NoDept extends StatelessWidget {
  const NoDept({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const YMargin(90),
          Opacity(
            opacity: 0.2,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://media.istockphoto.com/vectors/open-box-icon-vector-id635771440?k=6&m=635771440&s=612x612&w=0&h=IESJM8lpvGjMO_crsjqErVWzdI8sLnlf0dljbkeO7Ig=',
                          scale: 3))),
            ),
          ),
          Text('Can\'t find your Department?'),
          Container(
            height: 55,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: FlatButton(
              color: blue,
              textColor: white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateClass(),
                  ),
                );
              },
              child: Text(
                'Register your Class as an Admin',
                style: TextStyle(fontSize: 14, fontFamily: 'GalanoGrotesque2'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
