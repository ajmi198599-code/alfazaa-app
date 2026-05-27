import 'live_map_models.dart';

class ProviderModel {
  const ProviderModel({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.rating,
    required this.eta,
    required this.latitude,
    required this.longitude,
    required this.availabilityStatus,
  });

  final String id;
  final String name;
  final String serviceType;
  final double rating;
  final String eta;
  final double latitude;
  final double longitude;
  final String availabilityStatus;

  factory ProviderModel.fromLiveProvider(
    LiveMapProvider provider,
    MapCoordinate position,
  ) {
    return ProviderModel(
      id: provider.id,
      name: provider.profile.name,
      serviceType: provider.service.title,
      rating: provider.profile.rating,
      eta: provider.profile.eta,
      latitude: position.latitude,
      longitude: position.longitude,
      availabilityStatus: provider.status,
    );
  }
}
