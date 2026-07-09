import 'package:flutter/material.dart';
import 'CreateAccount.dart';
import '../widget/BottomNavigationBar.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, password;
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Color(0xFF3D6C91),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.person),
                    labelText: "Name",
                    hintText: "Enter Your Name", // placeholder
                    suffixIconColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onSaved: (newValue) => {name = newValue},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    labelText: "Password",
                    hintText: "Enter Your Password", // placeholder
                    suffixIconColor: Colors.black,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onSaved: (newValue) => {password = newValue},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required";
                    }
                    if (value.length < 3) {
                      return "3 letters required or more";
                    }
                  },
                  obscureText: _showPassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => bottomnavigationbar()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("تم تسجيل الدخول بنجاح")));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      //: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
