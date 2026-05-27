import '../models/live_map_models.dart';
import '../models/provider_model.dart';
import '../models/service.dart';

class MapService {
  const MapService();

  MapCoordinate get fallbackLocation => AlfazaaMapSimulation.userLocation;

  List<LiveMapProvider> providersFor(Service service) {
    return AlfazaaMapSimulation.providersFor(service);
  }

  MapCoordinate providerPosition(LiveMapProvider provider, double progress) {
    return AlfazaaMapSimulation.providerPosition(provider, progress);
  }

  List<ProviderModel> providerModelsFor(Service service, double progress) {
    return providersFor(service)
        .map((provider) => ProviderModel.fromLiveProvider(
              provider,
              providerPosition(provider, progress),
            ))
        .toList(growable: false);
  }
}
