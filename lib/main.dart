import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Ejercicios en Flutter')),
        body: Center(
          child: ExerciseSelector(),
        ),
      ),
    );
  }
}

class ExerciseSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NumberExercise()),
            );
          },
          child: Text("Ejercicio con if"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GradeChecker()),
            );
          },
          child: Text("Ejercicio con else-if"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NumberSorter()),
            );
          },
          child: Text("Ejercicio con for"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CountdownWidget()),
            );
          },
          child: Text("Ejercicio con while"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NameInput()),
            );
          },
          child: Text("Ejemplo Do-While"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DayInput()),
            );
          },
          child: Text("Ejemplo Switch-Case"),
        ),
      ],
    );
  }
}

class NumberExercise extends StatefulWidget {
  @override
  _NumberExerciseState createState() => _NumberExerciseState();
}

class _NumberExerciseState extends State<NumberExercise> {
  int number = 0;
  final TextEditingController _controller = TextEditingController();

  void increment() {
    setState(() {
      number += int.tryParse(_controller.text) ?? 0;
    });
  }

  void decrement() {
    setState(() {
      number -= int.tryParse(_controller.text) ?? 0;
    });
  }

  String getNumberStatus() {
    if (number > 0) {
      return "El número es positivo";
    } else if (number < 0) {
      return "El número es negativo";
    } else {
      return "El número es cero";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sentencia con If')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingresa un número',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(getNumberStatus(), style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text("Valor: $number", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: increment,
                  child: Text("Sumar"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: decrement,
                  child: Text("Restar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GradeChecker extends StatefulWidget {
  @override
  _GradeCheckerState createState() => _GradeCheckerState();
}

class _GradeCheckerState extends State<GradeChecker> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  List<String> _grades = [];

  String getGrade(int score) {
    if (score >= 90) {
      return "Calificación: A";
    } else if (score >= 80) {
      return "Calificación: B";
    } else if (score >= 70) {
      return "Calificación: C";
    } else {
      return "Calificación: F";
    }
  }

  void addGrade() {
    final String name = _nameController.text;
    final int? score = int.tryParse(_scoreController.text);
    
    if (name.isNotEmpty && score != null) {
      setState(() {
        _grades.add("Alumno: $name - Nota: $score - ${getGrade(score)}");
        _nameController.clear();
        _scoreController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, ingresa un nombre y una calificación válida")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejercicio con else-if')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Ingresa el nombre del alumno',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _scoreController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Ingresa una calificación',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addGrade,
                child: Text("Añadir Calificación"),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _grades.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _grades[index],
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberSorter extends StatefulWidget {
  @override
  _NumberSorterState createState() => _NumberSorterState();
}

class _NumberSorterState extends State<NumberSorter> {
  final TextEditingController _controller = TextEditingController();
  List<int> _numbers = [];
  List<Widget> _sortedNumberWidgets = [];

  void addNumber() {
    final int? number = int.tryParse(_controller.text);
    if (number != null) {
      setState(() {
        _numbers.add(number);
        _controller.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, ingresa un número válido")),
      );
    }
  }

  void sortNumbers() {
    setState(() {
      _numbers.sort();
      _sortedNumberWidgets = [];

      for (int i = 0; i < _numbers.length; i++) {
        _sortedNumberWidgets.add(
          Text("Número: ${_numbers[i]}", style: TextStyle(fontSize: 20)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejercicio con for')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Ingresa un número',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addNumber,
                child: Text("Añadir Número"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: sortNumbers,
                child: Text("Ordenar Números"),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: _sortedNumberWidgets,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountdownWidget extends StatefulWidget {
  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  final TextEditingController _controller = TextEditingController();
  List<Widget> _countdownWidgets = [];

  void startCountdown(int start) {
    List<Widget> widgets = [];
    int number = start;
    while (number > 0) {
      widgets.add(Text("Cuenta atrás: $number", style: TextStyle(fontSize: 20)));
      number--;
    }
    setState(() {
      _countdownWidgets = widgets;
    });
  }

  void handleCountdown() {
    final int? startNumber = int.tryParse(_controller.text);
    if (startNumber != null && startNumber > 0) {
      startCountdown(startNumber);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, ingresa un número válido y positivo")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejercicio con while')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Ingresa un número',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: handleCountdown,
                child: Text("Iniciar Cuenta Regresiva"),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: _countdownWidgets,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NameInput extends StatefulWidget {
  @override
  _NameInputState createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  final TextEditingController _controller = TextEditingController();
  String name = "";

  void handleSubmit() {
    setState(() {
      name = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejemplo Do-While')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Ingresa tu nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: handleSubmit,
                child: Text("Enviar"),
              ),
              SizedBox(height: 20),
              Text("Nombre ingresado: $name", style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

class DayInput extends StatefulWidget {
  @override
  _DayInputState createState() => _DayInputState();
}

class _DayInputState extends State<DayInput> {
  final TextEditingController _controller = TextEditingController();
  String message = "";

  void checkDay() {
    String day = _controller.text.toLowerCase();
    switch (day) {
      case "lunes":
        message = "Inicio de la semana!";
        break;
      case "viernes":
        message = "¡Casi fin de semana!";
        break;
      case "domingo":
        message = "¡Es domingo de descanso!";
        break;
      default:
        message = "Día normal de la semana.";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejemplo Switch-Case')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Ingresa un día de la semana',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: checkDay,
                child: Text("Verificar Día"),
              ),
              SizedBox(height: 20),
              Text(message, style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
