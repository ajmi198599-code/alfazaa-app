import 'dart:math' as math;

import '../models/provider_profile.dart';
import '../models/service.dart';

class MapCoordinate {
  const MapCoordinate(this.latitude, this.longitude);

  final double latitude;
  final double longitude;
}

class LiveMapProvider {
  const LiveMapProvider({
    required this.id,
    required this.profile,
    required this.baseLocation,
    required this.overlayX,
    required this.overlayY,
    required this.driftMeters,
    required this.phase,
    required this.status,
    required this.service,
  });

  final String id;
  final AlfazaaProvider profile;
  final MapCoordinate baseLocation;
  final double overlayX;
  final double overlayY;
  final double driftMeters;
  final double phase;
  final String status;
  final Service service;

  String get initials {
    final parts = profile.name.split(' ');
    if (parts.length < 2)
      return profile.name.substring(0, math.min(profile.name.length, 2));
    return '${parts.first[0]}${parts.last[0]}';
  }
}

class AlfazaaMapSimulation {
  const AlfazaaMapSimulation._();

  static const MapCoordinate userLocation = MapCoordinate(21.5685, 39.1664);
  static const MapCoordinate alRawdah = MapCoordinate(21.5685, 39.1664);
  static const MapCoordinate alKhalidiyah = MapCoordinate(21.5543, 39.1489);
  static const MapCoordinate alSalamah = MapCoordinate(21.5922, 39.1534);

  static List<LiveMapProvider> providersFor(Service service) {
    final fallback = ServiceCatalog.items.first;
    return [
      LiveMapProvider(
        id: 'provider-rakan',
        profile: ProviderData.nearby[0],
        baseLocation: const MapCoordinate(21.5746, 39.1718),
        overlayX: 0.62,
        overlayY: 0.34,
        driftMeters: 68,
        phase: 0.2,
        status: 'جاهز الآن',
        service: service,
      ),
      LiveMapProvider(
        id: 'provider-abdullah',
        profile: ProviderData.nearby[1],
        baseLocation: const MapCoordinate(21.5613, 39.1574),
        overlayX: 0.34,
        overlayY: 0.50,
        driftMeters: 56,
        phase: 1.8,
        status: 'ينهي طلب قريب',
        service: ServiceCatalog.items.length > 1
            ? ServiceCatalog.items[1]
            : fallback,
      ),
      LiveMapProvider(
        id: 'provider-nawaf',
        profile: ProviderData.nearby[2],
        baseLocation: const MapCoordinate(21.5810, 39.1478),
        overlayX: 0.25,
        overlayY: 0.26,
        driftMeters: 80,
        phase: 2.6,
        status: 'متاح خلال دقائق',
        service: ServiceCatalog.items.length > 7
            ? ServiceCatalog.items[7]
            : fallback,
      ),
      LiveMapProvider(
        id: 'provider-salem',
        profile: ProviderData.nearby[0],
        baseLocation: const MapCoordinate(21.5517, 39.1787),
        overlayX: 0.70,
        overlayY: 0.67,
        driftMeters: 48,
        phase: 3.4,
        status: 'متجه للروضة',
        service: ServiceCatalog.items.length > 4
            ? ServiceCatalog.items[4]
            : fallback,
      ),
    ];
  }

  static MapCoordinate providerPosition(
      LiveMapProvider provider, double progress) {
    final angle = (progress * math.pi * 2) + provider.phase;
    final latMeters = math.sin(angle) * provider.driftMeters;
    final lngMeters = math.cos(angle * 0.78) * provider.driftMeters;
    return offset(provider.baseLocation,
        latMeters: latMeters, lngMeters: lngMeters);
  }

  static MapCoordinate offset(
    MapCoordinate origin, {
    required double latMeters,
    required double lngMeters,
  }) {
    final latitude = origin.latitude + (latMeters / 111320);
    final longitude = origin.longitude +
        (lngMeters / (111320 * math.cos(origin.latitude * math.pi / 180)));
    return MapCoordinate(latitude, longitude);
  }
}

class AlfazaaMapStyle {
  const AlfazaaMapStyle._();

  static const String darkJson = '''
[
  {"elementType":"geometry","stylers":[{"color":"#10100E"}]},
  {"elementType":"labels.icon","stylers":[{"visibility":"off"}]},
  {"elementType":"labels.text.fill","stylers":[{"color":"#D7D0B8"}]},
  {"elementType":"labels.text.stroke","stylers":[{"color":"#0D0D0D"}]},
  {"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#3C3420"}]},
  {"featureType":"poi","elementType":"geometry","stylers":[{"color":"#171717"}]},
  {"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#0B2417"}]},
  {"featureType":"road","elementType":"geometry","stylers":[{"color":"#242424"}]},
  {"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#3A311A"}]},
  {"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#B7B7B7"}]},
  {"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3A321B"}]},
  {"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#D4AF37"}]},
  {"featureType":"transit","elementType":"geometry","stylers":[{"color":"#161616"}]},
  {"featureType":"water","elementType":"geometry","stylers":[{"color":"#06120E"}]},
  {"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#006C35"}]}
]
''';
}
