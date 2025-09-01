import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int weight = 65;
  int age = 26;
  double height = 170;
  // String gender = "male";

  // BMI formula
  double calculateBMI() {
    double h = height / 100; // cm -> m
    return weight / (h * h);
  }

  void _showResultModal(BuildContext context) {
    double bmi = calculateBMI();
    String status = "";
    Color statusColor = Colors.green;

    if (bmi < 18.5) {
      status = "Underweight";
      statusColor = Colors.blue;
    } else if (bmi < 24.9) {
      status = "Normal";
      statusColor = Colors.green;
    } else if (bmi < 29.9) {
      status = "Overweight";
      statusColor = Colors.orange;
    } else {
      status = "Obese";
      statusColor = Colors.red;
    }

    // healthy range using BMI = 18.5 - 24.9
    double minHealthy = 18.5 * ((height / 100) * (height / 100));
    double maxHealthy = 24.9 * ((height / 100) * (height / 100));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          
          // margin: const EdgeInsets.all(20),
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Your BMI:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Roboto"),
              ),
              const SizedBox(height: 10),
              Text(
                bmi.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                  fontFamily: "Roboto"
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor, fontSize: 16, fontFamily: "Roboto"),
                ),
              ),

              // Info row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _infoItem("$weight kg", "Weight"),
                  _infoItem("${height.toInt()} cm", "Height"),
                  _infoItem("$age", "Age"),
                  // _infoItem(gender, "Gender"),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                "Healthy weight for the height:",
                style: TextStyle(color: Colors.grey[700], fontSize: 14, fontFamily: "Roboto"),
              ),
              const SizedBox(height: 6),
              Text(
                "${minHealthy.toStringAsFixed(1)} kg - ${maxHealthy.toStringAsFixed(1)} kg",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: "Roboto"
                ),
              ),
              const SizedBox(height: 20),

              // Close button
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF65B741),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 110, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Roboto"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: "Roboto")),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: "Roboto")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            text: "BMI ",
            style: TextStyle(
              color: Colors.amber[700],
              fontSize: 28,
              fontWeight: FontWeight.w800,
              fontFamily: "Roboto"
            ),
            children: const [
              TextSpan(
                text: "Calculator",
                style: TextStyle(color: Color(0xFF65B741), fontFamily: "Roboto"),
              ),
            ],
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
      ),

      body: Column(
        children: [
          const SizedBox(height: 14),
          const Text(
            "Please Modify the values",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, fontFamily: "Roboto"),
          ),
          const SizedBox(height: 24),

          // Row for Weight & Age
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCard(
                title: "Weight (kg)",
                value: "$weight",
                onMinus: () => setState(() => weight--),
                onPlus: () => setState(() => weight++),
              ),
              _buildCard(
                title: "Age",
                value: "$age",
                onMinus: () => setState(() => age--),
                onPlus: () => setState(() => age++),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Height card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF6EE),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  "Height (cm)",
                  style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: "Roboto"),
                ),
                const SizedBox(height: 10),
                Text(
                  height.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCA8A04),
                    fontFamily: "Roboto"
                  ),
                ),
                Slider(
                  value: height,
                  min: 100,
                  max: 220,
                  divisions: 120,
                  activeColor: const Color(0xFFCA8A04),
                  onChanged: (val) {
                    setState(() => height = val);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () => _showResultModal(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF65B741),
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 110, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
            ),
            child: const Text(
              "Calculate",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: "Roboto"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return Container(
      width: 150,
      height: 170,
      decoration: BoxDecoration(
        color: const Color(0xFFFBF6EE),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: "Roboto")),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFFCA8A04),
              fontFamily: "Roboto"
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _circleButton(Icons.remove, onMinus),
              const SizedBox(width: 15),
              _circleButton(Icons.add, onPlus),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          child: Icon(icon, color: const Color(0xFF9D6F1F)),
        ),
      ),
    );
  }
}
