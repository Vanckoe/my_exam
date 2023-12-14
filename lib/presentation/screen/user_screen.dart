import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_market/generated/locale_keys.g.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_market/presentation/bloc/authen_bloc.dart';
import 'package:flutter_market/presentation/bloc/authen_event.dart'; 
import 'package:flutter_market/presentation/bloc/authen_state.dart';
import 'package:flutter_market/domain/entities/userdata_entities.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:easy_localization/easy_localization.dart';



class UserPage extends StatefulWidget {
  final String userEmail;

  UserPage({required this.userEmail});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    if (kIsWeb) {
      String? imageDataString = prefs.getString('user_image_data');
      if (imageDataString != null) {
        _imageData = Uint8List.fromList(imageDataString.codeUnits);
      }
    } else {
      String? imagePath = prefs.getString('user_image_path');
      if (imagePath != null) {
        _imageData = await File(imagePath).readAsBytes();
      }
    }
    setState(() {});
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List imageData = await pickedFile.readAsBytes();
      setState(() {
        _imageData = imageData;
      });
      final prefs = await SharedPreferences.getInstance();
      if (kIsWeb) {
        String imageDataString = String.fromCharCodes(imageData);
        await prefs.setString('user_image_data', imageDataString);
      } else {
        String imagePath = pickedFile.path;
        await prefs.setString('user_image_path', imagePath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationUserRequested());

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.User_profile.tr(), style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUserDataLoaded) {
            return _buildUserProfile(state.user);
          } else if (state is AuthenticationInProgress) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text(LocaleKeys.Failed_upload.tr(), style: TextStyle(color: Colors.white)));
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildUserProfile(AppUser user) {
    ImageProvider imageProvider;
    if (_imageData != null) {
      imageProvider = MemoryImage(_imageData!);
    } else {
      imageProvider = AssetImage('assets/default_user.jpg');
    }

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: imageProvider,
            ),
          ),
          SizedBox(height: 20),
          _buildUserInfoRow(Icons.person, LocaleKeys.Name.tr(), user.name),
          _buildUserInfoRow(Icons.cake, LocaleKeys.Age.tr(), user.age.toString()),
          _buildUserInfoRow(Icons.flag, LocaleKeys.Country.tr(), user.country),
          _buildUserInfoRow(Icons.transgender, LocaleKeys.Sex.tr(), user.gender),
          _buildUserInfoRow(Icons.phone, LocaleKeys.Phone.tr(), user.phone),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Действие при нажатии на кнопку
              },
              child: Text(LocaleKeys.Log_out.tr()),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white),
          SizedBox(width: 10),
          Text("$label: ", style: TextStyle(color: Colors.white)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}
