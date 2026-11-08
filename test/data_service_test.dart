import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haly/app/data/data_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
      'invalid sync data preserves the cache and same-name images stay distinct',
      () async {
    final directory =
        await Directory.systemTemp.createTemp('abadan-cache-test');
    addTearDown(() => directory.delete(recursive: true));
    const channel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (_) async => directory.path);
    addTearDown(() => TestDefaultBinaryMessengerBinding
        .instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null));
    GetStorage('GetStorage', directory.path);
    await GetStorage.init();

    final catalog = <String, dynamic>{
      'edges': [],
      'settings': {
        'size_range': {
          'height': {'min': 1, 'max': 10},
          'width': {'min': 1, 'max': 10},
        },
      },
      'intros': [],
      'about': {'title': 'Old catalog', 'description': '', 'files': []},
      'contacts': [],
      'categories': [],
      'products': [],
    };
    final invalidService = DataService(
      client: MockClient((_) async => http.Response('{}', 200)),
    );
    await invalidService.writeCarpetData(jsonEncode(catalog));
    await expectLater(
      invalidService.importDataFromApi(),
      throwsA(isA<FormatException>()),
    );
    expect((await invalidService.getCarpetData()).about.title, 'Old catalog');

    const firstUrl = 'https://one.example/images/photo.jpg';
    const secondUrl = 'https://two.example/images/photo.jpg';
    catalog['about'] = {
      'title': 'New catalog',
      'description': '',
      'files': [firstUrl, secondUrl],
    };
    final service = DataService(
      client: MockClient((request) async {
        if (request.url.path == '/api/sync') {
          return http.Response(jsonEncode(catalog), 200);
        }
        return http.Response(request.url.host, 200);
      }),
    );
    await service.importDataFromApi();

    final imported = await service.getCarpetData();
    expect(imported.about.title, 'New catalog');
    expect(imported.about.files[0], isNot(imported.about.files[1]));
    expect(await File(imported.about.files[0]).readAsString(), 'one.example');
    expect(await File(imported.about.files[1]).readAsString(), 'two.example');
  });
}
