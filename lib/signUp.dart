import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _firebase = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _hiddenPassword = true;
  bool _isAuthenticating = false;
  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredUsername = '';
  bool isChecked = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid || !_isLogin) {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text('Please fill in all fields'),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () {
            _form.currentState!.reset();
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if (isChecked) {
        setState(() {
          _isLogin = true;
        });
      }
    } else {
      try {
        setState(() {
          _isAuthenticating = true;
        });

        if (_isLogin) {
          final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail,
            password: _enteredPassword,
          );
          if (userCredentials.user != null) {
            // Successful login
            print("Login successful: ${userCredentials.user!.uid}");
          } else {
            // Handle authentication failure
            print("Login failed");
          }
        } else {
          final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail,
            password: _enteredPassword,
          );
          if (userCredentials.user != null) {
            // Successful registration
            print("Registration successful: ${userCredentials.user!.uid}");

            await FirebaseFirestore.instance.collection('users').add({
              'username': _enteredUsername,
              'email': _enteredEmail,
              'password': _enteredPassword,
            });
          } else {
            // Handle registration failure
            print("Registration failed");
          }
        }
      } on FirebaseAuthException catch (error) {
        print("FirebaseAuthException: ${error.code} - ${error.message}");
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ));
      } catch (error) {
        print("Error: $error");
      } finally {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: _isLogin
            ? const Text(
          'Login',
          style: TextStyle(color: Colors.black),
        )
            : const Text(
          'Sign Up',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (!_isLogin)
                            TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please enter at least 4 characters';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(21),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black54,
                                    width: 1,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(21),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black54,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(21),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black54,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(21),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                ),
                              ),
                              enableSuggestions: false,
                              onSaved: (value) {
                                _enteredUsername = value!;
                              },
                            ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(21),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(21),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(21),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(21),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                ),
                              ),
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,

    validator: (value) {
    if (value == null || value.trim().isEmpty) {
    return 'Please enter an email address.';
    }
    return null;
    },


    onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(21),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(21),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(21),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(21),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                ),
                              ),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _hiddenPassword = !_hiddenPassword;
                                  });
                                },
                                icon: _hiddenPassword == true
                                    ? const Icon(Icons.remove_red_eye_outlined)
                                    : const Icon(Icons.password),
                              ),
                            ),
                            obscureText: _hiddenPassword,
                            obscuringCharacter: '*',
                            validator: (value) {
                              if (value == null || value.trim().length < 8) {
                                return 'Password must be at least 8 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      if (_isLogin == false)
                                        Checkbox(
                                          value: isChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isChecked = value!;
                                            });
                                          },
                                        ),
                                      Text(
                                        _isLogin
                                            ? ''
                                            : 'By signing up, you agree to the ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                          height: 0.09,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1),
                                  InkWell(
                                    child: Text(
                                      _isLogin
                                          ? ''
                                          : 'Terms of Service and Privacy Policy',
                                      style: TextStyle(
                                        color: Color(0xFF7E3DFF),
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                        height: 0.09,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (_isAuthenticating) CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  _submit();
                                },
                                child: Text(_isLogin ? 'Login' : 'Signup'),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color(0xFF7E3DFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),

                          SizedBox(height: 20),
                          Text(
                            'Or with',
                            style: TextStyle(
                              color: Color(0xFF90909F),
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0.09,
                            ),
                          ),
                          SizedBox(height: 20),
                          Image.asset('assets/component/images/signupwithgoogle.png'),
                          SizedBox(height: 20),
                          if (!_isAuthenticating)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _isLogin
                                      ? 'Create an account?'
                                      : 'I already have an account?',
                                  style: TextStyle(
                                    color: Color(0xFF90909F),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                      _form.currentState!.reset();
                                    });
                                  },
                                  child: Text(
                                    _isLogin ? 'Sign Up' : 'Login',
                                    style: TextStyle(
                                      color: Color(0xFF7E3DFF),
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xFF7E3DFF),
                                      decorationThickness: 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
