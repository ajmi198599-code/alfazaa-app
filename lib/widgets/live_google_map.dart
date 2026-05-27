import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../models/live_map_models.dart';
import '../models/maps_api_config.dart';
import '../models/provider_profile.dart';
import '../models/service.dart';
import '../services/map_service.dart';
import '../theme/app_theme.dart';
import 'app_button.dart';
import 'live_indicator.dart';
import 'provider_marker_card.dart';
import 'shimmer.dart';

enum LiveMapMode { home, matching, tracking, compact }

class LiveGoogleMap extends StatefulWidget {
  const LiveGoogleMap({
    super.key,
    required this.service,
    this.mode = LiveMapMode.home,
    this.height = 300,
    this.onRequest,
    this.primaryLabel = 'اطلب فزعتك الآن',
    this.showServiceDrawer = true,
    this.interactive = false,
  });

  final Service service;
  final LiveMapMode mode;
  final double height;
  final VoidCallback? onRequest;
  final String primaryLabel;
  final bool showServiceDrawer;
  final bool interactive;

  @override
  State<LiveGoogleMap> createState() => _LiveGoogleMapState();
}

class _LiveGoogleMapState extends State<LiveGoogleMap>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  final MapService _mapService = const MapService();
  late final List<LiveMapProvider> _providers;
  GoogleMapController? _mapController;
  Timer? _markerTimer;
  Timer? _cameraTimer;
  double _markerProgress = 0;
  int _focusIndex = 0;

  bool get _canUseGoogleMap =>
      !kIsWeb ||
      MapsApiConfig.googleMapsApiKey.isNotEmpty ||
      MapsApiConfig.googleMapsEnabled;

  bool get _isMatching => widget.mode == LiveMapMode.matching;
  bool get _isTracking => widget.mode == LiveMapMode.tracking;

  @override
  void initState() {
    super.initState();
    _providers = _mapService.providersFor(widget.service);
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    _markerTimer = Timer.periodic(const Duration(milliseconds: 1350), (_) {
      if (!mounted) return;
      setState(() => _markerProgress = (_markerProgress + 0.075) % 1);
      _animateCameraToLiveFocus();
    });

    _cameraTimer = Timer.periodic(const Duration(seconds: 7), (_) {
      if (!mounted || !_canUseGoogleMap) return;
      setState(() => _focusIndex = (_focusIndex + 1) % _providers.length);
      _animateCameraToLiveFocus();
    });
  }

  @override
  void dispose() {
    _markerTimer?.cancel();
    _cameraTimer?.cancel();
    _pulseController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LiveGoogleMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.service.id != widget.service.id) {
      setState(() {
        _markerProgress = 0;
        _focusIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColors.deepBlack,
          border: Border.all(color: AppColors.gold.withValues(alpha: 0.16)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: _canUseGoogleMap ? _buildGoogleMap() : _buildFallbackMap(),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.16),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.36),
                  ],
                ),
              ),
            ),
            _buildAnimatedOverlay(),
            Positioned(
              top: 14,
              right: 14,
              left: 14,
              child: PointerInterceptor(
                intercepting: _canUseGoogleMap,
                child: _MapHeader(
                  mode: widget.mode,
                  count: _providers.length + 19,
                  service: widget.service,
                ),
              ),
            ),
            if (widget.showServiceDrawer)
              Positioned(
                right: 14,
                left: 14,
                bottom: 14,
                child: PointerInterceptor(
                  intercepting: _canUseGoogleMap,
                  child: _ServiceDrawer(
                    service: widget.service,
                    provider: _providers.first.profile,
                    label: widget.primaryLabel,
                    onRequest: widget.onRequest,
                    matching: _isMatching,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleMap() {
    final user = _toLatLng(_mapService.fallbackLocation);
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: user,
        zoom: _isMatching ? 15.4 : 14.7,
      ),
      style: AlfazaaMapStyle.darkJson,
      mapType: MapType.normal,
      markers: _markers,
      circles: _circles,
      polylines: _polylines,
      onMapCreated: (controller) {
        _mapController = controller;
        _animateCameraToLiveFocus();
      },
      compassEnabled: false,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      trafficEnabled: true,
      buildingsEnabled: true,
      rotateGesturesEnabled: widget.interactive,
      scrollGesturesEnabled: widget.interactive,
      zoomGesturesEnabled: widget.interactive,
      tiltGesturesEnabled: false,
      webGestureHandling: widget.interactive
          ? WebGestureHandling.greedy
          : WebGestureHandling.none,
      layoutDirection: TextDirection.ltr,
      padding: EdgeInsets.only(bottom: widget.showServiceDrawer ? 112 : 18),
    );
  }

  Widget _buildFallbackMap() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return CustomPaint(
          painter: _FallbackLiveMapPainter(progress: _pulseController.value),
          child: const SizedBox.expand(),
        );
      },
    );
  }

  Widget _buildAnimatedOverlay() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final progress = _pulseController.value;
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            return Stack(
              children: [
                UserLocationPulseMarker(
                  left: width * 0.50 - 28,
                  top: height * (_isTracking ? 0.46 : 0.52) - 28,
                  progress: progress,
                ),
                ..._providers.asMap().entries.map((entry) {
                  final provider = entry.value;
                  final phase = progress * math.pi * 2 + provider.phase;
                  final left =
                      width * (provider.overlayX + math.sin(phase) * 0.018) -
                          24;
                  final top = height *
                          (provider.overlayY + math.cos(phase * 0.9) * 0.018) -
                      24;
                  return ProviderMarkerCard(
                    provider: provider,
                    highlighted: entry.key == _focusIndex ||
                        (_isTracking && entry.key == 0),
                    left: left,
                    top: top,
                    progress: progress,
                  );
                }),
                if (_isMatching)
                  Positioned(
                    left: 18,
                    bottom: widget.showServiceDrawer ? 116 : 18,
                    child: _SearchingBadge(progress: progress),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Set<Marker> get _markers {
    final providers = _providers.map((provider) {
      final position = _mapService.providerPosition(provider, _markerProgress);
      return Marker(
        markerId: MarkerId(provider.id),
        position: _toLatLng(position),
        infoWindow: InfoWindow(
          title: provider.profile.name,
          snippet: '${provider.profile.eta} • ${provider.status}',
        ),
        anchor: const Offset(0.5, 0.5),
      );
    });

    return {
      Marker(
        markerId: const MarkerId('user-location'),
        position: _toLatLng(_mapService.fallbackLocation),
        infoWindow:
            const InfoWindow(title: 'موقعك الحالي', snippet: 'جدة، حي الروضة'),
        anchor: const Offset(0.5, 0.5),
      ),
      ...providers,
    };
  }

  Set<Circle> get _circles {
    final user = _toLatLng(_mapService.fallbackLocation);
    return {
      Circle(
        circleId: const CircleId('user-radius'),
        center: user,
        radius: _isMatching ? 1350 : 950,
        fillColor: AppColors.gold.withValues(alpha: 0.08),
        strokeColor: AppColors.gold.withValues(alpha: 0.24),
        strokeWidth: 1,
      ),
      Circle(
        circleId: const CircleId('green-service-zone'),
        center: user,
        radius: _isMatching ? 2200 : 1750,
        fillColor: AppColors.saudiGreen.withValues(alpha: 0.045),
        strokeColor: AppColors.greenLight.withValues(alpha: 0.12),
        strokeWidth: 1,
      ),
    };
  }

  Set<Polyline> get _polylines {
    if (!_isTracking && !_isMatching) return {};
    final firstProvider =
        _mapService.providerPosition(_providers.first, _markerProgress);
    return {
      Polyline(
        polylineId: const PolylineId('provider-route'),
        points: [
          _toLatLng(firstProvider),
          _toLatLng(AlfazaaMapSimulation.offset(
            _mapService.fallbackLocation,
            latMeters: 420,
            lngMeters: -280,
          )),
          _toLatLng(_mapService.fallbackLocation),
        ],
        color: AppColors.gold,
        width: 5,
        patterns: [PatternItem.dash(18), PatternItem.gap(12)],
      ),
    };
  }

  void _animateCameraToLiveFocus() {
    final controller = _mapController;
    if (controller == null || !_canUseGoogleMap) return;
    final focus = _isTracking || _isMatching
        ? _mapService.providerPosition(_providers[_focusIndex], _markerProgress)
        : _mapService.fallbackLocation;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _toLatLng(focus),
          zoom: _isMatching
              ? 15.8
              : _isTracking
                  ? 15.4
                  : 14.9,
        ),
      ),
    );
  }

  LatLng _toLatLng(MapCoordinate coordinate) {
    return LatLng(coordinate.latitude, coordinate.longitude);
  }
}

class _MapHeader extends StatelessWidget {
  const _MapHeader({
    required this.mode,
    required this.count,
    required this.service,
  });

  final LiveMapMode mode;
  final int count;
  final Service service;

  @override
  Widget build(BuildContext context) {
    final label = switch (mode) {
      LiveMapMode.matching => 'بحث مباشر',
      LiveMapMode.tracking => 'المزود في الطريق',
      LiveMapMode.compact => 'نطاق الخدمة',
      LiveMapMode.home => 'النظام يعمل الآن',
    };

    return Row(
      children: [
        LiveIndicator(label: label),
        const Spacer(),
        Container(
          constraints: const BoxConstraints(maxWidth: 190),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.58),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.22)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.bolt_rounded, color: AppColors.gold, size: 17),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  '$count مزود • ${service.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ServiceDrawer extends StatelessWidget {
  const _ServiceDrawer({
    required this.service,
    required this.provider,
    required this.label,
    required this.onRequest,
    required this.matching,
  });

  final Service service;
  final AlfazaaProvider provider;
  final String label;
  final VoidCallback? onRequest;
  final bool matching;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.90),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.38),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  gradient: AppGradients.gold,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(service.icon, color: AppColors.deepBlack, size: 23),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${provider.name} • ${provider.eta} • ${service.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (matching) ...[
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(child: ShimmerLine(height: 8)),
                SizedBox(width: 10),
                ShimmerLine(width: 72, height: 8),
              ],
            ),
          ],
          if (onRequest != null) ...[
            const SizedBox(height: 12),
            AppButton(
              label: label,
              icon: Icons.flash_on_rounded,
              height: 50,
              onPressed: onRequest,
            ),
          ],
        ],
      ),
    );
  }
}

class _SearchingBadge extends StatelessWidget {
  const _SearchingBadge({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.68),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.gold.withValues(alpha: 0.22)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                value: 0.35 + (progress * 0.55),
                strokeWidth: 2,
                color: AppColors.gold,
                backgroundColor: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'مطابقة ذكية',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FallbackLiveMapPainter extends CustomPainter {
  const _FallbackLiveMapPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.deepBlack);

    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.055)
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke;
    final arteryPaint = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.16)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 9; i++) {
      final x = size.width * i / 8;
      final path = Path()
        ..moveTo(x, 0)
        ..quadraticBezierTo(x + math.sin(i + progress) * 30, size.height * 0.48,
            x - 12, size.height);
      canvas.drawPath(path, gridPaint);
    }

    for (var i = 0; i < 7; i++) {
      final y = size.height * i / 6;
      final path = Path()
        ..moveTo(0, y)
        ..quadraticBezierTo(size.width * 0.42, y + math.cos(i + progress) * 22,
            size.width, y - 12);
      canvas.drawPath(path, gridPaint);
    }

    final mainRoad = Path()
      ..moveTo(size.width * 0.04, size.height * 0.74)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.38,
        size.width * 0.64,
        size.height * 0.82,
        size.width * 0.95,
        size.height * 0.30,
      );
    canvas.drawPath(mainRoad, arteryPaint);

    final center = Offset(size.width * 0.50, size.height * 0.52);
    for (var ring = 0; ring < 4; ring++) {
      final t = (progress + ring / 4) % 1;
      canvas.drawCircle(
        center,
        28 + t * 110,
        Paint()
          ..color = AppColors.gold.withValues(alpha: (1 - t) * 0.15)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
    }

    final glowPaint = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.20)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22);
    canvas.drawCircle(center, 44, glowPaint);
  }

  @override
  bool shouldRepaint(covariant _FallbackLiveMapPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
