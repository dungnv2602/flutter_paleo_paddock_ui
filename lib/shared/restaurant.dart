import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Restaurant extends Equatable {
  const Restaurant({
    @required this.imagePath,
    @required this.icon,
    @required this.iconColor,
    @required this.title,
    @required this.subtitle,
    @required this.likes,
  });

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Restaurant(
      imagePath: map['imagePath'] as String,
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
      iconColor: Color(map['iconColor'] as int),
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      likes: map['likes'] as int,
    );
  }

  final IconData icon;
  final Color iconColor;
  final String imagePath;
  final int likes;
  final String subtitle;
  final String title;

  @override
  String toString() {
    return '_RestaurantMeal(imagePath: $imagePath, icon: $icon, iconColor: $iconColor, title: $title, subtitle: $subtitle, likes: $likes)';
  }

  Restaurant copyWith({
    String imagePath,
    IconData icon,
    Color iconColor,
    String title,
    String subtitle,
    int likes,
  }) {
    return Restaurant(
      imagePath: imagePath ?? this.imagePath,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'icon': icon?.codePoint,
      'iconColor': iconColor?.value,
      'title': title,
      'subtitle': subtitle,
      'likes': likes,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [
      icon,
      iconColor,
      imagePath,
      likes,
      subtitle,
      title,
    ];
  }
}
