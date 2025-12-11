import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_instructor_app/core/di/injection_container.dart';
import '../cubit/qr_cubit.dart';

class QrGenerationScreen extends StatefulWidget {
  final String lectureId;

  const QrGenerationScreen({super.key, required this.lectureId});

  @override
  State<QrGenerationScreen> createState() => _QrGenerationScreenState();
}

class _QrGenerationScreenState extends State<QrGenerationScreen> {
  final _durationController = TextEditingController(text: '600');
  late final QrCubit _cubit;
  Timer? _timer;
  bool _isGenerated = false;
  String? _qrData;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<QrCubit>();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cubit.close();
    _durationController.dispose();
    super.dispose();
  }

  void _generate() {
    final duration = int.tryParse(_durationController.text) ?? 600;
    _cubit.generateQr(widget.lectureId, duration);
  }

  void _startPolling() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted) {
        _timer?.cancel();
        return;
      }
      debugPrint('Polling attendance stats...');
      _cubit.fetchStats(widget.lectureId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Generate QR'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: BlocConsumer<QrCubit, QrState>(
              listener: (context, state) {
                if (state is QrGenerated) {
                  if (!_isGenerated) {
                    setState(() {
                      _isGenerated = true;
                      // Encode qrCodeId, uuidTokenHash, and lectureId as JSON
                      _qrData = jsonEncode({
                        'qrCodeId': state.qrCode.id,
                        'uuidTokenHash': state.qrCode.uuidTokenHash,
                        'lectureId': widget.lectureId,
                      });
                    });
                    _startPolling();
                  }
                } else if (state is QrError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (_isGenerated && _qrData != null) {
                  // Get stats if available
                  Map<String, dynamic>? stats;
                  if (state is QrGenerated) {
                    stats = state.stats;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          QrImageView(
                            data: _qrData!,
                            version: QrVersions.auto,
                            size: 300.0,
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Scan this QR Code',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (stats != null) ...[
                        const SizedBox(width: 48),
                        AttendanceLiveStatus(stats: stats),
                      ],
                    ],
                  );
                }

                if (state is QrLoading) {
                  return const CircularProgressIndicator();
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _durationController,
                      decoration: const InputDecoration(
                        labelText: 'Duration (seconds)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _generate,
                      child: const Text('Generate QR Code'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AttendanceLiveStatus extends StatelessWidget {
  final Map<String, dynamic> stats;
  const AttendanceLiveStatus({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Live Attendance',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ...stats.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '${e.key.toUpperCase()}: ${e.value}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
