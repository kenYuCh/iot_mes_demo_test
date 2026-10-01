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

/// 一個韌體 Release 內的實體產物；同版可含 HEX、BIN、DFU ZIP 與簽章。
abstract class FirmwareArtifact implements _i1.SerializableModel {
  FirmwareArtifact._({
    this.id,
    required this.companyId,
    required this.firmwarePackageId,
    required this.fileName,
    required this.fileType,
    this.core,
    required this.storagePath,
    required this.sha256,
    required this.sizeBytes,
    required this.isPrimary,
    required this.createdAt,
    this.deletedAt,
  });

  factory FirmwareArtifact({
    int? id,
    required int companyId,
    required int firmwarePackageId,
    required String fileName,
    required String fileType,
    String? core,
    required String storagePath,
    required String sha256,
    required int sizeBytes,
    required bool isPrimary,
    required DateTime createdAt,
    DateTime? deletedAt,
  }) = _FirmwareArtifactImpl;

  factory FirmwareArtifact.fromJson(Map<String, dynamic> jsonSerialization) {
    return FirmwareArtifact(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      firmwarePackageId: jsonSerialization['firmwarePackageId'] as int,
      fileName: jsonSerialization['fileName'] as String,
      fileType: jsonSerialization['fileType'] as String,
      core: jsonSerialization['core'] as String?,
      storagePath: jsonSerialization['storagePath'] as String,
      sha256: jsonSerialization['sha256'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      isPrimary: _i1.BoolJsonExtension.fromJson(jsonSerialization['isPrimary']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  int firmwarePackageId;

  String fileName;

  String fileType;

  String? core;

  String storagePath;

  String sha256;

  int sizeBytes;

  bool isPrimary;

  DateTime createdAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [FirmwareArtifact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FirmwareArtifact copyWith({
    int? id,
    int? companyId,
    int? firmwarePackageId,
    String? fileName,
    String? fileType,
    String? core,
    String? storagePath,
    String? sha256,
    int? sizeBytes,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FirmwareArtifact',
      if (id != null) 'id': id,
      'companyId': companyId,
      'firmwarePackageId': firmwarePackageId,
      'fileName': fileName,
      'fileType': fileType,
      if (core != null) 'core': core,
      'storagePath': storagePath,
      'sha256': sha256,
      'sizeBytes': sizeBytes,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FirmwareArtifactImpl extends FirmwareArtifact {
  _FirmwareArtifactImpl({
    int? id,
    required int companyId,
    required int firmwarePackageId,
    required String fileName,
    required String fileType,
    String? core,
    required String storagePath,
    required String sha256,
    required int sizeBytes,
    required bool isPrimary,
    required DateTime createdAt,
    DateTime? deletedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         firmwarePackageId: firmwarePackageId,
         fileName: fileName,
         fileType: fileType,
         core: core,
         storagePath: storagePath,
         sha256: sha256,
         sizeBytes: sizeBytes,
         isPrimary: isPrimary,
         createdAt: createdAt,
         deletedAt: deletedAt,
       );

  /// Returns a shallow copy of this [FirmwareArtifact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FirmwareArtifact copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? firmwarePackageId,
    String? fileName,
    String? fileType,
    Object? core = _Undefined,
    String? storagePath,
    String? sha256,
    int? sizeBytes,
    bool? isPrimary,
    DateTime? createdAt,
    Object? deletedAt = _Undefined,
  }) {
    return FirmwareArtifact(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      firmwarePackageId: firmwarePackageId ?? this.firmwarePackageId,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      core: core is String? ? core : this.core,
      storagePath: storagePath ?? this.storagePath,
      sha256: sha256 ?? this.sha256,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
