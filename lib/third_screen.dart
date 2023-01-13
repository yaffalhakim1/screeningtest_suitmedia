import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:suitmedia_test_one/second_screen.dart';

class ListName {
  int id;
  String email;
  String first_name;
  String last_name;
  String avatar;
  // int page;
  // int per_page;

  ListName({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar,
    //  required this.page,
    //  required this.per_page,
  });

  factory ListName.fromJson(Map<String, dynamic> json) {
    return ListName(
      id: json['id'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      avatar: json['avatar'],
      // page: json['page'],
      // per_page: json['per_page'],
    );
  }
}

class Third extends StatefulWidget {
  Third({Key? key}) : super(key: key);

  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  int page = 1;
  int per_page = 10;
  List<ListName> _DataList = [];
  Future<List<ListName>>? _future;
  ScrollController _controller = ScrollController();

  Future<List<ListName>> getData(int page, int per_page) async {
    String url = Uri.encodeFull(
        "https://reqres.in/api/users?page=$page&amp;per_page=$per_page");
    var response = await http
        .get(
          Uri.parse(url),
        )
        .timeout(const Duration(seconds: 3));

    _DataList.insertAll(
        0,
        (json.decode(response.body)['data'] as List<dynamic>)
            .map((e) => ListName.fromJson(e))
            .toList());
    page++;
    return _DataList;
  }

  @override
  void initState() {
    _future = getData(page, per_page);

    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          _future = getData(page, per_page);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Third Screen',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext ctx, AsyncSnapshot<List<ListName>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Error"));
          }

          var dataToShow = snapshot.data;

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _future = getData(page, per_page);
              });
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Divider(
                color: Color(0xffe2e3e4),
              ),
              controller: _controller,
              itemCount: dataToShow == null ? 0 : dataToShow.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Second(
                          user: '',
                          id: snapshot.data![index].id,
                          name: snapshot.data![index].first_name +
                              ' ' +
                              snapshot.data![index].last_name,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(dataToShow![index].avatar),
                  ),
                  title: Text(
                    dataToShow[index].first_name +
                        " " +
                        dataToShow[index].last_name,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    dataToShow[index].email,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Color(0xff686777),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
