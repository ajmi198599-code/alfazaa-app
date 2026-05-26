import 'package:flutter/material.dart';

class Service {
  const Service({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.eta,
    required this.icon,
    required this.description,
    required this.inclusions,
    this.popular = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final String price;
  final String eta;
  final IconData icon;
  final String description;
  final List<String> inclusions;
  final bool popular;
}

class ServiceCatalog {
  const ServiceCatalog._();

  static const List<Service> items = [
    Service(
      id: 'car-wash',
      title: 'غسيل سيارات',
      subtitle: 'غسيل خارجي سريع أمام بابك',
      price: 'من 25 ر.س',
      eta: '12 دقيقة',
      icon: Icons.local_car_wash_rounded,
      popular: true,
      description:
          'فريق متنقل يصل لموقعك في جدة مع معدات تنظيف آمنة ولمعة فاخرة للسيارة.',
      inclusions: [
        'غسيل خارجي',
        'تجفيف وتلميع',
        'تعقيم خفيف',
        'دفع آمن عند الوصول'
      ],
    ),
    Service(
      id: 'home-salon',
      title: 'حلاق منزلي',
      subtitle: 'مظهر مرتب بدون مشوار',
      price: 'من 30 ر.س',
      eta: '18 دقيقة',
      icon: Icons.content_cut_rounded,
      popular: true,
      description:
          'مزودون موثوقون للعناية الشخصية المنزلية مع أدوات معقمة وخيارات مواعيد مرنة.',
      inclusions: ['قص شعر', 'تهذيب لحية', 'تعقيم الأدوات', 'حجز فوري'],
    ),
    Service(
      id: 'laundry',
      title: 'مغسلة ملابس',
      subtitle: 'استلام وتسليم في نفس اليوم',
      price: 'من 40 ر.س',
      eta: '20 دقيقة',
      icon: Icons.local_laundry_service_rounded,
      description:
          'خدمة غسيل وكي بتغليف مرتب واستلام من حي الروضة أو أي موقع قريب في جدة.',
      inclusions: ['استلام من الباب', 'غسيل وكي', 'تغليف فاخر', 'تتبع الطلب'],
    ),
    Service(
      id: 'moving',
      title: 'نقل أثاث',
      subtitle: 'فريق سريع وسيارة مجهزة',
      price: 'من 60 ر.س',
      eta: '25 دقيقة',
      icon: Icons.local_shipping_rounded,
      description:
          'نقل قطع الأثاث الصغيرة والمتوسطة داخل جدة مع عمالة مدربة وتغليف احترازي.',
      inclusions: [
        'سيارة نقل',
        'عاملان مساعدان',
        'تغليف أساسي',
        'تأكيد قبل الانطلاق'
      ],
    ),
    Service(
      id: 'plumbing',
      title: 'سباكة طارئة',
      subtitle: 'تسريب أو انسداد؟ الفزعة قريبة',
      price: 'من 55 ر.س',
      eta: '16 دقيقة',
      icon: Icons.build_rounded,
      description:
          'فني سباكة معتمد لحالات التسريب والانسداد والصيانة السريعة داخل المنزل.',
      inclusions: [
        'كشف أولي',
        'إصلاح تسريب',
        'تنظيف انسداد',
        'ضمان خدمة مختصر'
      ],
    ),
    Service(
      id: 'electrician',
      title: 'كهربائي',
      subtitle: 'إصلاح آمن وسريع',
      price: 'من 50 ر.س',
      eta: '14 دقيقة',
      icon: Icons.bolt_rounded,
      description:
          'حلول كهربائية منزلية عاجلة مع التزام بمعايير السلامة وفحص قبل المغادرة.',
      inclusions: ['فحص كهربائي', 'إصلاح مفاتيح', 'تركيب إضاءة', 'تقرير مختصر'],
    ),
    Service(
      id: 'ac',
      title: 'صيانة مكيف',
      subtitle: 'تبريد أفضل خلال دقائق',
      price: 'من 70 ر.س',
      eta: '22 دقيقة',
      icon: Icons.ac_unit_rounded,
      description:
          'فحص وتنظيف وصيانة مكيفات سبليت وشباك مع مزودين قريبين من موقعك.',
      inclusions: ['تنظيف فلتر', 'فحص تبريد', 'كشف تسريب', 'توصية فنية'],
    ),
    Service(
      id: 'roadside',
      title: 'مساعدة طريق',
      subtitle: 'اشتراك بطارية أو بنزين',
      price: 'من 45 ر.س',
      eta: '10 دقائق',
      icon: Icons.car_repair_rounded,
      popular: true,
      description:
          'مساعدة سريعة على الطريق داخل جدة للحالات البسيطة مثل البطارية أو الوقود.',
      inclusions: ['اشتراك بطارية', 'وقود طارئ', 'تغيير إطار', 'موقع مباشر'],
    ),
  ];
}
