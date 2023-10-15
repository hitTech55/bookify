import 'dart:io';

import 'package:bookify/presentation/bloc/publish/publish_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PublishPage extends StatelessWidget {
  const PublishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: ChangeNotifierProvider(
          create: (_) => PublishProvider(),
          child: Consumer<PublishProvider>(
              builder: (context, publishProvider, child) =>
                  _ui(context,publishProvider,size))),
    ));
  }

  Widget _ui(BuildContext context, PublishProvider publishProvider, Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _addImageWidget(publishProvider,size),
            const SizedBox(height: 20),
            _addBookNameWidget(publishProvider),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _departmentDropDownMenuWidget(publishProvider),
                _yearDropDownMenuWidget(publishProvider)
              ],
            ),
            const SizedBox(height: 20),
            _freeOrPricedSwitchWidget(publishProvider),
            const SizedBox(height: 30),
            _publishButton(context,publishProvider)
          ],
        ),
      ),
    );
  }

  // TODO: Implement Add Image Widget
  Widget _addImageWidget(PublishProvider provider, Size size) {

    Future<void> _getImageFromGallery() async {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        provider.setImage(File(pickedFile.path));
      }
    }

    return GestureDetector(
      onTap: _getImageFromGallery,
      child: Container(
        width: size.width,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: provider.image == null
            ? const Icon(
          Icons.camera_alt,
          size: 48,
          color: Colors.grey,
        )
            : Image(
          image: FileImage(provider.image!),
          fit:BoxFit.cover,
        ),
      ),
    );
  }


  Widget _addBookNameWidget(PublishProvider provider) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Book Name',
        hintText: 'Enter the book name',
        prefixIcon: const Icon(Icons.book), // Optional icon
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue), // Change the border color when focused
          borderRadius: BorderRadius.circular(10.0),
        ),
        // You can customize many other InputDecoration properties.
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.black), // Customize text style
      onChanged: (value) {
        // Handle the onChanged event
        provider.setBookName(value);
      },
    );
  }

  // TODO: Field Drop Down Menu
  Widget _fieldDropDownMenuWidget() {
    return Container();
  }

  // TODO: Department and Year Drop Down Menu
  Widget _departmentDropDownMenuWidget(PublishProvider provider) {
    List<String> items = provider.departmentList;
    return DropdownButton<String>(
      value: provider.department,
      icon: Icon(Icons.arrow_drop_down), // Custom dropdown icon
      iconSize: 24, // Icon size
      elevation: 16, // Dropdown elevation
      style: TextStyle(color: Colors.black, fontSize: 16), // Dropdown text style
      underline: Container(
        height: 2,
        color: Colors.blue, // Underline color
      ),
      onChanged: (value) {
        provider.setDepartment(value!);
      },
      items: items.map((e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Text(e),
        );
      }).toList(),
    );
  }

  Widget _yearDropDownMenuWidget(PublishProvider provider) {
    List<String> items = provider.yearList;
    return DropdownButton<String>(
      value: provider.year,
      icon: Icon(Icons.arrow_drop_down), // Custom dropdown icon
      iconSize: 24, // Icon size
      elevation: 16, // Dropdown elevation
      style: TextStyle(color: Colors.black, fontSize: 16), // Dropdown text style
      underline: Container(
        height: 2,
        color: Colors.blue, // Underline color
      ),
      onChanged: (value) {
        provider.setYear(value!);
      },
      items: items.map((e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Text(e),
        );
      }).toList(),
    );
  }

  // TODO: Switch Free or Priced

  Widget _freeOrPricedSwitchWidget(PublishProvider provider) {
    return Column(
      children: [
        CupertinoSwitch(
          value: provider.priceOption == 'priced',
          onChanged: (value) {
            provider.setPriceOption(value ? 'priced' : 'free');
            provider.setIsFree(value);
          },
        ),
        Text(provider.priceOption == 'priced' ? 'Free' : 'Priced'),
        if (provider.priceOption == 'priced')
          TextFormField(
            decoration: const InputDecoration(labelText: 'Price (Rp)'),
            initialValue: provider.price.toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              provider.setPrice(double.parse(value));
            },
          ),
      ],
    );
  }

  Widget _publishButton(BuildContext context, PublishProvider provider) {
    return CupertinoButton(
      onPressed: () {
        print("This button was pressed ., . ");
        provider.publishBookPost(context);
      },
      color: Colors.blue, // Customize the button color
      borderRadius: BorderRadius.circular(10.0), // Customize the button's border radius
      child: const Text(
        'Publish',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white, // Customize the button text color
        ),
      ),
    );
  }


}
