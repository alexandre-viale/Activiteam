import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_dev_mobile/model/activity.dart';
import 'package:tp2_dev_mobile/model/classifier.dart';
import 'package:tp2_dev_mobile/providers/activities_notifier.dart';
import 'package:tp2_dev_mobile/repositories/activities_repository.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/activiteam_dropdown_button_formfield.dart';
import 'package:tp2_dev_mobile/screens/home_screen/widgets/activiteam_form_field.dart';
import 'package:tp2_dev_mobile/enums/activities_category.dart';
import 'dart:ui' as ui;

import 'package:image/image.dart' as img;

Future<img.Image?> loadImageFromUrl(String imageUrl) async {
  final completer = Completer<ui.Image>();
  final image = NetworkImage(imageUrl);
  image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener(
          (info, _) => completer.complete(info.image),
        ),
      );

  final ui.Image flutterImage = await completer.future;
  final ByteData? byteData =
      await flutterImage.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List pngBytes = byteData!.buffer.asUint8List();

  img.Image? myImage = img.decodeImage(pngBytes);
  return myImage;
}

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final TextEditingController _activityTitleController =
      TextEditingController();
  final TextEditingController _activityImageLinkController =
      TextEditingController();
  final TextEditingController _activityPlaceController =
      TextEditingController();
  ActivitiesCategory? _category;
  final TextEditingController _activityMinimumPeopleController =
      TextEditingController();
  final TextEditingController _activityPriceController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _hasTriedValidating = false;
  bool _predictingTitle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une activité'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            autovalidateMode: _hasTriedValidating
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                const Text(
                  'Entrez les informations de l\'activité que vous souhaitez ajouter',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                ActiviteamFormField(
                  controller: _activityImageLinkController,
                  hintText: 'Entrez l\'url de l\'image',
                  labelText: 'Url de l\'image',
                  prefixIcon: Icons.link,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un nom pour l\'activité';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _predictingTitle
                      ? null
                      : () async {
                          setState(() {
                            _predictingTitle = true;
                          });
                          Classifier classifier = Classifier();
                          await classifier.loadModel();
                          final loadedImg = await loadImageFromUrl(
                              _activityImageLinkController.text);
                          final res = await classifier.predict(loadedImg!);
                          setState(() {
                            _activityTitleController.text =
                                detectionClassesNames[res]!;
                            _predictingTitle = false;
                          });
                        },
                  icon: const Icon(Icons.memory),
                  label: const Text("Prédire le titre de l'activité"),
                ),
                const Text(
                  "Fonctionne uniquement pour Football, Basketball, Randonnée et Dessin",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ActiviteamFormField(
                  controller: _activityTitleController,
                  hintText: 'Entrez le titre de l\'activité',
                  labelText: 'Titre de l\'activité',
                  prefixIcon: Icons.article,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un titre pour l\'activité';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ActiviteamFormField(
                  controller: _activityPlaceController,
                  hintText: 'Entrez le lieu de l\'activité',
                  labelText: 'Lieu de l\'activité',
                  prefixIcon: Icons.place,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un lieu pour l\'activité';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ActiviteamDropdownButtonFormField<ActivitiesCategory>(
                  items: ActivitiesCategory.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Veuillez choisir une catégorie';
                    }
                    return null;
                  },
                  hint: 'Choisissez une catégorie',
                  currentValue: _category,
                  onChanged: (value) {
                    setState(() {
                      _category = value;
                    });
                  },
                  prefixIcon: const Icon(Icons.category),
                ),
                const SizedBox(height: 20),
                ActiviteamFormField(
                  controller: _activityMinimumPeopleController,
                  hintText: 'Entrez le nombre minimum de personnes',
                  labelText: 'Nombre minimum de personnes',
                  prefixIcon: Icons.people,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un nombre minimum de personnes';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ActiviteamFormField(
                  controller: _activityPriceController,
                  hintText: 'Entrez le prix',
                  labelText: 'Prix de l\'activité',
                  prefixIcon: Icons.euro,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un prix';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: !_isLoading ? () => addActivity(context) : null,
                  child: const Text('Ajouter l\'activité'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addActivity(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final activity = Activity(
        title: _activityTitleController.text,
        imageLink: _activityImageLinkController.text,
        place: _activityPlaceController.text,
        category: _category!,
        minimumPeople: int.parse(_activityMinimumPeopleController.text),
        price: double.parse(_activityPriceController.text),
      );
      ActivitiesRepository.createActivity(activity).then((value) {
        setState(() {
          _isLoading = false;
        });
        final activitiesNotifier =
            Provider.of<ActivitiesNotifier>(context, listen: false);
        activitiesNotifier.addActivity(value);
        Navigator.of(context).pop();
      });
    } else {
      setState(() {
        _hasTriedValidating = true;
      });
    }
  }
}
