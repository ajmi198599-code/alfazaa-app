import 'package:flutter/material.dart';

class Order {
  const Order({
    required this.id,
    required this.serviceTitle,
    required this.status,
    required this.time,
    required this.price,
    required this.location,
    required this.providerName,
    required this.icon,
    required this.rating,
    required this.steps,
    this.activeStep = 0,
  });

  final String id;
  final String serviceTitle;
  final String status;
  final String time;
  final String price;
  final String location;
  final String providerName;
  final IconData icon;
  final double rating;
  final List<String> steps;
  final int activeStep;
}

class OrderData {
  const OrderData._();

  static const List<String> standardSteps = [
    'تم قبول الطلب',
    'المزود في الطريق',
    'بدأت الخدمة',
    'تم التسليم',
  ];

  static const List<Order> recent = [
    Order(
      id: 'A1024',
      serviceTitle: 'غسيل سيارات',
      status: 'تم التوصيل',
      time: 'اليوم، 8:30 م',
      price: '45 ر.س',
      location: 'جدة، حي الروضة',
      providerName: 'راكان الحربي',
      icon: Icons.local_car_wash_rounded,
      rating: 5,
      steps: standardSteps,
      activeStep: 3,
    ),
    Order(
      id: 'A1021',
      serviceTitle: 'حلاق منزلي',
      status: 'مكتمل',
      time: 'أمس، 9:10 م',
      price: '65 ر.س',
      location: 'جدة، حي السلامة',
      providerName: 'عبدالله الزهراني',
      icon: Icons.content_cut_rounded,
      rating: 4.8,
      steps: standardSteps,
      activeStep: 3,
    ),
    Order(
      id: 'A1019',
      serviceTitle: 'مغسلة ملابس',
      status: 'قيد التنفيذ',
      time: 'اليوم، 6:05 م',
      price: '72 ر.س',
      location: 'جدة، حي الخالدية',
      providerName: 'مغاسل الموج',
      icon: Icons.local_laundry_service_rounded,
      rating: 4.9,
      steps: standardSteps,
      activeStep: 1,
    ),
  ];
}
