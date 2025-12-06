import 'package:flutter/material.dart';

class Fruta {
  final String nombre;
  final String descripcion;
  final Color color;
  final double precio;
  final int cantidad;

  Fruta({
    required this.nombre,
    required this.descripcion,
    required this.color,
    required this.precio,
    required this.cantidad,
  });
}