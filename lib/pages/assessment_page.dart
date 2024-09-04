
import 'package:flutter/material.dart';


import 'package:implementation/components/progress_bar.dart';
import 'package:implementation/components/form_label.dart';

import 'package:implementation/input_fields/numeric_input_field.dart';
import 'package:implementation/input_fields/dropdown_input_field.dart';
import 'package:implementation/input_fields/button.dart';

import 'package:implementation/data/processing.dart';

class AssessmentPage extends StatefulWidget {


  AssessmentPage({super.key});

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  double _containerHeight = 0;
  final double _expandedHeight = 250.0;

  ScrollController _scrollController = ScrollController();

  final TextEditingController _maternalAgeController = TextEditingController();
  final TextEditingController _maternalBmiController = TextEditingController();
  final TextEditingController _gestationController = TextEditingController();
  bool _prolongedLabour = false;

  final TextEditingController _cervicalDilationController = TextEditingController();
  final TextEditingController _headPerineumDistanceController = TextEditingController();
  final TextEditingController _caputSuccedaneumController = TextEditingController();

  String _occiputDirection = "Left";
  String _occiputOrientation = "Anterior ";

  double _probabilityOfVaginalBirth = 0;

  void _clearForm(){
    print("Clearing form");
    _closeContainer();
  }

  void onOcciputDirectionChange(String? value) {
       if (value != null) {
         _occiputDirection = value;
       }
      // _occiputDirection = value;
  }
  void onOcciputOrientationChange(String? value) {
    if (value != null) {
      _occiputOrientation = value;
    }
  }



  void _openContainer() {

    // print("Input Data:");
    // print("Maternal Age: ${_maternalAgeController.text}");
    // print("Maternal BMI: ${_maternalBmiController.text}");
    // print("Gestation: ${_gestationController.text}");
    // print("Prolonged Labour: ${_prolongedLabour}");
    // print("Cervical Dilation: ${_cervicalDilationController.text}");
    // print("Head Perineum Distance: ${_headPerineumDistanceController.text}");
    // print("Caput Succedaneum: ${_caputSuccedaneumController.text}");
    // print("Occiput Direction: $_occiputDirection");
    // print("Occiput Orientation: $_occiputOrientation");

    double result = Processing.predictRisk(
      gestationWeeks: double.parse(_gestationController.text),
      cervicalDilationCm: double.parse(_cervicalDilationController.text),
      caputSuccedaneumMm: double.parse(_caputSuccedaneumController.text),
      headPerineumDistanceMm: double.parse(_headPerineumDistanceController.text),
      occiputPosition: _formatOcciputePosition(_occiputDirection, _occiputOrientation),
      maternalAgeYears: double.parse(_maternalAgeController.text),
      maternalBmi: double.parse(_maternalBmiController.text),
      prolongedLabor: _prolongedLabour,
    );

    _probabilityOfVaginalBirth = result * 100;

    /* Scroll to the top */
    _scrollToTop();

    setState(() {
      _containerHeight = _expandedHeight;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _closeContainer() {
    setState(() {
      _containerHeight = 0.0;
    });

    _scrollToTop();
  }

  String _formatOcciputePosition(String direction, String orientation) {
    return '${direction[0]}O${orientation[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                  "SINGLE ASSESSMENT",
                  style: TextStyle(
                      color: Color(0xFF09000A),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans'
                  )
              ),

              ClipRRect(
                child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    height: _containerHeight,
                    // color: Colors.blue,
                    child: _containerHeight > 200 ? Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 80.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: ProgressBar(
                              progress: _probabilityOfVaginalBirth,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Transform.translate(
                            offset: const Offset(0, 18),
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: _probabilityOfVaginalBirth.toStringAsFixed(2),
                                    style: const TextStyle(
                                      color: Color(0xFF1D1936),
                                      fontSize: 48,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'OpenSansCondensed',
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "%",
                                    style: TextStyle(
                                      color: Color(0xFF1D1936),
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'OpenSansCondensed',
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "\nPROBABILITY OF VAGINAL BIRTH\n",
                                    style: TextStyle(
                                      color: Color(0xFF1D1936),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'OpenSansCondensed',
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  TextSpan(
                                    text: Processing.getRiskLabel(_probabilityOfVaginalBirth/ 100).toUpperCase(),
                                    style: const TextStyle(
                                      color: Color(0xFF1D1936),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'OpenSansCondensed',
                                      letterSpacing: -0.3,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) : Container(),
                ),
              ),


              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: const Color(0xFF000000),
                    ),
                    color: Color(0xFFF7E7EF),
                  ),
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const FormLabel(
                          label: "maternal age",
                          unitLabel: "years",
                          infoText: ["Age of the mother in years at the time of labor."]
                      ),
                      NumericInputField(
                        maxValue: 55,
                        minValue: 10,
                        defaultValue: 30,
                        isInteger: true,
                        textController: _maternalAgeController,
                      ),

                      const FormLabel(
                          label: "maternal bmi",
                          infoText: ["Body Mass Index.", "It is calculated as weight in kilograms divided by the square of height in meters (kg/m²)."],
                      ),
                      NumericInputField(
                        maxValue: 40,
                        minValue: 17,
                        defaultValue: 25,
                        isInteger: false,
                        textController: _maternalBmiController,
                      ),

                      const FormLabel(
                          label: "gestation",
                          unitLabel: "weeks",
                          infoText: ["Length of pregnancy in weeks from conception to birth.", "Full-term pregnancy typically ranges from 37 to 42 weeks."]
                      ),
                      NumericInputField(
                        maxValue: 45,
                        minValue: 30,
                        defaultValue: 40,
                        isInteger: true,
                        textController: _gestationController,
                      ),

                      /* Prolonged Labour */
                      const FormLabel(
                          label: "prolonged labour",
                          infoText: ["Labor lasting longer than usual as per national guidelines (Yes/No).",
                            "Prolonged labor, also known as failure to progress, is when labor lasts for more than 20 hours for first-time mothers and more than 14 hours for mothers who have given birth before.",
                            "It can be caused by various factors, including slow cervical dilation, a large baby, or weak contractions."]
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 15),
                          /* YES */
                          Expanded(
                            child: Button(
                              text: "yes",
                              onPressed: () {
                                setState(() {
                                  _prolongedLabour = true;

                                });
                              },
                              bgColor: (_prolongedLabour) ?
                                        const Color(0xFFD0C8FF)
                                            : const Color(0xFFFFFFFF),

                            ),
                          ),
                          const SizedBox(width: 20),
                          /* NO */
                          Expanded(
                            child: Button(
                              text: "no",
                              onPressed: () {
                                setState(() {
                                  _prolongedLabour = false;
                                });
                              },
                              bgColor: (_prolongedLabour) ?
                                        const Color(0xFFFFFFFF)
                                          : const Color(0xFFD0C8FF),
                            ),
                          ),
                          const SizedBox(width: 15),

                        ],
                      ),

                      /* Occiput Position */
                      const FormLabel(
                          label: "occiput position",
                          infoText: ["Position of the baby's head during labor.",
                            "Anterior means the baby's head is facing the mother's front.",
                            "Posterior means the baby's head is facing the mother's back.",
                            "Transverse means the baby's head is facing sideways.",
                            "The position of the baby's head is crucial for determining the ease and method of delivery."
                          ]
                          // unitLabel: "cm"
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 4,
                            child: DropdownInputField(
                            
                              items: const [['Left', 'Left'], ['Right', 'Right']],
                              defaultValue: _occiputDirection,
                              onChange: onOcciputDirectionChange,
                            ),
                          ),
                          const SizedBox(width: 15),

                          Expanded(
                            flex: 6,
                            child: DropdownInputField(
                                items: const [['Anterior ', 'Anterior '],
                                              ['Posterior ', 'Posterior '],
                                              ['Transverse ', 'Transverse ']],
                                defaultValue: _occiputOrientation,
                                onChange: onOcciputOrientationChange,
                                // selectedItem: 'Anterior ',
                            ),
                          ),
                          const SizedBox(width: 15),

                        ],
                      ),

                      const FormLabel(
                          label: "cervical dilation",
                          unitLabel: "cm",
                          infoText: ["The opening of the cervix measured in centimeters during labor.",
                            "Full dilation is typically 10 centimeters, which is necessary for the baby to pass through the birth canal.",
                            "The rate of cervical dilation can vary widely among women."],
                      ),
                      NumericInputField(
                        maxValue: 10,
                        minValue: 0,
                        defaultValue: 0,
                        isInteger: false,
                        textController: _cervicalDilationController,
                      ),

                      const FormLabel(
                          label: "head perineum distance",
                          unitLabel: "mm",
                          infoText: [
                            "Distance in millimeters between the baby's head and the perineum.",
                            "This distance helps in assessing the progress of labor.",
                            "A shorter distance indicates that the baby is moving closer to being born."
                          ],
                      ),
                      NumericInputField(
                        maxValue: 100,
                        minValue: 0,
                        defaultValue: 40,
                        isInteger: true,
                        textController: _headPerineumDistanceController,
                      ),
                      const FormLabel(
                          label: "caput Succedaneum ",
                          unitLabel: "mm",
                          infoText: [
                            "Swelling on the baby's head caused by pressure during delivery.",
                            "Measured in millimeters.",
                            "It is a common and usually harmless condition that resolves on its own.",
                            "Caput succedaneum can be identified through ultrasound and is an indicator of the baby's head engaging in the birth canal."
                          ],
                      ),
                      NumericInputField(
                        maxValue: 75,
                        minValue: 0,
                        defaultValue: 10,
                        isInteger: true,
                        textController: _caputSuccedaneumController,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[

                              Expanded(
                                  flex: 4,
                                  child: Button(text: "clear", onPressed: _clearForm)
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 6,
                                child: Button(
                                    text: "calculate",
                                    onPressed: () {
                                      _openContainer();
                                    },
                                    bgColor: const Color(0xFFB8AAFF)
                                ),
                              ),
                              // SizedBox(width: 20),
                            ]
                        ),
                      ),

                    ],
                  )
              ),


            ]
        ),
      ),
    );
  }
}





