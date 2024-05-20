import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/common/local_storage/local_storage.dart';
import 'package:naani/common/widgets/back_button.dart';
import 'package:naani/common/widgets/customButtons.dart';
import 'package:naani/screens/Signup/screens/email_screen.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  String? _selectedCity = 'Kathmandu'; // Set default value to 'Kathmandu'

  // List of all districts in Nepal
  final List<String> _districts = [
    'Achham',
    'Arghakhanchi',
    'Baglung',
    'Baitadi',
    'Bajhang',
    'Bajura',
    'Banke',
    'Bara',
    'Bardiya',
    'Bhaktapur',
    'Bhojpur',
    'Chitwan',
    'Dadeldhura',
    'Dailekh',
    'Dang',
    'Darchula',
    'Dhading',
    'Dhankuta',
    'Dhanusha',
    'Dolakha',
    'Dolpa',
    'Doti',
    'Gorkha',
    'Gulmi',
    'Humla',
    'Ilam',
    'Jajarkot',
    'Jhapa',
    'Jumla',
    'Kailali',
    'Kalikot',
    'Kanchanpur',
    'Kapilvastu',
    'Kaski',
    'Kathmandu',
    'Kavrepalanchok',
    'Khotang',
    'Lalitpur',
    'Lamjung',
    'Mahottari',
    'Makwanpur',
    'Manang',
    'Morang',
    'Mugu',
    'Mustang',
    'Myagdi',
    'Nawalpur',
    'Nuwakot',
    'Okhaldhunga',
    'Palpa',
    'Panchthar',
    'Parasi',
    'Parbat',
    'Parsa',
    'Pyuthan',
    'Ramechhap',
    'Rasuwa',
    'Rautahat',
    'Rolpa',
    'Rukum East',
    'Rukum West',
    'Rupandehi',
    'Salyan',
    'Sankhuwasabha',
    'Saptari',
    'Sarlahi',
    'Sindhuli',
    'Sindhupalchok',
    'Siraha',
    'Solukhumbu',
    'Sunsari',
    'Surkhet',
    'Syangja',
    'Tanahun',
    'Taplejung',
    'Terhathum',
    'Udayapur'
  ];

  Future<void> _saveCity() async {
    if (_selectedCity != null) {
      await storage.write(key: locationLS, value: _selectedCity);
      // Optionally, navigate to the next screen or show a confirmation
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('City saved: $_selectedCity')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please select a district')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomBackButton(),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 120),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select your location",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 140.0, left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.network(
                  "https://cdni.iconscout.com/illustration/premium/thumb/man-search-map-route-8324760-6631864.png?f=webp",
                  width: 350,
                ),
                Text(
                  "This location is used for suggesting nearby hospitals and eye care",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select District',
                    labelStyle: TextStyle(color: secondaryGreenColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryGreenColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryGreenColor),
                    ),
                  ),
                  value: _selectedCity,
                  items: _districts.map((district) {
                    return DropdownMenuItem(
                      value: district,
                      child: Text(district),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                    });
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: CustomLargeButton(
                  label: "Continue",
                  onPressed: () {
                    Get.to(() => EmailScreen());
                  }),
            ),
          )
        ],
      ),
    );
  }
}
