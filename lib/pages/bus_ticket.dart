// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:redbus/models/auth.dart';

class Add extends StatefulWidget {
  const Add({
    Key? key,
    this.id,
    this.name,
    this.mobileNo,
    this.age,
    this.gender,
    this.date,
    this.fromcity,
    this.tocity,
    this.bustype,
    this.seatno,
  }) : super(key: key);

  final String? id;
  final String? name;
  final String? mobileNo;
  final String? age;
  final String? gender;
  final String? date;
  final String? fromcity;
  final String? tocity;
  final String? bustype;
  final String? seatno;

  @override
  State<Add> createState() => _AddState();
}

// for Authentication login and signup
class _AddState extends State<Add> {
  TextEditingController username = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController dateofJourney = TextEditingController();
  AuthController authController = Get.put(AuthController());

//list for gender
  String? selectedGender;
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? selectedFromCity;

  List<String> get fromCity => [
        'Deoria',
        'Gorakhour',
        'Lucknow',
        'Varanasi',
        'Allahabad',
        'Kushinagar',
        'Gonda',
        'Basti',
        'Siwan',
        'Chhapra',
        'Kolkata',
        'Ahemdabad',
        'New Delhi',
        'Gurgaon',
        'Karnataka',
        'Banglore',
        'Mumbai',
        'Jaipur',
      ];
  String? selectedToCity;

  List<String> get toCity => [
        'Gonda',
        'Basti',
        'Siwan',
        'Chhapra',
        'Kolkata',
        'Ahemdabad',
        'New Delhi',
        'Gurgaon',
        'Karnataka',
        'Banglore',
        'Mumbai',
        'Jaipur',
        'Deoria',
        'Gorakhour',
        'Lucknow',
        'Varanasi',
        'Allahabad',
        'Kushinagar',
      ];
  String? selectedbustype;
  final List<String> _locations = [
    'Government Bus',
    'AC Sleeper(2+2)',
    'AC Seater(3+2)',
    'Non AC Sleeper',
    'Non AC Sleeper(2+2)',
    'Volvo Multi-Axle A/C Semi Sleeper',
    'Single Deck',
    'Double Deck'
  ];
  String? onclick;
  bool seepwd = false;
  bool changebutton = false;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.id != null ? username.text = widget.name.toString() : "";
    widget.id != null ? age.text = widget.age.toString() : "";
    widget.id != null ? number.text = widget.mobileNo.toString() : "";
    widget.id != null ? selectedGender = widget.gender.toString() : "";
    widget.id != null ? selectedbustype = widget.bustype.toString() : "";
    widget.id != null ? selectedFromCity = widget.fromcity.toString() : "";
    widget.id != null ? selectedToCity = widget.tocity.toString() : "";
    widget.id != null ? dateofJourney.text = widget.date.toString() : "";
    super.initState();
  }

  Set<SeatNumber> selectedSeats = {};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child: Text(
                        "Red Bus",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //------Textformfiled code-------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Container(
                      child: Column(children: [
                        TextFormField(
                          controller: username,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Enter Your Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Name"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name cannot be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: age,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              counterText: "",
                              hintText: "Enter Your Age(In Yrs)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Age"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Age cannot be empty";
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: number,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              counterText: "",
                              filled: true,
                              hintText: "Enter Your Mobile Number",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Mobile Number"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Mobile Number cannot be empty";
                            } else if (value.length > 10)
                              return "Mobile number should be 10 digit";
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Gender :",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Select Your Gender',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: genderItems
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select gender.';
                              }
                              return null;
                            },
                            value: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value.toString();
                              });
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "From :",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Select Your City',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: fromCity
                                .map((items) => DropdownMenuItem<String>(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) return 'Please select city';
                              return null;
                            },
                            value: selectedFromCity,
                            onChanged: (fromvalue) {
                              selectedFromCity = fromvalue.toString();
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "TO :",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Select Your City',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: selectedToCity,
                            onChanged: (tovalue) {
                              setState(() {
                                selectedToCity = tovalue.toString();
                              });
                            },
                            items: toCity
                                .map((items) => DropdownMenuItem<String>(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) return 'Please select city';
                              return null;
                            },
                          ),
                        ),

                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Date :",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: dateofJourney,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Pick your Date'),
                            validator: (value) {
                              if (value == false) return 'Please select Date';
                              return null;
                            },
                            onTap: () async {
                              DateFormat('dd/mm/yyyy').format(DateTime.now());
                              var date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100));
                              dateofJourney.text =
                                  date.toString().substring(0, 10);
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Select Class :",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Select Bus Type',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: selectedbustype,
                            onChanged: (newvalue) {
                              setState(() {
                                selectedbustype = newvalue.toString();
                              });
                            },
                            items: _locations
                                .map((location) => DropdownMenuItem<String>(
                                      value: location,
                                      child: Text(
                                        location,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) return 'Please select class';
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Choose Your Seat :",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          height: 480,
                          child: SeatLayoutWidget(
                            // key: seatno,
                            onSeatStateChanged: (rowI, colI, seatState) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: seatState == SeatState.selected
                                      ? Text("Selected Seat[$rowI][$colI]")
                                      : Text("De-selected Seat[$rowI][$colI]"),
                                ),
                              );
                              if (seatState == SeatState.selected) {
                                selectedSeats
                                    .add(SeatNumber(rowI: rowI, colI: colI));
                              } else {
                                selectedSeats
                                    .remove(SeatNumber(rowI: rowI, colI: colI));
                              }
                            },
                            stateModel: const SeatLayoutStateModel(
                              pathDisabledSeat:
                                  'assets/svg_disabled_bus_seat.svg',
                              pathSelectedSeat:
                                  'assets/svg_selected_bus_seats.svg',
                              pathSoldSeat: 'assets/svg_sold_bus_seat.svg',
                              pathUnSelectedSeat:
                                  'assets/svg_unselected_bus_seat.svg',
                              rows: 10,
                              cols: 6,
                              seatSvgSize: 45,
                              currentSeatsState: [
                                [
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.empty,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.sold,
                                ],
                                [
                                  SeatState.sold,
                                  SeatState.unselected,
                                  SeatState.empty,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                ],
                                [
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.empty,
                                  SeatState.sold,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                ],
                                [
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.empty,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                ],
                                [
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.empty,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.sold,
                                ],
                                [
                                  SeatState.unselected,
                                  SeatState.sold,
                                  SeatState.empty,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                ],
                                [
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.empty,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                ],
                                [
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.empty,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                ],
                                [
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.empty,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.sold,
                                ],
                                [
                                  SeatState.unselected,
                                  SeatState.unselected,
                                  SeatState.empty,
                                  SeatState.sold,
                                  SeatState.unselected,
                                  SeatState.unselected,
                                ],
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg_disabled_bus_seat.svg',
                                      width: 15,
                                      height: 15,
                                    ),
                                    const Text('Disabled')
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg_sold_bus_seat.svg',
                                      width: 15,
                                      height: 15,
                                    ),
                                    const Text('Sold')
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg_unselected_bus_seat.svg',
                                      width: 15,
                                      height: 15,
                                    ),
                                    const Text('Available')
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg_selected_bus_seats.svg',
                                      width: 15,
                                      height: 15,
                                    ),
                                    const Text(' Selected ')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        //-----------Login Button code---------------
                        InkWell(
                          onTap: () => submit(),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: changebutton ? 50 : 150,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(
                                    changebutton ? 50 : 8)),
                            child: changebutton
                                ? Icon(Icons.done)
                                : Text(
                                    widget.id == null
                                        ? "Submit to Book"
                                        : "Update ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                          ),
                        ),
                        Text(selectedSeats.join(" , ")),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  submit() async {
    var userId = FirebaseAuth.instance.currentUser!.uid.toString();
    if (_formkey.currentState!.validate()) {
      try {
        if (selectedSeats.isEmpty) {
          Get.showSnackbar(GetSnackBar(
            message: "Please Select the seat",
            duration: Duration(seconds: 1),
          ));
          return;
        }
        setState(() {
          changebutton = true;
        });
        if (widget.id == null) {
          await FirebaseFirestore.instance.collection("Busticketbook").add({
            'name': username.text,
            'age': age.text,
            'mobileno': number.text,
            'gender': selectedGender,
            'fromcity': selectedFromCity,
            'tocity': selectedToCity,
            'bustype': selectedbustype,
            'date': dateofJourney.text,
            "selectedSeats": selectedSeats.toString(),
            'userId': userId,
          }).whenComplete(() {
            Get.snackbar("Bus-Ticket Book", "Ticket book successfully",
                snackPosition: SnackPosition.BOTTOM);
            Navigator.of(context).pop();
          });
        } else {
          //update code
          await FirebaseFirestore.instance
              .collection("Busticketbook")
              .doc(widget.id)
              .update({
            'name': username.text,
            'age': age.text,
            'mobileno': number.text,
            'gender': selectedGender,
            'fromcity': selectedFromCity,
            'tocity': selectedToCity,
            'bustype': selectedbustype,
            'date': dateofJourney.text,
            "selectedSeats": selectedSeats.toString(),
            'userId': userId
          }).whenComplete(() {
            Get.snackbar(
                'Update Bus-Ticket Book', 'Update Ticket book succesfully',
                snackPosition: SnackPosition.BOTTOM);
            Navigator.of(context).pop();
          });
        }
        setState(() {
          changebutton = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          changebutton = false;
        });
        Get.snackbar('Something went wrong', e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI && colI == (other).colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}
