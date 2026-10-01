/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../ota/firmware_package_state.dart' as _i2;

/// 經簽章與雜湊驗證的 OTA 韌體套件 Metadata。
abstract class FirmwarePackage implements _i1.SerializableModel {
  FirmwarePackage._({
    this.id,
    required this.companyId,
    required this.name,
    required this.version,
    required this.targetDeviceType,
    this.productKey,
    this.chipFamily,
    this.updateProtocol,
    this.hardwareRevision,
    this.releaseNotes,
    required this.downloadUrl,
    this.fileName,
    this.storagePath,
    required this.sha256,
    required this.sizeBytes,
    required this.state,
    required this.createdBy,
    required this.createdAt,
    this.deletedAt,
    this.deletedBy,
  });

  factory FirmwarePackage({
    int? id,
    required int companyId,
    required String name,
    required String version,
    required String targetDeviceType,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? releaseNotes,
    required String downloadUrl,
    String? fileName,
    String? storagePath,
    required String sha256,
    required int sizeBytes,
    required _i2.FirmwarePackageState state,
    required String createdBy,
    required DateTime createdAt,
    DateTime? deletedAt,
    String? deletedBy,
  }) = _FirmwarePackageImpl;

  factory FirmwarePackage.fromJson(Map<String, dynamic> jsonSerialization) {
    return FirmwarePackage(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      name: jsonSerialization['name'] as String,
      version: jsonSerialization['version'] as String,
      targetDeviceType: jsonSerialization['targetDeviceType'] as String,
      productKey: jsonSerialization['productKey'] as String?,
      chipFamily: jsonSerialization['chipFamily'] as String?,
      updateProtocol: jsonSerialization['updateProtocol'] as String?,
      hardwareRevision: jsonSerialization['hardwareRevision'] as String?,
      releaseNotes: jsonSerialization['releaseNotes'] as String?,
      downloadUrl: jsonSerialization['downloadUrl'] as String,
      fileName: jsonSerialization['fileName'] as String?,
      storagePath: jsonSerialization['storagePath'] as String?,
      sha256: jsonSerialization['sha256'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      state: _i2.FirmwarePackageState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
      deletedBy: jsonSerialization['deletedBy'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  String name;

  String version;

  String targetDeviceType;

  /// 產品族、MCU 與更新協定，例如 gateway / nrf52840 / mcuboot。
  String? productKey;

  String? chipFamily;

  String? updateProtocol;

  String? hardwareRevision;

  String? releaseNotes;

  String downloadUrl;

  /// Server 韌體資產目錄內的原始 .bin 檔名與絕對路徑。
  String? fileName;

  String? storagePath;

  String sha256;

  int sizeBytes;

  _i2.FirmwarePackageState state;

  String createdBy;

  DateTime createdAt;

  DateTime? deletedAt;

  String? deletedBy;

  /// Returns a shallow copy of this [FirmwarePackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FirmwarePackage copyWith({
    int? id,
    int? companyId,
    String? name,
    String? version,
    String? targetDeviceType,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? releaseNotes,
    String? downloadUrl,
    String? fileName,
    String? storagePath,
    String? sha256,
    int? sizeBytes,
    _i2.FirmwarePackageState? state,
    String? createdBy,
    DateTime? createdAt,
    DateTime? deletedAt,
    String? deletedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FirmwarePackage',
      if (id != null) 'id': id,
      'companyId': companyId,
      'name': name,
      'version': version,
      'targetDeviceType': targetDeviceType,
      if (productKey != null) 'productKey': productKey,
      if (chipFamily != null) 'chipFamily': chipFamily,
      if (updateProtocol != null) 'updateProtocol': updateProtocol,
      if (hardwareRevision != null) 'hardwareRevision': hardwareRevision,
      if (releaseNotes != null) 'releaseNotes': releaseNotes,
      'downloadUrl': downloadUrl,
      if (fileName != null) 'fileName': fileName,
      if (storagePath != null) 'storagePath': storagePath,
      'sha256': sha256,
      'sizeBytes': sizeBytes,
      'state': state.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      if (deletedBy != null) 'deletedBy': deletedBy,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FirmwarePackageImpl extends FirmwarePackage {
  _FirmwarePackageImpl({
    int? id,
    required int companyId,
    required String name,
    required String version,
    required String targetDeviceType,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? releaseNotes,
    required String downloadUrl,
    String? fileName,
    String? storagePath,
    required String sha256,
    required int sizeBytes,
    required _i2.FirmwarePackageState state,
    required String createdBy,
    required DateTime createdAt,
    DateTime? deletedAt,
    String? deletedBy,
  }) : super._(
         id: id,
         companyId: companyId,
         name: name,
         version: version,
         targetDeviceType: targetDeviceType,
         productKey: productKey,
         chipFamily: chipFamily,
         updateProtocol: updateProtocol,
         hardwareRevision: hardwareRevision,
         releaseNotes: releaseNotes,
         downloadUrl: downloadUrl,
         fileName: fileName,
         storagePath: storagePath,
         sha256: sha256,
         sizeBytes: sizeBytes,
         state: state,
         createdBy: createdBy,
         createdAt: createdAt,
         deletedAt: deletedAt,
         deletedBy: deletedBy,
       );

  /// Returns a shallow copy of this [FirmwarePackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FirmwarePackage copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? name,
    String? version,
    String? targetDeviceType,
    Object? productKey = _Undefined,
    Object? chipFamily = _Undefined,
    Object? updateProtocol = _Undefined,
    Object? hardwareRevision = _Undefined,
    Object? releaseNotes = _Undefined,
    String? downloadUrl,
    Object? fileName = _Undefined,
    Object? storagePath = _Undefined,
    String? sha256,
    int? sizeBytes,
    _i2.FirmwarePackageState? state,
    String? createdBy,
    DateTime? createdAt,
    Object? deletedAt = _Undefined,
    Object? deletedBy = _Undefined,
  }) {
    return FirmwarePackage(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      version: version ?? this.version,
      targetDeviceType: targetDeviceType ?? this.targetDeviceType,
      productKey: productKey is String? ? productKey : this.productKey,
      chipFamily: chipFamily is String? ? chipFamily : this.chipFamily,
      updateProtocol: updateProtocol is String?
          ? updateProtocol
          : this.updateProtocol,
      hardwareRevision: hardwareRevision is String?
          ? hardwareRevision
          : this.hardwareRevision,
      releaseNotes: releaseNotes is String? ? releaseNotes : this.releaseNotes,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      fileName: fileName is String? ? fileName : this.fileName,
      storagePath: storagePath is String? ? storagePath : this.storagePath,
      sha256: sha256 ?? this.sha256,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      state: state ?? this.state,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
      deletedBy: deletedBy is String? ? deletedBy : this.deletedBy,
    );
  }
}
