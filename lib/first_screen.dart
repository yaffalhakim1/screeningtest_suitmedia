import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suitmedia_test_one/second_screen.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  String? user;
  final TextEditingController palindrome = TextEditingController();
  final TextEditingController nama = TextEditingController();

  void cekPalindrom() {
    String? palindromeString = palindrome.text;

    // then we will reverse the input
    String? reverse = palindromeString.split('').reversed.join('');
    // then we will compare
    if (palindromeString == reverse) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Palindrom"),
              content: Text("isPalindrome"),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Palindrom"),
              content: Text("not palindrome"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 180.0, bottom: 50),
                  child: Image.asset(
                    'assets/btn_add_photo.png',
                    width: 116,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  height: 40,
                  child: TextFormField(
                    onChanged: (val) => user = val,
                    controller: nama,
                    decoration: InputDecoration(
                      // hintText: 'Name',

                      hintStyle: TextStyle(
                        color: Color(0xff6867775C),
                        fontSize: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  height: 40,
                  child: TextFormField(
                    controller: palindrome,
                    decoration: InputDecoration(
                      // hintText: 'Palindrome',
                      hintStyle: TextStyle(
                        color: Color(0xff6867775C),
                        fontSize: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                GestureDetector(
                  onTap: () {
                    cekPalindrom();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 41,
                      decoration: BoxDecoration(
                        color: Color(0xff2B637B),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          'CHECK',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Second(
                          id: 0,
                          user: user ?? 'No Name',
                          name: '',
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, bottom: 100),
                    child: Container(
                      height: 41,
                      decoration: BoxDecoration(
                        color: Color(0xff2B637B),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          'NEXT',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
