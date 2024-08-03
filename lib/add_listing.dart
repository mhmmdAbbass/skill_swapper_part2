import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home.dart';

class AddListingPage extends StatefulWidget {
  final int userId; // Add this line

  AddListingPage({required this.userId}); // Add this line

  @override
  _AddListingPageState createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  final _formKey = GlobalKey<FormState>();
  String _skill = '';
  String _bio = '';
  String _neededSkill = '';
  String _cost = '';
  String _location = '';
  bool _isPaid = false;
  bool _useGoogleMaps = false;
  double _rating = 0.0;
  bool _isLoading = false;
  Uint8List? _selectedImageData;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      _selectedImageData = await pickedImage.readAsBytes();
      setState(() {});
    }
  }

  Future<void> _addSkill() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://skillswaper.atwebpages.com/add_skill.php'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'action': 'add_skill',
          'userId': widget.userId, // Pass userId here
          'skill': _skill,
          'bio': _bio,
          'needed_skill': _isPaid ? '' : _neededSkill,
          'cost': _isPaid ? _cost : '',
          'is_paid': _isPaid ? '1' : '0',
          'use_google_maps': _useGoogleMaps.toString(),
        }),
      );

      final responseBody = response.body;
      print('Server response status: ${response.statusCode}');
      print('Server response: $responseBody');

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(responseBody);
        if (responseData['success']) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirmation'),
                content: Text('Skill added successfully!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                              userId: widget.userId), // Pass userId here
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          _showErrorDialog(responseData['message']);
        }
      } else {
        _showErrorDialog('An error occurred. Please try again.');
      }
    } catch (e) {
      _showErrorDialog(
          'An error occurred while saving your data. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Your Skill',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF673AB7),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF673AB7),
                    Color(0xFF9C27B0),
                  ],
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 150,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text('Camera'),
                                      onTap: () {
                                        _pickImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.image),
                                      title: Text('Gallery'),
                                      onTap: () {
                                        _pickImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(100),
                            image: _selectedImageData != null
                                ? DecorationImage(
                                    image: MemoryImage(_selectedImageData!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _selectedImageData == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  size: 80,
                                  color: Colors.grey[700],
                                )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Skill Offered',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the skill you are offering';
                        }
                        return null;
                      },
                      onSaved: (value) => _skill = value!,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Short Bio',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      maxLines: 3,
                      onSaved: (value) => _bio = value!,
                    ),
                    SizedBox(height: 16),
                    SwitchListTile(
                      title: Text('Paid Skill?'),
                      value: _isPaid,
                      onChanged: (value) {
                        setState(() {
                          _isPaid = value;
                        });
                      },
                    ),
                    if (_isPaid)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Cost',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the cost';
                          }
                          return null;
                        },
                        onSaved: (value) => _cost = value!,
                      ),
                    if (!_isPaid)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Skill Needed in Exchange',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the skill you need in exchange';
                          }
                          return null;
                        },
                        onSaved: (value) => _neededSkill = value!,
                      ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Location',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the location';
                        }
                        return null;
                      },
                      onSaved: (value) => _location = value!,
                    ),
                    SizedBox(height: 16),
                    CheckboxListTile(
                      title: Text('Use Google Maps Link'),
                      value: _useGoogleMaps,
                      onChanged: (value) {
                        setState(() {
                          _useGoogleMaps = value!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Rating',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Slider(
                      value: _rating,
                      min: 0,
                      max: 5,
                      divisions: 10,
                      label: _rating.toStringAsFixed(1),
                      onChanged: (value) {
                        setState(() {
                          _rating = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _addSkill();
                              }
                            },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              'Add Skill',
                              style: TextStyle(fontSize: 18),
                            ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
