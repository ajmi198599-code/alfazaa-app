class AlfazaaProvider {
  const AlfazaaProvider({
    required this.name,
    required this.specialty,
    required this.distance,
    required this.eta,
    required this.rating,
    required this.completedOrders,
    required this.vehicle,
  });

  final String name;
  final String specialty;
  final String distance;
  final String eta;
  final double rating;
  final int completedOrders;
  final String vehicle;
}

class ProviderData {
  const ProviderData._();

  static const List<AlfazaaProvider> nearby = [
    AlfazaaProvider(
      name: 'راكان الحربي',
      specialty: 'غسيل سيارات متنقل',
      distance: '1.4 كم',
      eta: '12 دقيقة',
      rating: 4.9,
      completedOrders: 842,
      vehicle: 'تويوتا هايلكس سوداء',
    ),
    AlfazaaProvider(
      name: 'عبدالله الزهراني',
      specialty: 'خدمات منزلية فورية',
      distance: '2.1 كم',
      eta: '17 دقيقة',
      rating: 4.8,
      completedOrders: 610,
      vehicle: 'فان خدمات أبيض',
    ),
    AlfazaaProvider(
      name: 'نواف العتيبي',
      specialty: 'مساعدة طريق وصيانة',
      distance: '2.8 كم',
      eta: '19 دقيقة',
      rating: 4.7,
      completedOrders: 534,
      vehicle: 'نيسان باترول أسود',
    ),
  ];
}
