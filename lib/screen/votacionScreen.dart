import 'package:flutter/material.dart';

class VotacionScreen extends StatefulWidget {
  const VotacionScreen({super.key});

  @override
  State<VotacionScreen> createState() => _VotacionState();
}

List<Candidato> candidatos = [
  Candidato(nombre: 'Candidato 1', foto: 'assets/imagenes/candidato13d.png'),
  Candidato(nombre: 'Candidato 2', foto: 'assets/imagenes/candidato23d.png'),
  Candidato(nombre: 'Candidato 3', foto: 'assets/imagenes/candidato3-3d.png'),
];

class _VotacionState extends State<VotacionScreen> {
  @override
  Widget build(BuildContext context) {
    Candidato obtenerGanador() {
      List<Candidato> candidatosOrdenados = List.from(candidatos);
      candidatosOrdenados.sort((a, b) => b.votos.compareTo(a.votos));
      return candidatosOrdenados.first;
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Elige a tu candidato:',
          style: TextStyle(fontSize: 30),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // Usa 1 columna para pantallas estrechas y 3 para pantallas anchas
              int crossAxisCount = constraints.maxWidth < 600 ? 1 : 3;
              return GridView.count(
                crossAxisCount: crossAxisCount,
                children: candidatos.map((candidato) {
                  return CandidatoWidget(
                    candidato: candidato,
                    onPressed: () {
                      setState(() {
                        candidato.votar();
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Total de votos: ${candidatos.fold<int>(0, (prev, candidato) => prev + candidato.votos)}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Text(
          'Ganador: ${obtenerGanador().nombre}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Candidato obtenerGanador() {
    candidatos.sort((a, b) => b.votos.compareTo(a.votos));
    return candidatos.first;
  }
}

class Candidato {
  final String nombre;
  final String foto;
  int votos;

  Candidato({required this.nombre, required this.foto, this.votos = 0});

  void votar() {
    votos++;
  }
}

class CandidatoWidget extends StatelessWidget {
  final Candidato candidato;
  final VoidCallback onPressed;

  const CandidatoWidget(
      {super.key, required this.candidato, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Flexible(
              child: Image.asset(
                candidato.foto,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              candidato.nombre,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Votos: ${candidato.votos}',
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Votar'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green, // Set the background color to green
                foregroundColor: Colors.white, // Set the text color to white
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Porcentaje: ${_calcularPorcentaje()}%',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  double _calcularPorcentaje() {
    final totalVotos = candidato.votos;
    final totalVotosTodos =
        candidatos.fold<int>(0, (prev, candidato) => prev + candidato.votos);
    final porcentaje = (totalVotos / totalVotosTodos) * 100;
    return porcentaje.isNaN ? 0.0 : porcentaje;
  }
}
