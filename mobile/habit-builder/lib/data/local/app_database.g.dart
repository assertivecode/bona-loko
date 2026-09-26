// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AssessmentsTable extends Assessments
    with TableInfo<$AssessmentsTable, Assessment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssessmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, completedAt, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assessments';
  @override
  VerificationContext validateIntegrity(Insertable<Assessment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Assessment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Assessment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $AssessmentsTable createAlias(String alias) {
    return $AssessmentsTable(attachedDatabase, alias);
  }
}

class Assessment extends DataClass implements Insertable<Assessment> {
  final String id;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String status;
  const Assessment(
      {required this.id,
      required this.createdAt,
      this.completedAt,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  AssessmentsCompanion toCompanion(bool nullToAbsent) {
    return AssessmentsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      status: Value(status),
    );
  }

  factory Assessment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Assessment(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  Assessment copyWith(
          {String? id,
          DateTime? createdAt,
          Value<DateTime?> completedAt = const Value.absent(),
          String? status}) =>
      Assessment(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('Assessment(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, completedAt, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Assessment &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt &&
          other.status == this.status);
}

class AssessmentsCompanion extends UpdateCompanion<Assessment> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  final Value<String> status;
  final Value<int> rowid;
  const AssessmentsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssessmentsCompanion.insert({
    required String id,
    required DateTime createdAt,
    this.completedAt = const Value.absent(),
    required String status,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        createdAt = Value(createdAt),
        status = Value(status);
  static Insertable<Assessment> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssessmentsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? completedAt,
      Value<String>? status,
      Value<int>? rowid}) {
    return AssessmentsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssessmentAreaScoresTable extends AssessmentAreaScores
    with TableInfo<$AssessmentAreaScoresTable, AssessmentAreaScore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssessmentAreaScoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assessmentIdMeta =
      const VerificationMeta('assessmentId');
  @override
  late final GeneratedColumn<String> assessmentId = GeneratedColumn<String>(
      'assessment_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES assessments (id) ON DELETE CASCADE'));
  static const VerificationMeta _areaKeyMeta =
      const VerificationMeta('areaKey');
  @override
  late final GeneratedColumn<String> areaKey = GeneratedColumn<String>(
      'area_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentPriorityMeta =
      const VerificationMeta('currentPriority');
  @override
  late final GeneratedColumn<int> currentPriority = GeneratedColumn<int>(
      'current_priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currentStateMeta =
      const VerificationMeta('currentState');
  @override
  late final GeneratedColumn<int> currentState = GeneratedColumn<int>(
      'current_state', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currentInvestmentMeta =
      const VerificationMeta('currentInvestment');
  @override
  late final GeneratedColumn<int> currentInvestment = GeneratedColumn<int>(
      'current_investment', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _desiredInvestmentMeta =
      const VerificationMeta('desiredInvestment');
  @override
  late final GeneratedColumn<int> desiredInvestment = GeneratedColumn<int>(
      'desired_investment', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _intentMeta = const VerificationMeta('intent');
  @override
  late final GeneratedColumn<String> intent = GeneratedColumn<String>(
      'intent', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _investmentDeltaMeta =
      const VerificationMeta('investmentDelta');
  @override
  late final GeneratedColumn<int> investmentDelta = GeneratedColumn<int>(
      'investment_delta', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _priorityGapScoreMeta =
      const VerificationMeta('priorityGapScore');
  @override
  late final GeneratedColumn<double> priorityGapScore = GeneratedColumn<double>(
      'priority_gap_score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        assessmentId,
        areaKey,
        currentPriority,
        currentState,
        currentInvestment,
        desiredInvestment,
        intent,
        investmentDelta,
        priorityGapScore
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assessment_area_scores';
  @override
  VerificationContext validateIntegrity(
      Insertable<AssessmentAreaScore> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('assessment_id')) {
      context.handle(
          _assessmentIdMeta,
          assessmentId.isAcceptableOrUnknown(
              data['assessment_id']!, _assessmentIdMeta));
    } else if (isInserting) {
      context.missing(_assessmentIdMeta);
    }
    if (data.containsKey('area_key')) {
      context.handle(_areaKeyMeta,
          areaKey.isAcceptableOrUnknown(data['area_key']!, _areaKeyMeta));
    } else if (isInserting) {
      context.missing(_areaKeyMeta);
    }
    if (data.containsKey('current_priority')) {
      context.handle(
          _currentPriorityMeta,
          currentPriority.isAcceptableOrUnknown(
              data['current_priority']!, _currentPriorityMeta));
    } else if (isInserting) {
      context.missing(_currentPriorityMeta);
    }
    if (data.containsKey('current_state')) {
      context.handle(
          _currentStateMeta,
          currentState.isAcceptableOrUnknown(
              data['current_state']!, _currentStateMeta));
    } else if (isInserting) {
      context.missing(_currentStateMeta);
    }
    if (data.containsKey('current_investment')) {
      context.handle(
          _currentInvestmentMeta,
          currentInvestment.isAcceptableOrUnknown(
              data['current_investment']!, _currentInvestmentMeta));
    } else if (isInserting) {
      context.missing(_currentInvestmentMeta);
    }
    if (data.containsKey('desired_investment')) {
      context.handle(
          _desiredInvestmentMeta,
          desiredInvestment.isAcceptableOrUnknown(
              data['desired_investment']!, _desiredInvestmentMeta));
    } else if (isInserting) {
      context.missing(_desiredInvestmentMeta);
    }
    if (data.containsKey('intent')) {
      context.handle(_intentMeta,
          intent.isAcceptableOrUnknown(data['intent']!, _intentMeta));
    } else if (isInserting) {
      context.missing(_intentMeta);
    }
    if (data.containsKey('investment_delta')) {
      context.handle(
          _investmentDeltaMeta,
          investmentDelta.isAcceptableOrUnknown(
              data['investment_delta']!, _investmentDeltaMeta));
    } else if (isInserting) {
      context.missing(_investmentDeltaMeta);
    }
    if (data.containsKey('priority_gap_score')) {
      context.handle(
          _priorityGapScoreMeta,
          priorityGapScore.isAcceptableOrUnknown(
              data['priority_gap_score']!, _priorityGapScoreMeta));
    } else if (isInserting) {
      context.missing(_priorityGapScoreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssessmentAreaScore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssessmentAreaScore(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      assessmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}assessment_id'])!,
      areaKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area_key'])!,
      currentPriority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_priority'])!,
      currentState: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_state'])!,
      currentInvestment: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}current_investment'])!,
      desiredInvestment: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}desired_investment'])!,
      intent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}intent'])!,
      investmentDelta: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}investment_delta'])!,
      priorityGapScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}priority_gap_score'])!,
    );
  }

  @override
  $AssessmentAreaScoresTable createAlias(String alias) {
    return $AssessmentAreaScoresTable(attachedDatabase, alias);
  }
}

class AssessmentAreaScore extends DataClass
    implements Insertable<AssessmentAreaScore> {
  final String id;
  final String assessmentId;
  final String areaKey;
  final int currentPriority;
  final int currentState;
  final int currentInvestment;
  final int desiredInvestment;
  final String intent;
  final int investmentDelta;
  final double priorityGapScore;
  const AssessmentAreaScore(
      {required this.id,
      required this.assessmentId,
      required this.areaKey,
      required this.currentPriority,
      required this.currentState,
      required this.currentInvestment,
      required this.desiredInvestment,
      required this.intent,
      required this.investmentDelta,
      required this.priorityGapScore});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['assessment_id'] = Variable<String>(assessmentId);
    map['area_key'] = Variable<String>(areaKey);
    map['current_priority'] = Variable<int>(currentPriority);
    map['current_state'] = Variable<int>(currentState);
    map['current_investment'] = Variable<int>(currentInvestment);
    map['desired_investment'] = Variable<int>(desiredInvestment);
    map['intent'] = Variable<String>(intent);
    map['investment_delta'] = Variable<int>(investmentDelta);
    map['priority_gap_score'] = Variable<double>(priorityGapScore);
    return map;
  }

  AssessmentAreaScoresCompanion toCompanion(bool nullToAbsent) {
    return AssessmentAreaScoresCompanion(
      id: Value(id),
      assessmentId: Value(assessmentId),
      areaKey: Value(areaKey),
      currentPriority: Value(currentPriority),
      currentState: Value(currentState),
      currentInvestment: Value(currentInvestment),
      desiredInvestment: Value(desiredInvestment),
      intent: Value(intent),
      investmentDelta: Value(investmentDelta),
      priorityGapScore: Value(priorityGapScore),
    );
  }

  factory AssessmentAreaScore.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssessmentAreaScore(
      id: serializer.fromJson<String>(json['id']),
      assessmentId: serializer.fromJson<String>(json['assessmentId']),
      areaKey: serializer.fromJson<String>(json['areaKey']),
      currentPriority: serializer.fromJson<int>(json['currentPriority']),
      currentState: serializer.fromJson<int>(json['currentState']),
      currentInvestment: serializer.fromJson<int>(json['currentInvestment']),
      desiredInvestment: serializer.fromJson<int>(json['desiredInvestment']),
      intent: serializer.fromJson<String>(json['intent']),
      investmentDelta: serializer.fromJson<int>(json['investmentDelta']),
      priorityGapScore: serializer.fromJson<double>(json['priorityGapScore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'assessmentId': serializer.toJson<String>(assessmentId),
      'areaKey': serializer.toJson<String>(areaKey),
      'currentPriority': serializer.toJson<int>(currentPriority),
      'currentState': serializer.toJson<int>(currentState),
      'currentInvestment': serializer.toJson<int>(currentInvestment),
      'desiredInvestment': serializer.toJson<int>(desiredInvestment),
      'intent': serializer.toJson<String>(intent),
      'investmentDelta': serializer.toJson<int>(investmentDelta),
      'priorityGapScore': serializer.toJson<double>(priorityGapScore),
    };
  }

  AssessmentAreaScore copyWith(
          {String? id,
          String? assessmentId,
          String? areaKey,
          int? currentPriority,
          int? currentState,
          int? currentInvestment,
          int? desiredInvestment,
          String? intent,
          int? investmentDelta,
          double? priorityGapScore}) =>
      AssessmentAreaScore(
        id: id ?? this.id,
        assessmentId: assessmentId ?? this.assessmentId,
        areaKey: areaKey ?? this.areaKey,
        currentPriority: currentPriority ?? this.currentPriority,
        currentState: currentState ?? this.currentState,
        currentInvestment: currentInvestment ?? this.currentInvestment,
        desiredInvestment: desiredInvestment ?? this.desiredInvestment,
        intent: intent ?? this.intent,
        investmentDelta: investmentDelta ?? this.investmentDelta,
        priorityGapScore: priorityGapScore ?? this.priorityGapScore,
      );
  @override
  String toString() {
    return (StringBuffer('AssessmentAreaScore(')
          ..write('id: $id, ')
          ..write('assessmentId: $assessmentId, ')
          ..write('areaKey: $areaKey, ')
          ..write('currentPriority: $currentPriority, ')
          ..write('currentState: $currentState, ')
          ..write('currentInvestment: $currentInvestment, ')
          ..write('desiredInvestment: $desiredInvestment, ')
          ..write('intent: $intent, ')
          ..write('investmentDelta: $investmentDelta, ')
          ..write('priorityGapScore: $priorityGapScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      assessmentId,
      areaKey,
      currentPriority,
      currentState,
      currentInvestment,
      desiredInvestment,
      intent,
      investmentDelta,
      priorityGapScore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssessmentAreaScore &&
          other.id == this.id &&
          other.assessmentId == this.assessmentId &&
          other.areaKey == this.areaKey &&
          other.currentPriority == this.currentPriority &&
          other.currentState == this.currentState &&
          other.currentInvestment == this.currentInvestment &&
          other.desiredInvestment == this.desiredInvestment &&
          other.intent == this.intent &&
          other.investmentDelta == this.investmentDelta &&
          other.priorityGapScore == this.priorityGapScore);
}

class AssessmentAreaScoresCompanion
    extends UpdateCompanion<AssessmentAreaScore> {
  final Value<String> id;
  final Value<String> assessmentId;
  final Value<String> areaKey;
  final Value<int> currentPriority;
  final Value<int> currentState;
  final Value<int> currentInvestment;
  final Value<int> desiredInvestment;
  final Value<String> intent;
  final Value<int> investmentDelta;
  final Value<double> priorityGapScore;
  final Value<int> rowid;
  const AssessmentAreaScoresCompanion({
    this.id = const Value.absent(),
    this.assessmentId = const Value.absent(),
    this.areaKey = const Value.absent(),
    this.currentPriority = const Value.absent(),
    this.currentState = const Value.absent(),
    this.currentInvestment = const Value.absent(),
    this.desiredInvestment = const Value.absent(),
    this.intent = const Value.absent(),
    this.investmentDelta = const Value.absent(),
    this.priorityGapScore = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssessmentAreaScoresCompanion.insert({
    required String id,
    required String assessmentId,
    required String areaKey,
    required int currentPriority,
    required int currentState,
    required int currentInvestment,
    required int desiredInvestment,
    required String intent,
    required int investmentDelta,
    required double priorityGapScore,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        assessmentId = Value(assessmentId),
        areaKey = Value(areaKey),
        currentPriority = Value(currentPriority),
        currentState = Value(currentState),
        currentInvestment = Value(currentInvestment),
        desiredInvestment = Value(desiredInvestment),
        intent = Value(intent),
        investmentDelta = Value(investmentDelta),
        priorityGapScore = Value(priorityGapScore);
  static Insertable<AssessmentAreaScore> custom({
    Expression<String>? id,
    Expression<String>? assessmentId,
    Expression<String>? areaKey,
    Expression<int>? currentPriority,
    Expression<int>? currentState,
    Expression<int>? currentInvestment,
    Expression<int>? desiredInvestment,
    Expression<String>? intent,
    Expression<int>? investmentDelta,
    Expression<double>? priorityGapScore,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assessmentId != null) 'assessment_id': assessmentId,
      if (areaKey != null) 'area_key': areaKey,
      if (currentPriority != null) 'current_priority': currentPriority,
      if (currentState != null) 'current_state': currentState,
      if (currentInvestment != null) 'current_investment': currentInvestment,
      if (desiredInvestment != null) 'desired_investment': desiredInvestment,
      if (intent != null) 'intent': intent,
      if (investmentDelta != null) 'investment_delta': investmentDelta,
      if (priorityGapScore != null) 'priority_gap_score': priorityGapScore,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssessmentAreaScoresCompanion copyWith(
      {Value<String>? id,
      Value<String>? assessmentId,
      Value<String>? areaKey,
      Value<int>? currentPriority,
      Value<int>? currentState,
      Value<int>? currentInvestment,
      Value<int>? desiredInvestment,
      Value<String>? intent,
      Value<int>? investmentDelta,
      Value<double>? priorityGapScore,
      Value<int>? rowid}) {
    return AssessmentAreaScoresCompanion(
      id: id ?? this.id,
      assessmentId: assessmentId ?? this.assessmentId,
      areaKey: areaKey ?? this.areaKey,
      currentPriority: currentPriority ?? this.currentPriority,
      currentState: currentState ?? this.currentState,
      currentInvestment: currentInvestment ?? this.currentInvestment,
      desiredInvestment: desiredInvestment ?? this.desiredInvestment,
      intent: intent ?? this.intent,
      investmentDelta: investmentDelta ?? this.investmentDelta,
      priorityGapScore: priorityGapScore ?? this.priorityGapScore,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (assessmentId.present) {
      map['assessment_id'] = Variable<String>(assessmentId.value);
    }
    if (areaKey.present) {
      map['area_key'] = Variable<String>(areaKey.value);
    }
    if (currentPriority.present) {
      map['current_priority'] = Variable<int>(currentPriority.value);
    }
    if (currentState.present) {
      map['current_state'] = Variable<int>(currentState.value);
    }
    if (currentInvestment.present) {
      map['current_investment'] = Variable<int>(currentInvestment.value);
    }
    if (desiredInvestment.present) {
      map['desired_investment'] = Variable<int>(desiredInvestment.value);
    }
    if (intent.present) {
      map['intent'] = Variable<String>(intent.value);
    }
    if (investmentDelta.present) {
      map['investment_delta'] = Variable<int>(investmentDelta.value);
    }
    if (priorityGapScore.present) {
      map['priority_gap_score'] = Variable<double>(priorityGapScore.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentAreaScoresCompanion(')
          ..write('id: $id, ')
          ..write('assessmentId: $assessmentId, ')
          ..write('areaKey: $areaKey, ')
          ..write('currentPriority: $currentPriority, ')
          ..write('currentState: $currentState, ')
          ..write('currentInvestment: $currentInvestment, ')
          ..write('desiredInvestment: $desiredInvestment, ')
          ..write('intent: $intent, ')
          ..write('investmentDelta: $investmentDelta, ')
          ..write('priorityGapScore: $priorityGapScore, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _selectedLanguageMeta =
      const VerificationMeta('selectedLanguage');
  @override
  late final GeneratedColumnWithTypeConverter<AppLanguage, int>
      selectedLanguage = GeneratedColumn<int>(
              'selected_language', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<AppLanguage>($UsersTable.$converterselectedLanguage);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
      'onboarding_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("onboarding_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, selectedLanguage, name, onboardingCompleted];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    context.handle(_selectedLanguageMeta, const VerificationResult.success());
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
          _onboardingCompletedMeta,
          onboardingCompleted.isAcceptableOrUnknown(
              data['onboarding_completed']!, _onboardingCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      selectedLanguage: $UsersTable.$converterselectedLanguage.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}selected_language'])!),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}onboarding_completed'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static TypeConverter<AppLanguage, int> $converterselectedLanguage =
      const AppLanguageConverter();
}

class UserData extends DataClass implements Insertable<UserData> {
  final String id;
  final DateTime createdAt;
  final AppLanguage selectedLanguage;
  final String name;
  final bool onboardingCompleted;
  const UserData(
      {required this.id,
      required this.createdAt,
      required this.selectedLanguage,
      required this.name,
      required this.onboardingCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    {
      map['selected_language'] = Variable<int>(
          $UsersTable.$converterselectedLanguage.toSql(selectedLanguage));
    }
    map['name'] = Variable<String>(name);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      selectedLanguage: Value(selectedLanguage),
      name: Value(name),
      onboardingCompleted: Value(onboardingCompleted),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      selectedLanguage:
          serializer.fromJson<AppLanguage>(json['selectedLanguage']),
      name: serializer.fromJson<String>(json['name']),
      onboardingCompleted:
          serializer.fromJson<bool>(json['onboardingCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'selectedLanguage': serializer.toJson<AppLanguage>(selectedLanguage),
      'name': serializer.toJson<String>(name),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
    };
  }

  UserData copyWith(
          {String? id,
          DateTime? createdAt,
          AppLanguage? selectedLanguage,
          String? name,
          bool? onboardingCompleted}) =>
      UserData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        selectedLanguage: selectedLanguage ?? this.selectedLanguage,
        name: name ?? this.name,
        onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      );
  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('selectedLanguage: $selectedLanguage, ')
          ..write('name: $name, ')
          ..write('onboardingCompleted: $onboardingCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, selectedLanguage, name, onboardingCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.selectedLanguage == this.selectedLanguage &&
          other.name == this.name &&
          other.onboardingCompleted == this.onboardingCompleted);
}

class UsersCompanion extends UpdateCompanion<UserData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<AppLanguage> selectedLanguage;
  final Value<String> name;
  final Value<bool> onboardingCompleted;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.selectedLanguage = const Value.absent(),
    this.name = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required DateTime createdAt,
    required AppLanguage selectedLanguage,
    this.name = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        createdAt = Value(createdAt),
        selectedLanguage = Value(selectedLanguage);
  static Insertable<UserData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? selectedLanguage,
    Expression<String>? name,
    Expression<bool>? onboardingCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (selectedLanguage != null) 'selected_language': selectedLanguage,
      if (name != null) 'name': name,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<AppLanguage>? selectedLanguage,
      Value<String>? name,
      Value<bool>? onboardingCompleted,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      name: name ?? this.name,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (selectedLanguage.present) {
      map['selected_language'] = Variable<int>(
          $UsersTable.$converterselectedLanguage.toSql(selectedLanguage.value));
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('selectedLanguage: $selectedLanguage, ')
          ..write('name: $name, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LifeAreasEvaluationsTable extends LifeAreasEvaluations
    with TableInfo<$LifeAreasEvaluationsTable, LifeAreaEvaluationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LifeAreasEvaluationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lifeAreaMeta =
      const VerificationMeta('lifeArea');
  @override
  late final GeneratedColumnWithTypeConverter<LifeArea, int> lifeArea =
      GeneratedColumn<int>('life_area', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<LifeArea>(
              $LifeAreasEvaluationsTable.$converterlifeArea);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
      'score', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currentPriorityMeta =
      const VerificationMeta('currentPriority');
  @override
  late final GeneratedColumn<int> currentPriority = GeneratedColumn<int>(
      'current_priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _evaluatedAtMeta =
      const VerificationMeta('evaluatedAt');
  @override
  late final GeneratedColumn<DateTime> evaluatedAt = GeneratedColumn<DateTime>(
      'evaluated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, lifeArea, score, currentPriority, evaluatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'life_areas_evaluations';
  @override
  VerificationContext validateIntegrity(
      Insertable<LifeAreaEvaluationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    context.handle(_lifeAreaMeta, const VerificationResult.success());
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('current_priority')) {
      context.handle(
          _currentPriorityMeta,
          currentPriority.isAcceptableOrUnknown(
              data['current_priority']!, _currentPriorityMeta));
    } else if (isInserting) {
      context.missing(_currentPriorityMeta);
    }
    if (data.containsKey('evaluated_at')) {
      context.handle(
          _evaluatedAtMeta,
          evaluatedAt.isAcceptableOrUnknown(
              data['evaluated_at']!, _evaluatedAtMeta));
    } else if (isInserting) {
      context.missing(_evaluatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LifeAreaEvaluationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LifeAreaEvaluationData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      lifeArea: $LifeAreasEvaluationsTable.$converterlifeArea.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}life_area'])!),
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}score'])!,
      currentPriority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_priority'])!,
      evaluatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}evaluated_at'])!,
    );
  }

  @override
  $LifeAreasEvaluationsTable createAlias(String alias) {
    return $LifeAreasEvaluationsTable(attachedDatabase, alias);
  }

  static TypeConverter<LifeArea, int> $converterlifeArea =
      const LifeAreaConverter();
}

class LifeAreaEvaluationData extends DataClass
    implements Insertable<LifeAreaEvaluationData> {
  /// Unique identifier (UUID string)
  final String id;

  /// Canonical Life Area enum (stored as 1-based integer 1..12)
  final LifeArea lifeArea;

  /// Satisfaction / state score (0.0 to 10.0 supporting half-decimals: 0, 0.5, 1, 1.5, ..., 10.0)
  final double score;

  /// Current priority to focus / practice (1 to 5, where 5 is highest priority)
  final int currentPriority;

  /// Timestamp when the evaluation was recorded
  final DateTime evaluatedAt;
  const LifeAreaEvaluationData(
      {required this.id,
      required this.lifeArea,
      required this.score,
      required this.currentPriority,
      required this.evaluatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['life_area'] = Variable<int>(
          $LifeAreasEvaluationsTable.$converterlifeArea.toSql(lifeArea));
    }
    map['score'] = Variable<double>(score);
    map['current_priority'] = Variable<int>(currentPriority);
    map['evaluated_at'] = Variable<DateTime>(evaluatedAt);
    return map;
  }

  LifeAreasEvaluationsCompanion toCompanion(bool nullToAbsent) {
    return LifeAreasEvaluationsCompanion(
      id: Value(id),
      lifeArea: Value(lifeArea),
      score: Value(score),
      currentPriority: Value(currentPriority),
      evaluatedAt: Value(evaluatedAt),
    );
  }

  factory LifeAreaEvaluationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LifeAreaEvaluationData(
      id: serializer.fromJson<String>(json['id']),
      lifeArea: serializer.fromJson<LifeArea>(json['lifeArea']),
      score: serializer.fromJson<double>(json['score']),
      currentPriority: serializer.fromJson<int>(json['currentPriority']),
      evaluatedAt: serializer.fromJson<DateTime>(json['evaluatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lifeArea': serializer.toJson<LifeArea>(lifeArea),
      'score': serializer.toJson<double>(score),
      'currentPriority': serializer.toJson<int>(currentPriority),
      'evaluatedAt': serializer.toJson<DateTime>(evaluatedAt),
    };
  }

  LifeAreaEvaluationData copyWith(
          {String? id,
          LifeArea? lifeArea,
          double? score,
          int? currentPriority,
          DateTime? evaluatedAt}) =>
      LifeAreaEvaluationData(
        id: id ?? this.id,
        lifeArea: lifeArea ?? this.lifeArea,
        score: score ?? this.score,
        currentPriority: currentPriority ?? this.currentPriority,
        evaluatedAt: evaluatedAt ?? this.evaluatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('LifeAreaEvaluationData(')
          ..write('id: $id, ')
          ..write('lifeArea: $lifeArea, ')
          ..write('score: $score, ')
          ..write('currentPriority: $currentPriority, ')
          ..write('evaluatedAt: $evaluatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, lifeArea, score, currentPriority, evaluatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LifeAreaEvaluationData &&
          other.id == this.id &&
          other.lifeArea == this.lifeArea &&
          other.score == this.score &&
          other.currentPriority == this.currentPriority &&
          other.evaluatedAt == this.evaluatedAt);
}

class LifeAreasEvaluationsCompanion
    extends UpdateCompanion<LifeAreaEvaluationData> {
  final Value<String> id;
  final Value<LifeArea> lifeArea;
  final Value<double> score;
  final Value<int> currentPriority;
  final Value<DateTime> evaluatedAt;
  final Value<int> rowid;
  const LifeAreasEvaluationsCompanion({
    this.id = const Value.absent(),
    this.lifeArea = const Value.absent(),
    this.score = const Value.absent(),
    this.currentPriority = const Value.absent(),
    this.evaluatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LifeAreasEvaluationsCompanion.insert({
    required String id,
    required LifeArea lifeArea,
    required double score,
    required int currentPriority,
    required DateTime evaluatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        lifeArea = Value(lifeArea),
        score = Value(score),
        currentPriority = Value(currentPriority),
        evaluatedAt = Value(evaluatedAt);
  static Insertable<LifeAreaEvaluationData> custom({
    Expression<String>? id,
    Expression<int>? lifeArea,
    Expression<double>? score,
    Expression<int>? currentPriority,
    Expression<DateTime>? evaluatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lifeArea != null) 'life_area': lifeArea,
      if (score != null) 'score': score,
      if (currentPriority != null) 'current_priority': currentPriority,
      if (evaluatedAt != null) 'evaluated_at': evaluatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LifeAreasEvaluationsCompanion copyWith(
      {Value<String>? id,
      Value<LifeArea>? lifeArea,
      Value<double>? score,
      Value<int>? currentPriority,
      Value<DateTime>? evaluatedAt,
      Value<int>? rowid}) {
    return LifeAreasEvaluationsCompanion(
      id: id ?? this.id,
      lifeArea: lifeArea ?? this.lifeArea,
      score: score ?? this.score,
      currentPriority: currentPriority ?? this.currentPriority,
      evaluatedAt: evaluatedAt ?? this.evaluatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lifeArea.present) {
      map['life_area'] = Variable<int>(
          $LifeAreasEvaluationsTable.$converterlifeArea.toSql(lifeArea.value));
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (currentPriority.present) {
      map['current_priority'] = Variable<int>(currentPriority.value);
    }
    if (evaluatedAt.present) {
      map['evaluated_at'] = Variable<DateTime>(evaluatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LifeAreasEvaluationsCompanion(')
          ..write('id: $id, ')
          ..write('lifeArea: $lifeArea, ')
          ..write('score: $score, ')
          ..write('currentPriority: $currentPriority, ')
          ..write('evaluatedAt: $evaluatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GratitudeEntriesTable extends GratitudeEntries
    with TableInfo<$GratitudeEntriesTable, GratitudeEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GratitudeEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
      'period', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, content, createdAt, period, orderIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gratitude_entries';
  @override
  VerificationContext validateIntegrity(Insertable<GratitudeEntryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('period')) {
      context.handle(_periodMeta,
          period.isAcceptableOrUnknown(data['period']!, _periodMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GratitudeEntryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GratitudeEntryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      period: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}period']),
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $GratitudeEntriesTable createAlias(String alias) {
    return $GratitudeEntriesTable(attachedDatabase, alias);
  }
}

class GratitudeEntryData extends DataClass
    implements Insertable<GratitudeEntryData> {
  /// Unique identifier (UUID string)
  final String id;

  /// The text content of the gratitude reason / reflection
  final String content;

  /// Timestamp when the entry was recorded
  final DateTime createdAt;

  /// The period/context of the reflection ('morning', 'evening', 'anytime')
  final String? period;

  /// User preference ordering index
  final int orderIndex;
  const GratitudeEntryData(
      {required this.id,
      required this.content,
      required this.createdAt,
      this.period,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || period != null) {
      map['period'] = Variable<String>(period);
    }
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  GratitudeEntriesCompanion toCompanion(bool nullToAbsent) {
    return GratitudeEntriesCompanion(
      id: Value(id),
      content: Value(content),
      createdAt: Value(createdAt),
      period:
          period == null && nullToAbsent ? const Value.absent() : Value(period),
      orderIndex: Value(orderIndex),
    );
  }

  factory GratitudeEntryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GratitudeEntryData(
      id: serializer.fromJson<String>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      period: serializer.fromJson<String?>(json['period']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'period': serializer.toJson<String?>(period),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  GratitudeEntryData copyWith(
          {String? id,
          String? content,
          DateTime? createdAt,
          Value<String?> period = const Value.absent(),
          int? orderIndex}) =>
      GratitudeEntryData(
        id: id ?? this.id,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        period: period.present ? period.value : this.period,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  @override
  String toString() {
    return (StringBuffer('GratitudeEntryData(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('period: $period, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, createdAt, period, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GratitudeEntryData &&
          other.id == this.id &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.period == this.period &&
          other.orderIndex == this.orderIndex);
}

class GratitudeEntriesCompanion extends UpdateCompanion<GratitudeEntryData> {
  final Value<String> id;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<String?> period;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const GratitudeEntriesCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.period = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GratitudeEntriesCompanion.insert({
    required String id,
    required String content,
    required DateTime createdAt,
    this.period = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        content = Value(content),
        createdAt = Value(createdAt);
  static Insertable<GratitudeEntryData> custom({
    Expression<String>? id,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<String>? period,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (period != null) 'period': period,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GratitudeEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? content,
      Value<DateTime>? createdAt,
      Value<String?>? period,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return GratitudeEntriesCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      period: period ?? this.period,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GratitudeEntriesCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('period: $period, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyGratitudeCompletionsTable extends DailyGratitudeCompletions
    with
        TableInfo<$DailyGratitudeCompletionsTable,
            DailyGratitudeCompletionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyGratitudeCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _morningCompletedMeta =
      const VerificationMeta('morningCompleted');
  @override
  late final GeneratedColumn<bool> morningCompleted = GeneratedColumn<bool>(
      'morning_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("morning_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _morningCompletedAtMeta =
      const VerificationMeta('morningCompletedAt');
  @override
  late final GeneratedColumn<DateTime> morningCompletedAt =
      GeneratedColumn<DateTime>('morning_completed_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _eveningCompletedMeta =
      const VerificationMeta('eveningCompleted');
  @override
  late final GeneratedColumn<bool> eveningCompleted = GeneratedColumn<bool>(
      'evening_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("evening_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _eveningCompletedAtMeta =
      const VerificationMeta('eveningCompletedAt');
  @override
  late final GeneratedColumn<DateTime> eveningCompletedAt =
      GeneratedColumn<DateTime>('evening_completed_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        morningCompleted,
        morningCompletedAt,
        eveningCompleted,
        eveningCompletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_gratitude_completions';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailyGratitudeCompletionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('morning_completed')) {
      context.handle(
          _morningCompletedMeta,
          morningCompleted.isAcceptableOrUnknown(
              data['morning_completed']!, _morningCompletedMeta));
    }
    if (data.containsKey('morning_completed_at')) {
      context.handle(
          _morningCompletedAtMeta,
          morningCompletedAt.isAcceptableOrUnknown(
              data['morning_completed_at']!, _morningCompletedAtMeta));
    }
    if (data.containsKey('evening_completed')) {
      context.handle(
          _eveningCompletedMeta,
          eveningCompleted.isAcceptableOrUnknown(
              data['evening_completed']!, _eveningCompletedMeta));
    }
    if (data.containsKey('evening_completed_at')) {
      context.handle(
          _eveningCompletedAtMeta,
          eveningCompletedAt.isAcceptableOrUnknown(
              data['evening_completed_at']!, _eveningCompletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyGratitudeCompletionData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyGratitudeCompletionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      morningCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}morning_completed'])!,
      morningCompletedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}morning_completed_at']),
      eveningCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}evening_completed'])!,
      eveningCompletedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}evening_completed_at']),
    );
  }

  @override
  $DailyGratitudeCompletionsTable createAlias(String alias) {
    return $DailyGratitudeCompletionsTable(attachedDatabase, alias);
  }
}

class DailyGratitudeCompletionData extends DataClass
    implements Insertable<DailyGratitudeCompletionData> {
  /// Unique identifier (UUID string)
  final String id;

  /// Calendar date of the completion (normalized to midnight)
  final DateTime date;

  /// Whether morning grounding (1 min) was completed
  final bool morningCompleted;

  /// Timestamp when morning grounding was completed
  final DateTime? morningCompletedAt;

  /// Whether evening reflection (5 min) was completed
  final bool eveningCompleted;

  /// Timestamp when evening reflection was completed
  final DateTime? eveningCompletedAt;
  const DailyGratitudeCompletionData(
      {required this.id,
      required this.date,
      required this.morningCompleted,
      this.morningCompletedAt,
      required this.eveningCompleted,
      this.eveningCompletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['morning_completed'] = Variable<bool>(morningCompleted);
    if (!nullToAbsent || morningCompletedAt != null) {
      map['morning_completed_at'] = Variable<DateTime>(morningCompletedAt);
    }
    map['evening_completed'] = Variable<bool>(eveningCompleted);
    if (!nullToAbsent || eveningCompletedAt != null) {
      map['evening_completed_at'] = Variable<DateTime>(eveningCompletedAt);
    }
    return map;
  }

  DailyGratitudeCompletionsCompanion toCompanion(bool nullToAbsent) {
    return DailyGratitudeCompletionsCompanion(
      id: Value(id),
      date: Value(date),
      morningCompleted: Value(morningCompleted),
      morningCompletedAt: morningCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(morningCompletedAt),
      eveningCompleted: Value(eveningCompleted),
      eveningCompletedAt: eveningCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(eveningCompletedAt),
    );
  }

  factory DailyGratitudeCompletionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyGratitudeCompletionData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      morningCompleted: serializer.fromJson<bool>(json['morningCompleted']),
      morningCompletedAt:
          serializer.fromJson<DateTime?>(json['morningCompletedAt']),
      eveningCompleted: serializer.fromJson<bool>(json['eveningCompleted']),
      eveningCompletedAt:
          serializer.fromJson<DateTime?>(json['eveningCompletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'morningCompleted': serializer.toJson<bool>(morningCompleted),
      'morningCompletedAt': serializer.toJson<DateTime?>(morningCompletedAt),
      'eveningCompleted': serializer.toJson<bool>(eveningCompleted),
      'eveningCompletedAt': serializer.toJson<DateTime?>(eveningCompletedAt),
    };
  }

  DailyGratitudeCompletionData copyWith(
          {String? id,
          DateTime? date,
          bool? morningCompleted,
          Value<DateTime?> morningCompletedAt = const Value.absent(),
          bool? eveningCompleted,
          Value<DateTime?> eveningCompletedAt = const Value.absent()}) =>
      DailyGratitudeCompletionData(
        id: id ?? this.id,
        date: date ?? this.date,
        morningCompleted: morningCompleted ?? this.morningCompleted,
        morningCompletedAt: morningCompletedAt.present
            ? morningCompletedAt.value
            : this.morningCompletedAt,
        eveningCompleted: eveningCompleted ?? this.eveningCompleted,
        eveningCompletedAt: eveningCompletedAt.present
            ? eveningCompletedAt.value
            : this.eveningCompletedAt,
      );
  @override
  String toString() {
    return (StringBuffer('DailyGratitudeCompletionData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('morningCompleted: $morningCompleted, ')
          ..write('morningCompletedAt: $morningCompletedAt, ')
          ..write('eveningCompleted: $eveningCompleted, ')
          ..write('eveningCompletedAt: $eveningCompletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, morningCompleted,
      morningCompletedAt, eveningCompleted, eveningCompletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyGratitudeCompletionData &&
          other.id == this.id &&
          other.date == this.date &&
          other.morningCompleted == this.morningCompleted &&
          other.morningCompletedAt == this.morningCompletedAt &&
          other.eveningCompleted == this.eveningCompleted &&
          other.eveningCompletedAt == this.eveningCompletedAt);
}

class DailyGratitudeCompletionsCompanion
    extends UpdateCompanion<DailyGratitudeCompletionData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<bool> morningCompleted;
  final Value<DateTime?> morningCompletedAt;
  final Value<bool> eveningCompleted;
  final Value<DateTime?> eveningCompletedAt;
  final Value<int> rowid;
  const DailyGratitudeCompletionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.morningCompleted = const Value.absent(),
    this.morningCompletedAt = const Value.absent(),
    this.eveningCompleted = const Value.absent(),
    this.eveningCompletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyGratitudeCompletionsCompanion.insert({
    required String id,
    required DateTime date,
    this.morningCompleted = const Value.absent(),
    this.morningCompletedAt = const Value.absent(),
    this.eveningCompleted = const Value.absent(),
    this.eveningCompletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date);
  static Insertable<DailyGratitudeCompletionData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<bool>? morningCompleted,
    Expression<DateTime>? morningCompletedAt,
    Expression<bool>? eveningCompleted,
    Expression<DateTime>? eveningCompletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (morningCompleted != null) 'morning_completed': morningCompleted,
      if (morningCompletedAt != null)
        'morning_completed_at': morningCompletedAt,
      if (eveningCompleted != null) 'evening_completed': eveningCompleted,
      if (eveningCompletedAt != null)
        'evening_completed_at': eveningCompletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyGratitudeCompletionsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<bool>? morningCompleted,
      Value<DateTime?>? morningCompletedAt,
      Value<bool>? eveningCompleted,
      Value<DateTime?>? eveningCompletedAt,
      Value<int>? rowid}) {
    return DailyGratitudeCompletionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      morningCompleted: morningCompleted ?? this.morningCompleted,
      morningCompletedAt: morningCompletedAt ?? this.morningCompletedAt,
      eveningCompleted: eveningCompleted ?? this.eveningCompleted,
      eveningCompletedAt: eveningCompletedAt ?? this.eveningCompletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (morningCompleted.present) {
      map['morning_completed'] = Variable<bool>(morningCompleted.value);
    }
    if (morningCompletedAt.present) {
      map['morning_completed_at'] =
          Variable<DateTime>(morningCompletedAt.value);
    }
    if (eveningCompleted.present) {
      map['evening_completed'] = Variable<bool>(eveningCompleted.value);
    }
    if (eveningCompletedAt.present) {
      map['evening_completed_at'] =
          Variable<DateTime>(eveningCompletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyGratitudeCompletionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('morningCompleted: $morningCompleted, ')
          ..write('morningCompletedAt: $morningCompletedAt, ')
          ..write('eveningCompleted: $eveningCompleted, ')
          ..write('eveningCompletedAt: $eveningCompletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhysicalActivitiesTable extends PhysicalActivities
    with TableInfo<$PhysicalActivitiesTable, PhysicalActivityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhysicalActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activityTypeMeta =
      const VerificationMeta('activityType');
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
      'activity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customNameMeta =
      const VerificationMeta('customName');
  @override
  late final GeneratedColumn<String> customName = GeneratedColumn<String>(
      'custom_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _metricTypeMeta =
      const VerificationMeta('metricType');
  @override
  late final GeneratedColumn<String> metricType = GeneratedColumn<String>(
      'metric_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetValueMeta =
      const VerificationMeta('targetValue');
  @override
  late final GeneratedColumn<int> targetValue = GeneratedColumn<int>(
      'target_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        activityType,
        customName,
        metricType,
        targetValue,
        createdAt,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'physical_activities';
  @override
  VerificationContext validateIntegrity(
      Insertable<PhysicalActivityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('activity_type')) {
      context.handle(
          _activityTypeMeta,
          activityType.isAcceptableOrUnknown(
              data['activity_type']!, _activityTypeMeta));
    } else if (isInserting) {
      context.missing(_activityTypeMeta);
    }
    if (data.containsKey('custom_name')) {
      context.handle(
          _customNameMeta,
          customName.isAcceptableOrUnknown(
              data['custom_name']!, _customNameMeta));
    }
    if (data.containsKey('metric_type')) {
      context.handle(
          _metricTypeMeta,
          metricType.isAcceptableOrUnknown(
              data['metric_type']!, _metricTypeMeta));
    } else if (isInserting) {
      context.missing(_metricTypeMeta);
    }
    if (data.containsKey('target_value')) {
      context.handle(
          _targetValueMeta,
          targetValue.isAcceptableOrUnknown(
              data['target_value']!, _targetValueMeta));
    } else if (isInserting) {
      context.missing(_targetValueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhysicalActivityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhysicalActivityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      activityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity_type'])!,
      customName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}custom_name']),
      metricType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metric_type'])!,
      targetValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_value'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $PhysicalActivitiesTable createAlias(String alias) {
    return $PhysicalActivitiesTable(attachedDatabase, alias);
  }
}

class PhysicalActivityData extends DataClass
    implements Insertable<PhysicalActivityData> {
  /// Unique identifier (UUID string)
  final String id;

  /// Canonical activity type key ('walking', 'running', 'cycling', etc.)
  final String activityType;

  /// Optional custom title or display name
  final String? customName;

  /// Target metric type ('duration' | 'repetitions')
  final String metricType;

  /// Target value (e.g. 30 for 30 minutes, 50 for 50 reps)
  final int targetValue;

  /// Creation timestamp
  final DateTime createdAt;

  /// Whether this activity is active in the daily routine
  final bool isActive;
  const PhysicalActivityData(
      {required this.id,
      required this.activityType,
      this.customName,
      required this.metricType,
      required this.targetValue,
      required this.createdAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['activity_type'] = Variable<String>(activityType);
    if (!nullToAbsent || customName != null) {
      map['custom_name'] = Variable<String>(customName);
    }
    map['metric_type'] = Variable<String>(metricType);
    map['target_value'] = Variable<int>(targetValue);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  PhysicalActivitiesCompanion toCompanion(bool nullToAbsent) {
    return PhysicalActivitiesCompanion(
      id: Value(id),
      activityType: Value(activityType),
      customName: customName == null && nullToAbsent
          ? const Value.absent()
          : Value(customName),
      metricType: Value(metricType),
      targetValue: Value(targetValue),
      createdAt: Value(createdAt),
      isActive: Value(isActive),
    );
  }

  factory PhysicalActivityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhysicalActivityData(
      id: serializer.fromJson<String>(json['id']),
      activityType: serializer.fromJson<String>(json['activityType']),
      customName: serializer.fromJson<String?>(json['customName']),
      metricType: serializer.fromJson<String>(json['metricType']),
      targetValue: serializer.fromJson<int>(json['targetValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'activityType': serializer.toJson<String>(activityType),
      'customName': serializer.toJson<String?>(customName),
      'metricType': serializer.toJson<String>(metricType),
      'targetValue': serializer.toJson<int>(targetValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  PhysicalActivityData copyWith(
          {String? id,
          String? activityType,
          Value<String?> customName = const Value.absent(),
          String? metricType,
          int? targetValue,
          DateTime? createdAt,
          bool? isActive}) =>
      PhysicalActivityData(
        id: id ?? this.id,
        activityType: activityType ?? this.activityType,
        customName: customName.present ? customName.value : this.customName,
        metricType: metricType ?? this.metricType,
        targetValue: targetValue ?? this.targetValue,
        createdAt: createdAt ?? this.createdAt,
        isActive: isActive ?? this.isActive,
      );
  @override
  String toString() {
    return (StringBuffer('PhysicalActivityData(')
          ..write('id: $id, ')
          ..write('activityType: $activityType, ')
          ..write('customName: $customName, ')
          ..write('metricType: $metricType, ')
          ..write('targetValue: $targetValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, activityType, customName, metricType,
      targetValue, createdAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhysicalActivityData &&
          other.id == this.id &&
          other.activityType == this.activityType &&
          other.customName == this.customName &&
          other.metricType == this.metricType &&
          other.targetValue == this.targetValue &&
          other.createdAt == this.createdAt &&
          other.isActive == this.isActive);
}

class PhysicalActivitiesCompanion
    extends UpdateCompanion<PhysicalActivityData> {
  final Value<String> id;
  final Value<String> activityType;
  final Value<String?> customName;
  final Value<String> metricType;
  final Value<int> targetValue;
  final Value<DateTime> createdAt;
  final Value<bool> isActive;
  final Value<int> rowid;
  const PhysicalActivitiesCompanion({
    this.id = const Value.absent(),
    this.activityType = const Value.absent(),
    this.customName = const Value.absent(),
    this.metricType = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhysicalActivitiesCompanion.insert({
    required String id,
    required String activityType,
    this.customName = const Value.absent(),
    required String metricType,
    required int targetValue,
    required DateTime createdAt,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        activityType = Value(activityType),
        metricType = Value(metricType),
        targetValue = Value(targetValue),
        createdAt = Value(createdAt);
  static Insertable<PhysicalActivityData> custom({
    Expression<String>? id,
    Expression<String>? activityType,
    Expression<String>? customName,
    Expression<String>? metricType,
    Expression<int>? targetValue,
    Expression<DateTime>? createdAt,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activityType != null) 'activity_type': activityType,
      if (customName != null) 'custom_name': customName,
      if (metricType != null) 'metric_type': metricType,
      if (targetValue != null) 'target_value': targetValue,
      if (createdAt != null) 'created_at': createdAt,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhysicalActivitiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? activityType,
      Value<String?>? customName,
      Value<String>? metricType,
      Value<int>? targetValue,
      Value<DateTime>? createdAt,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return PhysicalActivitiesCompanion(
      id: id ?? this.id,
      activityType: activityType ?? this.activityType,
      customName: customName ?? this.customName,
      metricType: metricType ?? this.metricType,
      targetValue: targetValue ?? this.targetValue,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (customName.present) {
      map['custom_name'] = Variable<String>(customName.value);
    }
    if (metricType.present) {
      map['metric_type'] = Variable<String>(metricType.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<int>(targetValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhysicalActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('activityType: $activityType, ')
          ..write('customName: $customName, ')
          ..write('metricType: $metricType, ')
          ..write('targetValue: $targetValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyActivitiesCompletionsTable extends DailyActivitiesCompletions
    with
        TableInfo<$DailyActivitiesCompletionsTable,
            DailyActivityCompletionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyActivitiesCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activityIdMeta =
      const VerificationMeta('activityId');
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
      'activity_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES physical_activities (id) ON DELETE CASCADE'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, activityId, date, completed, completedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_activities_completions';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailyActivityCompletionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('activity_id')) {
      context.handle(
          _activityIdMeta,
          activityId.isAcceptableOrUnknown(
              data['activity_id']!, _activityIdMeta));
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyActivityCompletionData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyActivityCompletionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      activityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $DailyActivitiesCompletionsTable createAlias(String alias) {
    return $DailyActivitiesCompletionsTable(attachedDatabase, alias);
  }
}

class DailyActivityCompletionData extends DataClass
    implements Insertable<DailyActivityCompletionData> {
  /// Unique identifier (UUID string)
  final String id;

  /// Activity ID referencing physical_activities(id)
  final String activityId;

  /// Calendar date of the completion (normalized to midnight)
  final DateTime date;

  /// Whether the activity was completed on this date
  final bool completed;

  /// Timestamp when marked as completed
  final DateTime? completedAt;
  const DailyActivityCompletionData(
      {required this.id,
      required this.activityId,
      required this.date,
      required this.completed,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['activity_id'] = Variable<String>(activityId);
    map['date'] = Variable<DateTime>(date);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  DailyActivitiesCompletionsCompanion toCompanion(bool nullToAbsent) {
    return DailyActivitiesCompletionsCompanion(
      id: Value(id),
      activityId: Value(activityId),
      date: Value(date),
      completed: Value(completed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory DailyActivityCompletionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyActivityCompletionData(
      id: serializer.fromJson<String>(json['id']),
      activityId: serializer.fromJson<String>(json['activityId']),
      date: serializer.fromJson<DateTime>(json['date']),
      completed: serializer.fromJson<bool>(json['completed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'activityId': serializer.toJson<String>(activityId),
      'date': serializer.toJson<DateTime>(date),
      'completed': serializer.toJson<bool>(completed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  DailyActivityCompletionData copyWith(
          {String? id,
          String? activityId,
          DateTime? date,
          bool? completed,
          Value<DateTime?> completedAt = const Value.absent()}) =>
      DailyActivityCompletionData(
        id: id ?? this.id,
        activityId: activityId ?? this.activityId,
        date: date ?? this.date,
        completed: completed ?? this.completed,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  @override
  String toString() {
    return (StringBuffer('DailyActivityCompletionData(')
          ..write('id: $id, ')
          ..write('activityId: $activityId, ')
          ..write('date: $date, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, activityId, date, completed, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyActivityCompletionData &&
          other.id == this.id &&
          other.activityId == this.activityId &&
          other.date == this.date &&
          other.completed == this.completed &&
          other.completedAt == this.completedAt);
}

class DailyActivitiesCompletionsCompanion
    extends UpdateCompanion<DailyActivityCompletionData> {
  final Value<String> id;
  final Value<String> activityId;
  final Value<DateTime> date;
  final Value<bool> completed;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const DailyActivitiesCompletionsCompanion({
    this.id = const Value.absent(),
    this.activityId = const Value.absent(),
    this.date = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyActivitiesCompletionsCompanion.insert({
    required String id,
    required String activityId,
    required DateTime date,
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        activityId = Value(activityId),
        date = Value(date);
  static Insertable<DailyActivityCompletionData> custom({
    Expression<String>? id,
    Expression<String>? activityId,
    Expression<DateTime>? date,
    Expression<bool>? completed,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activityId != null) 'activity_id': activityId,
      if (date != null) 'date': date,
      if (completed != null) 'completed': completed,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyActivitiesCompletionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? activityId,
      Value<DateTime>? date,
      Value<bool>? completed,
      Value<DateTime?>? completedAt,
      Value<int>? rowid}) {
    return DailyActivitiesCompletionsCompanion(
      id: id ?? this.id,
      activityId: activityId ?? this.activityId,
      date: date ?? this.date,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyActivitiesCompletionsCompanion(')
          ..write('id: $id, ')
          ..write('activityId: $activityId, ')
          ..write('date: $date, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutGroupsTable extends WorkoutGroups
    with TableInfo<$WorkoutGroupsTable, WorkoutGroupData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, createdAt, isActive, orderIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_groups';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutGroupData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutGroupData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutGroupData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $WorkoutGroupsTable createAlias(String alias) {
    return $WorkoutGroupsTable(attachedDatabase, alias);
  }
}

class WorkoutGroupData extends DataClass
    implements Insertable<WorkoutGroupData> {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final bool isActive;
  final int orderIndex;
  const WorkoutGroupData(
      {required this.id,
      required this.name,
      this.description,
      required this.createdAt,
      required this.isActive,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_active'] = Variable<bool>(isActive);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  WorkoutGroupsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutGroupsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      isActive: Value(isActive),
      orderIndex: Value(orderIndex),
    );
  }

  factory WorkoutGroupData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutGroupData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isActive': serializer.toJson<bool>(isActive),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  WorkoutGroupData copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          bool? isActive,
          int? orderIndex}) =>
      WorkoutGroupData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        isActive: isActive ?? this.isActive,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  @override
  String toString() {
    return (StringBuffer('WorkoutGroupData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('isActive: $isActive, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, createdAt, isActive, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutGroupData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.isActive == this.isActive &&
          other.orderIndex == this.orderIndex);
}

class WorkoutGroupsCompanion extends UpdateCompanion<WorkoutGroupData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<bool> isActive;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const WorkoutGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutGroupsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required DateTime createdAt,
    this.isActive = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<WorkoutGroupData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<bool>? isActive,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (isActive != null) 'is_active': isActive,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutGroupsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<bool>? isActive,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return WorkoutGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('isActive: $isActive, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutRoutinesTable extends WorkoutRoutines
    with TableInfo<$WorkoutRoutinesTable, WorkoutRoutineData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutRoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workout_groups (id) ON DELETE CASCADE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, groupId, name, description, createdAt, orderIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_routines';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutRoutineData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutRoutineData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutRoutineData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $WorkoutRoutinesTable createAlias(String alias) {
    return $WorkoutRoutinesTable(attachedDatabase, alias);
  }
}

class WorkoutRoutineData extends DataClass
    implements Insertable<WorkoutRoutineData> {
  final String id;
  final String groupId;
  final String name;
  final String? description;
  final DateTime createdAt;
  final int orderIndex;
  const WorkoutRoutineData(
      {required this.id,
      required this.groupId,
      required this.name,
      this.description,
      required this.createdAt,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  WorkoutRoutinesCompanion toCompanion(bool nullToAbsent) {
    return WorkoutRoutinesCompanion(
      id: Value(id),
      groupId: Value(groupId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      orderIndex: Value(orderIndex),
    );
  }

  factory WorkoutRoutineData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutRoutineData(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  WorkoutRoutineData copyWith(
          {String? id,
          String? groupId,
          String? name,
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          int? orderIndex}) =>
      WorkoutRoutineData(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  @override
  String toString() {
    return (StringBuffer('WorkoutRoutineData(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, groupId, name, description, createdAt, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutRoutineData &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.orderIndex == this.orderIndex);
}

class WorkoutRoutinesCompanion extends UpdateCompanion<WorkoutRoutineData> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const WorkoutRoutinesCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutRoutinesCompanion.insert({
    required String id,
    required String groupId,
    required String name,
    this.description = const Value.absent(),
    required DateTime createdAt,
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupId = Value(groupId),
        name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<WorkoutRoutineData> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutRoutinesCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return WorkoutRoutinesCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutRoutinesCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrainingExercisesTable extends TrainingExercises
    with TableInfo<$TrainingExercisesTable, TrainingExerciseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _routineIdMeta =
      const VerificationMeta('routineId');
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
      'routine_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workout_routines (id) ON DELETE CASCADE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activityTypeMeta =
      const VerificationMeta('activityType');
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
      'activity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetSetsMeta =
      const VerificationMeta('targetSets');
  @override
  late final GeneratedColumn<int> targetSets = GeneratedColumn<int>(
      'target_sets', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _targetDurationSecondsMeta =
      const VerificationMeta('targetDurationSeconds');
  @override
  late final GeneratedColumn<int> targetDurationSeconds = GeneratedColumn<int>(
      'target_duration_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _targetRepetitionsMeta =
      const VerificationMeta('targetRepetitions');
  @override
  late final GeneratedColumn<int> targetRepetitions = GeneratedColumn<int>(
      'target_repetitions', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _targetWeightKgMeta =
      const VerificationMeta('targetWeightKg');
  @override
  late final GeneratedColumn<double> targetWeightKg = GeneratedColumn<double>(
      'target_weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        routineId,
        name,
        activityType,
        targetSets,
        targetDurationSeconds,
        targetRepetitions,
        targetWeightKg,
        orderIndex
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training_exercises';
  @override
  VerificationContext validateIntegrity(
      Insertable<TrainingExerciseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(_routineIdMeta,
          routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta));
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('activity_type')) {
      context.handle(
          _activityTypeMeta,
          activityType.isAcceptableOrUnknown(
              data['activity_type']!, _activityTypeMeta));
    } else if (isInserting) {
      context.missing(_activityTypeMeta);
    }
    if (data.containsKey('target_sets')) {
      context.handle(
          _targetSetsMeta,
          targetSets.isAcceptableOrUnknown(
              data['target_sets']!, _targetSetsMeta));
    }
    if (data.containsKey('target_duration_seconds')) {
      context.handle(
          _targetDurationSecondsMeta,
          targetDurationSeconds.isAcceptableOrUnknown(
              data['target_duration_seconds']!, _targetDurationSecondsMeta));
    }
    if (data.containsKey('target_repetitions')) {
      context.handle(
          _targetRepetitionsMeta,
          targetRepetitions.isAcceptableOrUnknown(
              data['target_repetitions']!, _targetRepetitionsMeta));
    }
    if (data.containsKey('target_weight_kg')) {
      context.handle(
          _targetWeightKgMeta,
          targetWeightKg.isAcceptableOrUnknown(
              data['target_weight_kg']!, _targetWeightKgMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrainingExerciseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingExerciseData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      routineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}routine_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      activityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity_type'])!,
      targetSets: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_sets'])!,
      targetDurationSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}target_duration_seconds']),
      targetRepetitions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_repetitions']),
      targetWeightKg: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}target_weight_kg']),
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $TrainingExercisesTable createAlias(String alias) {
    return $TrainingExercisesTable(attachedDatabase, alias);
  }
}

class TrainingExerciseData extends DataClass
    implements Insertable<TrainingExerciseData> {
  final String id;
  final String routineId;
  final String name;
  final String activityType;
  final int targetSets;
  final int? targetDurationSeconds;
  final int? targetRepetitions;
  final double? targetWeightKg;
  final int orderIndex;
  const TrainingExerciseData(
      {required this.id,
      required this.routineId,
      required this.name,
      required this.activityType,
      required this.targetSets,
      this.targetDurationSeconds,
      this.targetRepetitions,
      this.targetWeightKg,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['name'] = Variable<String>(name);
    map['activity_type'] = Variable<String>(activityType);
    map['target_sets'] = Variable<int>(targetSets);
    if (!nullToAbsent || targetDurationSeconds != null) {
      map['target_duration_seconds'] = Variable<int>(targetDurationSeconds);
    }
    if (!nullToAbsent || targetRepetitions != null) {
      map['target_repetitions'] = Variable<int>(targetRepetitions);
    }
    if (!nullToAbsent || targetWeightKg != null) {
      map['target_weight_kg'] = Variable<double>(targetWeightKg);
    }
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  TrainingExercisesCompanion toCompanion(bool nullToAbsent) {
    return TrainingExercisesCompanion(
      id: Value(id),
      routineId: Value(routineId),
      name: Value(name),
      activityType: Value(activityType),
      targetSets: Value(targetSets),
      targetDurationSeconds: targetDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDurationSeconds),
      targetRepetitions: targetRepetitions == null && nullToAbsent
          ? const Value.absent()
          : Value(targetRepetitions),
      targetWeightKg: targetWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(targetWeightKg),
      orderIndex: Value(orderIndex),
    );
  }

  factory TrainingExerciseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingExerciseData(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      name: serializer.fromJson<String>(json['name']),
      activityType: serializer.fromJson<String>(json['activityType']),
      targetSets: serializer.fromJson<int>(json['targetSets']),
      targetDurationSeconds:
          serializer.fromJson<int?>(json['targetDurationSeconds']),
      targetRepetitions: serializer.fromJson<int?>(json['targetRepetitions']),
      targetWeightKg: serializer.fromJson<double?>(json['targetWeightKg']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'name': serializer.toJson<String>(name),
      'activityType': serializer.toJson<String>(activityType),
      'targetSets': serializer.toJson<int>(targetSets),
      'targetDurationSeconds': serializer.toJson<int?>(targetDurationSeconds),
      'targetRepetitions': serializer.toJson<int?>(targetRepetitions),
      'targetWeightKg': serializer.toJson<double?>(targetWeightKg),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  TrainingExerciseData copyWith(
          {String? id,
          String? routineId,
          String? name,
          String? activityType,
          int? targetSets,
          Value<int?> targetDurationSeconds = const Value.absent(),
          Value<int?> targetRepetitions = const Value.absent(),
          Value<double?> targetWeightKg = const Value.absent(),
          int? orderIndex}) =>
      TrainingExerciseData(
        id: id ?? this.id,
        routineId: routineId ?? this.routineId,
        name: name ?? this.name,
        activityType: activityType ?? this.activityType,
        targetSets: targetSets ?? this.targetSets,
        targetDurationSeconds: targetDurationSeconds.present
            ? targetDurationSeconds.value
            : this.targetDurationSeconds,
        targetRepetitions: targetRepetitions.present
            ? targetRepetitions.value
            : this.targetRepetitions,
        targetWeightKg:
            targetWeightKg.present ? targetWeightKg.value : this.targetWeightKg,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  @override
  String toString() {
    return (StringBuffer('TrainingExerciseData(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('name: $name, ')
          ..write('activityType: $activityType, ')
          ..write('targetSets: $targetSets, ')
          ..write('targetDurationSeconds: $targetDurationSeconds, ')
          ..write('targetRepetitions: $targetRepetitions, ')
          ..write('targetWeightKg: $targetWeightKg, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineId, name, activityType, targetSets,
      targetDurationSeconds, targetRepetitions, targetWeightKg, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingExerciseData &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.name == this.name &&
          other.activityType == this.activityType &&
          other.targetSets == this.targetSets &&
          other.targetDurationSeconds == this.targetDurationSeconds &&
          other.targetRepetitions == this.targetRepetitions &&
          other.targetWeightKg == this.targetWeightKg &&
          other.orderIndex == this.orderIndex);
}

class TrainingExercisesCompanion extends UpdateCompanion<TrainingExerciseData> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<String> name;
  final Value<String> activityType;
  final Value<int> targetSets;
  final Value<int?> targetDurationSeconds;
  final Value<int?> targetRepetitions;
  final Value<double?> targetWeightKg;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const TrainingExercisesCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.name = const Value.absent(),
    this.activityType = const Value.absent(),
    this.targetSets = const Value.absent(),
    this.targetDurationSeconds = const Value.absent(),
    this.targetRepetitions = const Value.absent(),
    this.targetWeightKg = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrainingExercisesCompanion.insert({
    required String id,
    required String routineId,
    required String name,
    required String activityType,
    this.targetSets = const Value.absent(),
    this.targetDurationSeconds = const Value.absent(),
    this.targetRepetitions = const Value.absent(),
    this.targetWeightKg = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        routineId = Value(routineId),
        name = Value(name),
        activityType = Value(activityType);
  static Insertable<TrainingExerciseData> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? name,
    Expression<String>? activityType,
    Expression<int>? targetSets,
    Expression<int>? targetDurationSeconds,
    Expression<int>? targetRepetitions,
    Expression<double>? targetWeightKg,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (name != null) 'name': name,
      if (activityType != null) 'activity_type': activityType,
      if (targetSets != null) 'target_sets': targetSets,
      if (targetDurationSeconds != null)
        'target_duration_seconds': targetDurationSeconds,
      if (targetRepetitions != null) 'target_repetitions': targetRepetitions,
      if (targetWeightKg != null) 'target_weight_kg': targetWeightKg,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrainingExercisesCompanion copyWith(
      {Value<String>? id,
      Value<String>? routineId,
      Value<String>? name,
      Value<String>? activityType,
      Value<int>? targetSets,
      Value<int?>? targetDurationSeconds,
      Value<int?>? targetRepetitions,
      Value<double?>? targetWeightKg,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return TrainingExercisesCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      name: name ?? this.name,
      activityType: activityType ?? this.activityType,
      targetSets: targetSets ?? this.targetSets,
      targetDurationSeconds:
          targetDurationSeconds ?? this.targetDurationSeconds,
      targetRepetitions: targetRepetitions ?? this.targetRepetitions,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (targetSets.present) {
      map['target_sets'] = Variable<int>(targetSets.value);
    }
    if (targetDurationSeconds.present) {
      map['target_duration_seconds'] =
          Variable<int>(targetDurationSeconds.value);
    }
    if (targetRepetitions.present) {
      map['target_repetitions'] = Variable<int>(targetRepetitions.value);
    }
    if (targetWeightKg.present) {
      map['target_weight_kg'] = Variable<double>(targetWeightKg.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingExercisesCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('name: $name, ')
          ..write('activityType: $activityType, ')
          ..write('targetSets: $targetSets, ')
          ..write('targetDurationSeconds: $targetDurationSeconds, ')
          ..write('targetRepetitions: $targetRepetitions, ')
          ..write('targetWeightKg: $targetWeightKg, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyTrainingSessionsTable extends DailyTrainingSessions
    with TableInfo<$DailyTrainingSessionsTable, DailyTrainingSessionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyTrainingSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _routineIdMeta =
      const VerificationMeta('routineId');
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
      'routine_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _routineNameMeta =
      const VerificationMeta('routineName');
  @override
  late final GeneratedColumn<String> routineName = GeneratedColumn<String>(
      'routine_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'group_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _concludedAtMeta =
      const VerificationMeta('concludedAt');
  @override
  late final GeneratedColumn<DateTime> concludedAt = GeneratedColumn<DateTime>(
      'concluded_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('in_progress'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        routineId,
        routineName,
        groupName,
        date,
        startedAt,
        concludedAt,
        status
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_training_sessions';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailyTrainingSessionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(_routineIdMeta,
          routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta));
    }
    if (data.containsKey('routine_name')) {
      context.handle(
          _routineNameMeta,
          routineName.isAcceptableOrUnknown(
              data['routine_name']!, _routineNameMeta));
    } else if (isInserting) {
      context.missing(_routineNameMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('concluded_at')) {
      context.handle(
          _concludedAtMeta,
          concludedAt.isAcceptableOrUnknown(
              data['concluded_at']!, _concludedAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyTrainingSessionData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyTrainingSessionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      routineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}routine_id']),
      routineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}routine_name'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_name']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      concludedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}concluded_at']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $DailyTrainingSessionsTable createAlias(String alias) {
    return $DailyTrainingSessionsTable(attachedDatabase, alias);
  }
}

class DailyTrainingSessionData extends DataClass
    implements Insertable<DailyTrainingSessionData> {
  final String id;
  final String? routineId;
  final String routineName;
  final String? groupName;
  final DateTime date;
  final DateTime startedAt;
  final DateTime? concludedAt;
  final String status;
  const DailyTrainingSessionData(
      {required this.id,
      this.routineId,
      required this.routineName,
      this.groupName,
      required this.date,
      required this.startedAt,
      this.concludedAt,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || routineId != null) {
      map['routine_id'] = Variable<String>(routineId);
    }
    map['routine_name'] = Variable<String>(routineName);
    if (!nullToAbsent || groupName != null) {
      map['group_name'] = Variable<String>(groupName);
    }
    map['date'] = Variable<DateTime>(date);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || concludedAt != null) {
      map['concluded_at'] = Variable<DateTime>(concludedAt);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  DailyTrainingSessionsCompanion toCompanion(bool nullToAbsent) {
    return DailyTrainingSessionsCompanion(
      id: Value(id),
      routineId: routineId == null && nullToAbsent
          ? const Value.absent()
          : Value(routineId),
      routineName: Value(routineName),
      groupName: groupName == null && nullToAbsent
          ? const Value.absent()
          : Value(groupName),
      date: Value(date),
      startedAt: Value(startedAt),
      concludedAt: concludedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(concludedAt),
      status: Value(status),
    );
  }

  factory DailyTrainingSessionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyTrainingSessionData(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String?>(json['routineId']),
      routineName: serializer.fromJson<String>(json['routineName']),
      groupName: serializer.fromJson<String?>(json['groupName']),
      date: serializer.fromJson<DateTime>(json['date']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      concludedAt: serializer.fromJson<DateTime?>(json['concludedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String?>(routineId),
      'routineName': serializer.toJson<String>(routineName),
      'groupName': serializer.toJson<String?>(groupName),
      'date': serializer.toJson<DateTime>(date),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'concludedAt': serializer.toJson<DateTime?>(concludedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  DailyTrainingSessionData copyWith(
          {String? id,
          Value<String?> routineId = const Value.absent(),
          String? routineName,
          Value<String?> groupName = const Value.absent(),
          DateTime? date,
          DateTime? startedAt,
          Value<DateTime?> concludedAt = const Value.absent(),
          String? status}) =>
      DailyTrainingSessionData(
        id: id ?? this.id,
        routineId: routineId.present ? routineId.value : this.routineId,
        routineName: routineName ?? this.routineName,
        groupName: groupName.present ? groupName.value : this.groupName,
        date: date ?? this.date,
        startedAt: startedAt ?? this.startedAt,
        concludedAt: concludedAt.present ? concludedAt.value : this.concludedAt,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('DailyTrainingSessionData(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('routineName: $routineName, ')
          ..write('groupName: $groupName, ')
          ..write('date: $date, ')
          ..write('startedAt: $startedAt, ')
          ..write('concludedAt: $concludedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routineId, routineName, groupName, date,
      startedAt, concludedAt, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyTrainingSessionData &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.routineName == this.routineName &&
          other.groupName == this.groupName &&
          other.date == this.date &&
          other.startedAt == this.startedAt &&
          other.concludedAt == this.concludedAt &&
          other.status == this.status);
}

class DailyTrainingSessionsCompanion
    extends UpdateCompanion<DailyTrainingSessionData> {
  final Value<String> id;
  final Value<String?> routineId;
  final Value<String> routineName;
  final Value<String?> groupName;
  final Value<DateTime> date;
  final Value<DateTime> startedAt;
  final Value<DateTime?> concludedAt;
  final Value<String> status;
  final Value<int> rowid;
  const DailyTrainingSessionsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.routineName = const Value.absent(),
    this.groupName = const Value.absent(),
    this.date = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.concludedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyTrainingSessionsCompanion.insert({
    required String id,
    this.routineId = const Value.absent(),
    required String routineName,
    this.groupName = const Value.absent(),
    required DateTime date,
    required DateTime startedAt,
    this.concludedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        routineName = Value(routineName),
        date = Value(date),
        startedAt = Value(startedAt);
  static Insertable<DailyTrainingSessionData> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? routineName,
    Expression<String>? groupName,
    Expression<DateTime>? date,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? concludedAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (routineName != null) 'routine_name': routineName,
      if (groupName != null) 'group_name': groupName,
      if (date != null) 'date': date,
      if (startedAt != null) 'started_at': startedAt,
      if (concludedAt != null) 'concluded_at': concludedAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyTrainingSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? routineId,
      Value<String>? routineName,
      Value<String?>? groupName,
      Value<DateTime>? date,
      Value<DateTime>? startedAt,
      Value<DateTime?>? concludedAt,
      Value<String>? status,
      Value<int>? rowid}) {
    return DailyTrainingSessionsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      routineName: routineName ?? this.routineName,
      groupName: groupName ?? this.groupName,
      date: date ?? this.date,
      startedAt: startedAt ?? this.startedAt,
      concludedAt: concludedAt ?? this.concludedAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (routineName.present) {
      map['routine_name'] = Variable<String>(routineName.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (concludedAt.present) {
      map['concluded_at'] = Variable<DateTime>(concludedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyTrainingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('routineName: $routineName, ')
          ..write('groupName: $groupName, ')
          ..write('date: $date, ')
          ..write('startedAt: $startedAt, ')
          ..write('concludedAt: $concludedAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyTrainingRecordsTable extends DailyTrainingRecords
    with TableInfo<$DailyTrainingRecordsTable, DailyTrainingRecordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyTrainingRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES daily_training_sessions (id) ON DELETE CASCADE'));
  static const VerificationMeta _exerciseNameMeta =
      const VerificationMeta('exerciseName');
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
      'exercise_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _activityTypeMeta =
      const VerificationMeta('activityType');
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
      'activity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
      'sets', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _repetitionsMeta =
      const VerificationMeta('repetitions');
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
      'repetitions', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionId,
        exerciseName,
        activityType,
        sets,
        durationSeconds,
        repetitions,
        weightKg,
        isCompleted,
        orderIndex
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_training_records';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailyTrainingRecordData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
          _exerciseNameMeta,
          exerciseName.isAcceptableOrUnknown(
              data['exercise_name']!, _exerciseNameMeta));
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    if (data.containsKey('activity_type')) {
      context.handle(
          _activityTypeMeta,
          activityType.isAcceptableOrUnknown(
              data['activity_type']!, _activityTypeMeta));
    } else if (isInserting) {
      context.missing(_activityTypeMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
          _setsMeta, sets.isAcceptableOrUnknown(data['sets']!, _setsMeta));
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    }
    if (data.containsKey('repetitions')) {
      context.handle(
          _repetitionsMeta,
          repetitions.isAcceptableOrUnknown(
              data['repetitions']!, _repetitionsMeta));
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyTrainingRecordData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyTrainingRecordData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      exerciseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_name'])!,
      activityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity_type'])!,
      sets: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sets']),
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds']),
      repetitions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repetitions']),
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $DailyTrainingRecordsTable createAlias(String alias) {
    return $DailyTrainingRecordsTable(attachedDatabase, alias);
  }
}

class DailyTrainingRecordData extends DataClass
    implements Insertable<DailyTrainingRecordData> {
  final String id;
  final String sessionId;
  final String exerciseName;
  final String activityType;
  final int? sets;
  final int? durationSeconds;
  final int? repetitions;
  final double? weightKg;
  final bool isCompleted;
  final int orderIndex;
  const DailyTrainingRecordData(
      {required this.id,
      required this.sessionId,
      required this.exerciseName,
      required this.activityType,
      this.sets,
      this.durationSeconds,
      this.repetitions,
      this.weightKg,
      required this.isCompleted,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['exercise_name'] = Variable<String>(exerciseName);
    map['activity_type'] = Variable<String>(activityType);
    if (!nullToAbsent || sets != null) {
      map['sets'] = Variable<int>(sets);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || repetitions != null) {
      map['repetitions'] = Variable<int>(repetitions);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  DailyTrainingRecordsCompanion toCompanion(bool nullToAbsent) {
    return DailyTrainingRecordsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseName: Value(exerciseName),
      activityType: Value(activityType),
      sets: sets == null && nullToAbsent ? const Value.absent() : Value(sets),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      repetitions: repetitions == null && nullToAbsent
          ? const Value.absent()
          : Value(repetitions),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      isCompleted: Value(isCompleted),
      orderIndex: Value(orderIndex),
    );
  }

  factory DailyTrainingRecordData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyTrainingRecordData(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
      activityType: serializer.fromJson<String>(json['activityType']),
      sets: serializer.fromJson<int?>(json['sets']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      repetitions: serializer.fromJson<int?>(json['repetitions']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'exerciseName': serializer.toJson<String>(exerciseName),
      'activityType': serializer.toJson<String>(activityType),
      'sets': serializer.toJson<int?>(sets),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'repetitions': serializer.toJson<int?>(repetitions),
      'weightKg': serializer.toJson<double?>(weightKg),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  DailyTrainingRecordData copyWith(
          {String? id,
          String? sessionId,
          String? exerciseName,
          String? activityType,
          Value<int?> sets = const Value.absent(),
          Value<int?> durationSeconds = const Value.absent(),
          Value<int?> repetitions = const Value.absent(),
          Value<double?> weightKg = const Value.absent(),
          bool? isCompleted,
          int? orderIndex}) =>
      DailyTrainingRecordData(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        exerciseName: exerciseName ?? this.exerciseName,
        activityType: activityType ?? this.activityType,
        sets: sets.present ? sets.value : this.sets,
        durationSeconds: durationSeconds.present
            ? durationSeconds.value
            : this.durationSeconds,
        repetitions: repetitions.present ? repetitions.value : this.repetitions,
        weightKg: weightKg.present ? weightKg.value : this.weightKg,
        isCompleted: isCompleted ?? this.isCompleted,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  @override
  String toString() {
    return (StringBuffer('DailyTrainingRecordData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('activityType: $activityType, ')
          ..write('sets: $sets, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('repetitions: $repetitions, ')
          ..write('weightKg: $weightKg, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, exerciseName, activityType,
      sets, durationSeconds, repetitions, weightKg, isCompleted, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyTrainingRecordData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseName == this.exerciseName &&
          other.activityType == this.activityType &&
          other.sets == this.sets &&
          other.durationSeconds == this.durationSeconds &&
          other.repetitions == this.repetitions &&
          other.weightKg == this.weightKg &&
          other.isCompleted == this.isCompleted &&
          other.orderIndex == this.orderIndex);
}

class DailyTrainingRecordsCompanion
    extends UpdateCompanion<DailyTrainingRecordData> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> exerciseName;
  final Value<String> activityType;
  final Value<int?> sets;
  final Value<int?> durationSeconds;
  final Value<int?> repetitions;
  final Value<double?> weightKg;
  final Value<bool> isCompleted;
  final Value<int> orderIndex;
  final Value<int> rowid;
  const DailyTrainingRecordsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.activityType = const Value.absent(),
    this.sets = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyTrainingRecordsCompanion.insert({
    required String id,
    required String sessionId,
    required String exerciseName,
    required String activityType,
    this.sets = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        exerciseName = Value(exerciseName),
        activityType = Value(activityType);
  static Insertable<DailyTrainingRecordData> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? exerciseName,
    Expression<String>? activityType,
    Expression<int>? sets,
    Expression<int>? durationSeconds,
    Expression<int>? repetitions,
    Expression<double>? weightKg,
    Expression<bool>? isCompleted,
    Expression<int>? orderIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (activityType != null) 'activity_type': activityType,
      if (sets != null) 'sets': sets,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (repetitions != null) 'repetitions': repetitions,
      if (weightKg != null) 'weight_kg': weightKg,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (orderIndex != null) 'order_index': orderIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyTrainingRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String>? exerciseName,
      Value<String>? activityType,
      Value<int?>? sets,
      Value<int?>? durationSeconds,
      Value<int?>? repetitions,
      Value<double?>? weightKg,
      Value<bool>? isCompleted,
      Value<int>? orderIndex,
      Value<int>? rowid}) {
    return DailyTrainingRecordsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseName: exerciseName ?? this.exerciseName,
      activityType: activityType ?? this.activityType,
      sets: sets ?? this.sets,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      repetitions: repetitions ?? this.repetitions,
      weightKg: weightKg ?? this.weightKg,
      isCompleted: isCompleted ?? this.isCompleted,
      orderIndex: orderIndex ?? this.orderIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyTrainingRecordsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('activityType: $activityType, ')
          ..write('sets: $sets, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('repetitions: $repetitions, ')
          ..write('weightKg: $weightKg, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinancialTransactionsTable extends FinancialTransactions
    with TableInfo<$FinancialTransactionsTable, FinancialTransactionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currency_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('USD'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, amount, type, date, category, currencyCode, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_transactions';
  @override
  VerificationContext validateIntegrity(
      Insertable<FinancialTransactionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('currency_code')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currency_code']!, _currencyCodeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinancialTransactionData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialTransactionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_code'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FinancialTransactionsTable createAlias(String alias) {
    return $FinancialTransactionsTable(attachedDatabase, alias);
  }
}

class FinancialTransactionData extends DataClass
    implements Insertable<FinancialTransactionData> {
  /// Unique identifier (UUID string)
  final String id;

  /// Title or short description (e.g., 'Monthly Salary', 'Supermarket')
  final String title;

  /// Monetary amount (non-negative)
  final double amount;

  /// Transaction type ('income' or 'expense')
  final String type;

  /// Calendar date of the transaction
  final DateTime date;

  /// Category tag (e.g., 'salary', 'food', 'housing', etc.)
  final String? category;

  /// Currency code (e.g., 'USD', 'BRL', 'EUR')
  final String currencyCode;

  /// Timestamp when recorded
  final DateTime createdAt;
  const FinancialTransactionData(
      {required this.id,
      required this.title,
      required this.amount,
      required this.type,
      required this.date,
      this.category,
      required this.currencyCode,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['type'] = Variable<String>(type);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['currency_code'] = Variable<String>(currencyCode);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FinancialTransactionsCompanion toCompanion(bool nullToAbsent) {
    return FinancialTransactionsCompanion(
      id: Value(id),
      title: Value(title),
      amount: Value(amount),
      type: Value(type),
      date: Value(date),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      currencyCode: Value(currencyCode),
      createdAt: Value(createdAt),
    );
  }

  factory FinancialTransactionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialTransactionData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      type: serializer.fromJson<String>(json['type']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: serializer.fromJson<String?>(json['category']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'type': serializer.toJson<String>(type),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer.toJson<String?>(category),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FinancialTransactionData copyWith(
          {String? id,
          String? title,
          double? amount,
          String? type,
          DateTime? date,
          Value<String?> category = const Value.absent(),
          String? currencyCode,
          DateTime? createdAt}) =>
      FinancialTransactionData(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        date: date ?? this.date,
        category: category.present ? category.value : this.category,
        currencyCode: currencyCode ?? this.currencyCode,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('FinancialTransactionData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, amount, type, date, category, currencyCode, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialTransactionData &&
          other.id == this.id &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.type == this.type &&
          other.date == this.date &&
          other.category == this.category &&
          other.currencyCode == this.currencyCode &&
          other.createdAt == this.createdAt);
}

class FinancialTransactionsCompanion
    extends UpdateCompanion<FinancialTransactionData> {
  final Value<String> id;
  final Value<String> title;
  final Value<double> amount;
  final Value<String> type;
  final Value<DateTime> date;
  final Value<String?> category;
  final Value<String> currencyCode;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FinancialTransactionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.type = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialTransactionsCompanion.insert({
    required String id,
    required String title,
    required double amount,
    required String type,
    required DateTime date,
    this.category = const Value.absent(),
    this.currencyCode = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        amount = Value(amount),
        type = Value(type),
        date = Value(date),
        createdAt = Value(createdAt);
  static Insertable<FinancialTransactionData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<String>? type,
    Expression<DateTime>? date,
    Expression<String>? category,
    Expression<String>? currencyCode,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (type != null) 'type': type,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialTransactionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<double>? amount,
      Value<String>? type,
      Value<DateTime>? date,
      Value<String?>? category,
      Value<String>? currencyCode,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return FinancialTransactionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      category: category ?? this.category,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinancialCategoriesTable extends FinancialCategories
    with TableInfo<$FinancialCategoriesTable, FinancialCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCustomMeta =
      const VerificationMeta('isCustom');
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
      'is_custom', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_custom" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, isCustom, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_categories';
  @override
  VerificationContext validateIntegrity(
      Insertable<FinancialCategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_custom')) {
      context.handle(_isCustomMeta,
          isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinancialCategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialCategoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isCustom: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_custom'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FinancialCategoriesTable createAlias(String alias) {
    return $FinancialCategoriesTable(attachedDatabase, alias);
  }
}

class FinancialCategoryData extends DataClass
    implements Insertable<FinancialCategoryData> {
  /// Unique identifier (UUID string)
  final String id;

  /// Category name (e.g. 'Pet Care', 'Gym', 'Gifts')
  final String name;

  /// Whether this is a user-created custom category
  final bool isCustom;

  /// Timestamp when created
  final DateTime createdAt;
  const FinancialCategoryData(
      {required this.id,
      required this.name,
      required this.isCustom,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['is_custom'] = Variable<bool>(isCustom);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FinancialCategoriesCompanion toCompanion(bool nullToAbsent) {
    return FinancialCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      isCustom: Value(isCustom),
      createdAt: Value(createdAt),
    );
  }

  factory FinancialCategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialCategoryData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'isCustom': serializer.toJson<bool>(isCustom),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FinancialCategoryData copyWith(
          {String? id, String? name, bool? isCustom, DateTime? createdAt}) =>
      FinancialCategoryData(
        id: id ?? this.id,
        name: name ?? this.name,
        isCustom: isCustom ?? this.isCustom,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('FinancialCategoryData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isCustom, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialCategoryData &&
          other.id == this.id &&
          other.name == this.name &&
          other.isCustom == this.isCustom &&
          other.createdAt == this.createdAt);
}

class FinancialCategoriesCompanion
    extends UpdateCompanion<FinancialCategoryData> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> isCustom;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FinancialCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialCategoriesCompanion.insert({
    required String id,
    required String name,
    this.isCustom = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<FinancialCategoryData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<bool>? isCustom,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isCustom != null) 'is_custom': isCustom,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialCategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<bool>? isCustom,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return FinancialCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyCurrenciesTable extends MonthlyCurrencies
    with TableInfo<$MonthlyCurrenciesTable, MonthlyCurrencyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyCurrenciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currency_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [year, month, currencyCode, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_currencies';
  @override
  VerificationContext validateIntegrity(
      Insertable<MonthlyCurrencyData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currency_code']!, _currencyCodeMeta));
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {year, month, currencyCode};
  @override
  MonthlyCurrencyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyCurrencyData(
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_code'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MonthlyCurrenciesTable createAlias(String alias) {
    return $MonthlyCurrenciesTable(attachedDatabase, alias);
  }
}

class MonthlyCurrencyData extends DataClass
    implements Insertable<MonthlyCurrencyData> {
  /// Calendar year (e.g. 2026)
  final int year;

  /// Calendar month (1 to 12)
  final int month;

  /// Currency ISO code (e.g. 'USD', 'BRL', 'EUR')
  final String currencyCode;

  /// Timestamp when registered
  final DateTime createdAt;
  const MonthlyCurrencyData(
      {required this.year,
      required this.month,
      required this.currencyCode,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['currency_code'] = Variable<String>(currencyCode);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MonthlyCurrenciesCompanion toCompanion(bool nullToAbsent) {
    return MonthlyCurrenciesCompanion(
      year: Value(year),
      month: Value(month),
      currencyCode: Value(currencyCode),
      createdAt: Value(createdAt),
    );
  }

  factory MonthlyCurrencyData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyCurrencyData(
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MonthlyCurrencyData copyWith(
          {int? year, int? month, String? currencyCode, DateTime? createdAt}) =>
      MonthlyCurrencyData(
        year: year ?? this.year,
        month: month ?? this.month,
        currencyCode: currencyCode ?? this.currencyCode,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('MonthlyCurrencyData(')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(year, month, currencyCode, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyCurrencyData &&
          other.year == this.year &&
          other.month == this.month &&
          other.currencyCode == this.currencyCode &&
          other.createdAt == this.createdAt);
}

class MonthlyCurrenciesCompanion extends UpdateCompanion<MonthlyCurrencyData> {
  final Value<int> year;
  final Value<int> month;
  final Value<String> currencyCode;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MonthlyCurrenciesCompanion({
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyCurrenciesCompanion.insert({
    required int year,
    required int month,
    required String currencyCode,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : year = Value(year),
        month = Value(month),
        currencyCode = Value(currencyCode),
        createdAt = Value(createdAt);
  static Insertable<MonthlyCurrencyData> custom({
    Expression<int>? year,
    Expression<int>? month,
    Expression<String>? currencyCode,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyCurrenciesCompanion copyWith(
      {Value<int>? year,
      Value<int>? month,
      Value<String>? currencyCode,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return MonthlyCurrenciesCompanion(
      year: year ?? this.year,
      month: month ?? this.month,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyCurrenciesCompanion(')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserHabitsTable extends UserHabits
    with TableInfo<$UserHabitsTable, UserHabitData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserHabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _selectedAtMeta =
      const VerificationMeta('selectedAt');
  @override
  late final GeneratedColumn<DateTime> selectedAt = GeneratedColumn<DateTime>(
      'selected_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, selectedAt, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_habits';
  @override
  VerificationContext validateIntegrity(Insertable<UserHabitData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('selected_at')) {
      context.handle(
          _selectedAtMeta,
          selectedAt.isAcceptableOrUnknown(
              data['selected_at']!, _selectedAtMeta));
    } else if (isInserting) {
      context.missing(_selectedAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserHabitData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserHabitData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      selectedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}selected_at'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $UserHabitsTable createAlias(String alias) {
    return $UserHabitsTable(attachedDatabase, alias);
  }
}

class UserHabitData extends DataClass implements Insertable<UserHabitData> {
  final String id;
  final DateTime selectedAt;
  final bool isActive;
  const UserHabitData(
      {required this.id, required this.selectedAt, required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['selected_at'] = Variable<DateTime>(selectedAt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  UserHabitsCompanion toCompanion(bool nullToAbsent) {
    return UserHabitsCompanion(
      id: Value(id),
      selectedAt: Value(selectedAt),
      isActive: Value(isActive),
    );
  }

  factory UserHabitData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserHabitData(
      id: serializer.fromJson<String>(json['id']),
      selectedAt: serializer.fromJson<DateTime>(json['selectedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'selectedAt': serializer.toJson<DateTime>(selectedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  UserHabitData copyWith({String? id, DateTime? selectedAt, bool? isActive}) =>
      UserHabitData(
        id: id ?? this.id,
        selectedAt: selectedAt ?? this.selectedAt,
        isActive: isActive ?? this.isActive,
      );
  @override
  String toString() {
    return (StringBuffer('UserHabitData(')
          ..write('id: $id, ')
          ..write('selectedAt: $selectedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, selectedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserHabitData &&
          other.id == this.id &&
          other.selectedAt == this.selectedAt &&
          other.isActive == this.isActive);
}

class UserHabitsCompanion extends UpdateCompanion<UserHabitData> {
  final Value<String> id;
  final Value<DateTime> selectedAt;
  final Value<bool> isActive;
  final Value<int> rowid;
  const UserHabitsCompanion({
    this.id = const Value.absent(),
    this.selectedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserHabitsCompanion.insert({
    required String id,
    required DateTime selectedAt,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        selectedAt = Value(selectedAt);
  static Insertable<UserHabitData> custom({
    Expression<String>? id,
    Expression<DateTime>? selectedAt,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (selectedAt != null) 'selected_at': selectedAt,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserHabitsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? selectedAt,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return UserHabitsCompanion(
      id: id ?? this.id,
      selectedAt: selectedAt ?? this.selectedAt,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (selectedAt.present) {
      map['selected_at'] = Variable<DateTime>(selectedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserHabitsCompanion(')
          ..write('id: $id, ')
          ..write('selectedAt: $selectedAt, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $AssessmentsTable assessments = $AssessmentsTable(this);
  late final $AssessmentAreaScoresTable assessmentAreaScores =
      $AssessmentAreaScoresTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $LifeAreasEvaluationsTable lifeAreasEvaluations =
      $LifeAreasEvaluationsTable(this);
  late final $GratitudeEntriesTable gratitudeEntries =
      $GratitudeEntriesTable(this);
  late final $DailyGratitudeCompletionsTable dailyGratitudeCompletions =
      $DailyGratitudeCompletionsTable(this);
  late final $PhysicalActivitiesTable physicalActivities =
      $PhysicalActivitiesTable(this);
  late final $DailyActivitiesCompletionsTable dailyActivitiesCompletions =
      $DailyActivitiesCompletionsTable(this);
  late final $WorkoutGroupsTable workoutGroups = $WorkoutGroupsTable(this);
  late final $WorkoutRoutinesTable workoutRoutines =
      $WorkoutRoutinesTable(this);
  late final $TrainingExercisesTable trainingExercises =
      $TrainingExercisesTable(this);
  late final $DailyTrainingSessionsTable dailyTrainingSessions =
      $DailyTrainingSessionsTable(this);
  late final $DailyTrainingRecordsTable dailyTrainingRecords =
      $DailyTrainingRecordsTable(this);
  late final $FinancialTransactionsTable financialTransactions =
      $FinancialTransactionsTable(this);
  late final $FinancialCategoriesTable financialCategories =
      $FinancialCategoriesTable(this);
  late final $MonthlyCurrenciesTable monthlyCurrencies =
      $MonthlyCurrenciesTable(this);
  late final $UserHabitsTable userHabits = $UserHabitsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        assessments,
        assessmentAreaScores,
        users,
        lifeAreasEvaluations,
        gratitudeEntries,
        dailyGratitudeCompletions,
        physicalActivities,
        dailyActivitiesCompletions,
        workoutGroups,
        workoutRoutines,
        trainingExercises,
        dailyTrainingSessions,
        dailyTrainingRecords,
        financialTransactions,
        financialCategories,
        monthlyCurrencies,
        userHabits
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('assessments',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('assessment_area_scores', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('physical_activities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('daily_activities_completions',
                  kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('workout_groups',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('workout_routines', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('workout_routines',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('training_exercises', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('daily_training_sessions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('daily_training_records', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$AssessmentsTableInsertCompanionBuilder = AssessmentsCompanion
    Function({
  required String id,
  required DateTime createdAt,
  Value<DateTime?> completedAt,
  required String status,
  Value<int> rowid,
});
typedef $$AssessmentsTableUpdateCompanionBuilder = AssessmentsCompanion
    Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime?> completedAt,
  Value<String> status,
  Value<int> rowid,
});

class $$AssessmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssessmentsTable,
    Assessment,
    $$AssessmentsTableFilterComposer,
    $$AssessmentsTableOrderingComposer,
    $$AssessmentsTableProcessedTableManager,
    $$AssessmentsTableInsertCompanionBuilder,
    $$AssessmentsTableUpdateCompanionBuilder> {
  $$AssessmentsTableTableManager(_$AppDatabase db, $AssessmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AssessmentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AssessmentsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$AssessmentsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssessmentsCompanion(
            id: id,
            createdAt: createdAt,
            completedAt: completedAt,
            status: status,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required DateTime createdAt,
            Value<DateTime?> completedAt = const Value.absent(),
            required String status,
            Value<int> rowid = const Value.absent(),
          }) =>
              AssessmentsCompanion.insert(
            id: id,
            createdAt: createdAt,
            completedAt: completedAt,
            status: status,
            rowid: rowid,
          ),
        ));
}

class $$AssessmentsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $AssessmentsTable,
    Assessment,
    $$AssessmentsTableFilterComposer,
    $$AssessmentsTableOrderingComposer,
    $$AssessmentsTableProcessedTableManager,
    $$AssessmentsTableInsertCompanionBuilder,
    $$AssessmentsTableUpdateCompanionBuilder> {
  $$AssessmentsTableProcessedTableManager(super.$state);
}

class $$AssessmentsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AssessmentsTable> {
  $$AssessmentsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter assessmentAreaScoresRefs(
      ComposableFilter Function($$AssessmentAreaScoresTableFilterComposer f)
          f) {
    final $$AssessmentAreaScoresTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.assessmentAreaScores,
            getReferencedColumn: (t) => t.assessmentId,
            builder: (joinBuilder, parentComposers) =>
                $$AssessmentAreaScoresTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.assessmentAreaScores,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$AssessmentsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AssessmentsTable> {
  $$AssessmentsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AssessmentAreaScoresTableInsertCompanionBuilder
    = AssessmentAreaScoresCompanion Function({
  required String id,
  required String assessmentId,
  required String areaKey,
  required int currentPriority,
  required int currentState,
  required int currentInvestment,
  required int desiredInvestment,
  required String intent,
  required int investmentDelta,
  required double priorityGapScore,
  Value<int> rowid,
});
typedef $$AssessmentAreaScoresTableUpdateCompanionBuilder
    = AssessmentAreaScoresCompanion Function({
  Value<String> id,
  Value<String> assessmentId,
  Value<String> areaKey,
  Value<int> currentPriority,
  Value<int> currentState,
  Value<int> currentInvestment,
  Value<int> desiredInvestment,
  Value<String> intent,
  Value<int> investmentDelta,
  Value<double> priorityGapScore,
  Value<int> rowid,
});

class $$AssessmentAreaScoresTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AssessmentAreaScoresTable,
    AssessmentAreaScore,
    $$AssessmentAreaScoresTableFilterComposer,
    $$AssessmentAreaScoresTableOrderingComposer,
    $$AssessmentAreaScoresTableProcessedTableManager,
    $$AssessmentAreaScoresTableInsertCompanionBuilder,
    $$AssessmentAreaScoresTableUpdateCompanionBuilder> {
  $$AssessmentAreaScoresTableTableManager(
      _$AppDatabase db, $AssessmentAreaScoresTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$AssessmentAreaScoresTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$AssessmentAreaScoresTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$AssessmentAreaScoresTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> assessmentId = const Value.absent(),
            Value<String> areaKey = const Value.absent(),
            Value<int> currentPriority = const Value.absent(),
            Value<int> currentState = const Value.absent(),
            Value<int> currentInvestment = const Value.absent(),
            Value<int> desiredInvestment = const Value.absent(),
            Value<String> intent = const Value.absent(),
            Value<int> investmentDelta = const Value.absent(),
            Value<double> priorityGapScore = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AssessmentAreaScoresCompanion(
            id: id,
            assessmentId: assessmentId,
            areaKey: areaKey,
            currentPriority: currentPriority,
            currentState: currentState,
            currentInvestment: currentInvestment,
            desiredInvestment: desiredInvestment,
            intent: intent,
            investmentDelta: investmentDelta,
            priorityGapScore: priorityGapScore,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String assessmentId,
            required String areaKey,
            required int currentPriority,
            required int currentState,
            required int currentInvestment,
            required int desiredInvestment,
            required String intent,
            required int investmentDelta,
            required double priorityGapScore,
            Value<int> rowid = const Value.absent(),
          }) =>
              AssessmentAreaScoresCompanion.insert(
            id: id,
            assessmentId: assessmentId,
            areaKey: areaKey,
            currentPriority: currentPriority,
            currentState: currentState,
            currentInvestment: currentInvestment,
            desiredInvestment: desiredInvestment,
            intent: intent,
            investmentDelta: investmentDelta,
            priorityGapScore: priorityGapScore,
            rowid: rowid,
          ),
        ));
}

class $$AssessmentAreaScoresTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $AssessmentAreaScoresTable,
        AssessmentAreaScore,
        $$AssessmentAreaScoresTableFilterComposer,
        $$AssessmentAreaScoresTableOrderingComposer,
        $$AssessmentAreaScoresTableProcessedTableManager,
        $$AssessmentAreaScoresTableInsertCompanionBuilder,
        $$AssessmentAreaScoresTableUpdateCompanionBuilder> {
  $$AssessmentAreaScoresTableProcessedTableManager(super.$state);
}

class $$AssessmentAreaScoresTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AssessmentAreaScoresTable> {
  $$AssessmentAreaScoresTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get areaKey => $state.composableBuilder(
      column: $state.table.areaKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get currentPriority => $state.composableBuilder(
      column: $state.table.currentPriority,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get currentState => $state.composableBuilder(
      column: $state.table.currentState,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get currentInvestment => $state.composableBuilder(
      column: $state.table.currentInvestment,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get desiredInvestment => $state.composableBuilder(
      column: $state.table.desiredInvestment,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get intent => $state.composableBuilder(
      column: $state.table.intent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get investmentDelta => $state.composableBuilder(
      column: $state.table.investmentDelta,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get priorityGapScore => $state.composableBuilder(
      column: $state.table.priorityGapScore,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$AssessmentsTableFilterComposer get assessmentId {
    final $$AssessmentsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assessmentId,
        referencedTable: $state.db.assessments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$AssessmentsTableFilterComposer(ComposerState($state.db,
                $state.db.assessments, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$AssessmentAreaScoresTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AssessmentAreaScoresTable> {
  $$AssessmentAreaScoresTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get areaKey => $state.composableBuilder(
      column: $state.table.areaKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get currentPriority => $state.composableBuilder(
      column: $state.table.currentPriority,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get currentState => $state.composableBuilder(
      column: $state.table.currentState,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get currentInvestment => $state.composableBuilder(
      column: $state.table.currentInvestment,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get desiredInvestment => $state.composableBuilder(
      column: $state.table.desiredInvestment,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get intent => $state.composableBuilder(
      column: $state.table.intent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get investmentDelta => $state.composableBuilder(
      column: $state.table.investmentDelta,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get priorityGapScore => $state.composableBuilder(
      column: $state.table.priorityGapScore,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$AssessmentsTableOrderingComposer get assessmentId {
    final $$AssessmentsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.assessmentId,
        referencedTable: $state.db.assessments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$AssessmentsTableOrderingComposer(ComposerState($state.db,
                $state.db.assessments, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$UsersTableInsertCompanionBuilder = UsersCompanion Function({
  required String id,
  required DateTime createdAt,
  required AppLanguage selectedLanguage,
  Value<String> name,
  Value<bool> onboardingCompleted,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<AppLanguage> selectedLanguage,
  Value<String> name,
  Value<bool> onboardingCompleted,
  Value<int> rowid,
});

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    UserData,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableProcessedTableManager,
    $$UsersTableInsertCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsersTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$UsersTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<AppLanguage> selectedLanguage = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> onboardingCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            createdAt: createdAt,
            selectedLanguage: selectedLanguage,
            name: name,
            onboardingCompleted: onboardingCompleted,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required DateTime createdAt,
            required AppLanguage selectedLanguage,
            Value<String> name = const Value.absent(),
            Value<bool> onboardingCompleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            createdAt: createdAt,
            selectedLanguage: selectedLanguage,
            name: name,
            onboardingCompleted: onboardingCompleted,
            rowid: rowid,
          ),
        ));
}

class $$UsersTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    UserData,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableProcessedTableManager,
    $$UsersTableInsertCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableProcessedTableManager(super.$state);
}

class $$UsersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<AppLanguage, AppLanguage, int>
      get selectedLanguage => $state.composableBuilder(
          column: $state.table.selectedLanguage,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get onboardingCompleted => $state.composableBuilder(
      column: $state.table.onboardingCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UsersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get selectedLanguage => $state.composableBuilder(
      column: $state.table.selectedLanguage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get onboardingCompleted => $state.composableBuilder(
      column: $state.table.onboardingCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$LifeAreasEvaluationsTableInsertCompanionBuilder
    = LifeAreasEvaluationsCompanion Function({
  required String id,
  required LifeArea lifeArea,
  required double score,
  required int currentPriority,
  required DateTime evaluatedAt,
  Value<int> rowid,
});
typedef $$LifeAreasEvaluationsTableUpdateCompanionBuilder
    = LifeAreasEvaluationsCompanion Function({
  Value<String> id,
  Value<LifeArea> lifeArea,
  Value<double> score,
  Value<int> currentPriority,
  Value<DateTime> evaluatedAt,
  Value<int> rowid,
});

class $$LifeAreasEvaluationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LifeAreasEvaluationsTable,
    LifeAreaEvaluationData,
    $$LifeAreasEvaluationsTableFilterComposer,
    $$LifeAreasEvaluationsTableOrderingComposer,
    $$LifeAreasEvaluationsTableProcessedTableManager,
    $$LifeAreasEvaluationsTableInsertCompanionBuilder,
    $$LifeAreasEvaluationsTableUpdateCompanionBuilder> {
  $$LifeAreasEvaluationsTableTableManager(
      _$AppDatabase db, $LifeAreasEvaluationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$LifeAreasEvaluationsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$LifeAreasEvaluationsTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$LifeAreasEvaluationsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<LifeArea> lifeArea = const Value.absent(),
            Value<double> score = const Value.absent(),
            Value<int> currentPriority = const Value.absent(),
            Value<DateTime> evaluatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LifeAreasEvaluationsCompanion(
            id: id,
            lifeArea: lifeArea,
            score: score,
            currentPriority: currentPriority,
            evaluatedAt: evaluatedAt,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required LifeArea lifeArea,
            required double score,
            required int currentPriority,
            required DateTime evaluatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LifeAreasEvaluationsCompanion.insert(
            id: id,
            lifeArea: lifeArea,
            score: score,
            currentPriority: currentPriority,
            evaluatedAt: evaluatedAt,
            rowid: rowid,
          ),
        ));
}

class $$LifeAreasEvaluationsTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $LifeAreasEvaluationsTable,
        LifeAreaEvaluationData,
        $$LifeAreasEvaluationsTableFilterComposer,
        $$LifeAreasEvaluationsTableOrderingComposer,
        $$LifeAreasEvaluationsTableProcessedTableManager,
        $$LifeAreasEvaluationsTableInsertCompanionBuilder,
        $$LifeAreasEvaluationsTableUpdateCompanionBuilder> {
  $$LifeAreasEvaluationsTableProcessedTableManager(super.$state);
}

class $$LifeAreasEvaluationsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LifeAreasEvaluationsTable> {
  $$LifeAreasEvaluationsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<LifeArea, LifeArea, int> get lifeArea =>
      $state.composableBuilder(
          column: $state.table.lifeArea,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<double> get score => $state.composableBuilder(
      column: $state.table.score,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get currentPriority => $state.composableBuilder(
      column: $state.table.currentPriority,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get evaluatedAt => $state.composableBuilder(
      column: $state.table.evaluatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LifeAreasEvaluationsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LifeAreasEvaluationsTable> {
  $$LifeAreasEvaluationsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get lifeArea => $state.composableBuilder(
      column: $state.table.lifeArea,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get score => $state.composableBuilder(
      column: $state.table.score,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get currentPriority => $state.composableBuilder(
      column: $state.table.currentPriority,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get evaluatedAt => $state.composableBuilder(
      column: $state.table.evaluatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$GratitudeEntriesTableInsertCompanionBuilder
    = GratitudeEntriesCompanion Function({
  required String id,
  required String content,
  required DateTime createdAt,
  Value<String?> period,
  Value<int> orderIndex,
  Value<int> rowid,
});
typedef $$GratitudeEntriesTableUpdateCompanionBuilder
    = GratitudeEntriesCompanion Function({
  Value<String> id,
  Value<String> content,
  Value<DateTime> createdAt,
  Value<String?> period,
  Value<int> orderIndex,
  Value<int> rowid,
});

class $$GratitudeEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GratitudeEntriesTable,
    GratitudeEntryData,
    $$GratitudeEntriesTableFilterComposer,
    $$GratitudeEntriesTableOrderingComposer,
    $$GratitudeEntriesTableProcessedTableManager,
    $$GratitudeEntriesTableInsertCompanionBuilder,
    $$GratitudeEntriesTableUpdateCompanionBuilder> {
  $$GratitudeEntriesTableTableManager(
      _$AppDatabase db, $GratitudeEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$GratitudeEntriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$GratitudeEntriesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$GratitudeEntriesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> period = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GratitudeEntriesCompanion(
            id: id,
            content: content,
            createdAt: createdAt,
            period: period,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String content,
            required DateTime createdAt,
            Value<String?> period = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GratitudeEntriesCompanion.insert(
            id: id,
            content: content,
            createdAt: createdAt,
            period: period,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
        ));
}

class $$GratitudeEntriesTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $GratitudeEntriesTable,
        GratitudeEntryData,
        $$GratitudeEntriesTableFilterComposer,
        $$GratitudeEntriesTableOrderingComposer,
        $$GratitudeEntriesTableProcessedTableManager,
        $$GratitudeEntriesTableInsertCompanionBuilder,
        $$GratitudeEntriesTableUpdateCompanionBuilder> {
  $$GratitudeEntriesTableProcessedTableManager(super.$state);
}

class $$GratitudeEntriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $GratitudeEntriesTable> {
  $$GratitudeEntriesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get period => $state.composableBuilder(
      column: $state.table.period,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$GratitudeEntriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $GratitudeEntriesTable> {
  $$GratitudeEntriesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get period => $state.composableBuilder(
      column: $state.table.period,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$DailyGratitudeCompletionsTableInsertCompanionBuilder
    = DailyGratitudeCompletionsCompanion Function({
  required String id,
  required DateTime date,
  Value<bool> morningCompleted,
  Value<DateTime?> morningCompletedAt,
  Value<bool> eveningCompleted,
  Value<DateTime?> eveningCompletedAt,
  Value<int> rowid,
});
typedef $$DailyGratitudeCompletionsTableUpdateCompanionBuilder
    = DailyGratitudeCompletionsCompanion Function({
  Value<String> id,
  Value<DateTime> date,
  Value<bool> morningCompleted,
  Value<DateTime?> morningCompletedAt,
  Value<bool> eveningCompleted,
  Value<DateTime?> eveningCompletedAt,
  Value<int> rowid,
});

class $$DailyGratitudeCompletionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyGratitudeCompletionsTable,
    DailyGratitudeCompletionData,
    $$DailyGratitudeCompletionsTableFilterComposer,
    $$DailyGratitudeCompletionsTableOrderingComposer,
    $$DailyGratitudeCompletionsTableProcessedTableManager,
    $$DailyGratitudeCompletionsTableInsertCompanionBuilder,
    $$DailyGratitudeCompletionsTableUpdateCompanionBuilder> {
  $$DailyGratitudeCompletionsTableTableManager(
      _$AppDatabase db, $DailyGratitudeCompletionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$DailyGratitudeCompletionsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$DailyGratitudeCompletionsTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$DailyGratitudeCompletionsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> morningCompleted = const Value.absent(),
            Value<DateTime?> morningCompletedAt = const Value.absent(),
            Value<bool> eveningCompleted = const Value.absent(),
            Value<DateTime?> eveningCompletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyGratitudeCompletionsCompanion(
            id: id,
            date: date,
            morningCompleted: morningCompleted,
            morningCompletedAt: morningCompletedAt,
            eveningCompleted: eveningCompleted,
            eveningCompletedAt: eveningCompletedAt,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required DateTime date,
            Value<bool> morningCompleted = const Value.absent(),
            Value<DateTime?> morningCompletedAt = const Value.absent(),
            Value<bool> eveningCompleted = const Value.absent(),
            Value<DateTime?> eveningCompletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyGratitudeCompletionsCompanion.insert(
            id: id,
            date: date,
            morningCompleted: morningCompleted,
            morningCompletedAt: morningCompletedAt,
            eveningCompleted: eveningCompleted,
            eveningCompletedAt: eveningCompletedAt,
            rowid: rowid,
          ),
        ));
}

class $$DailyGratitudeCompletionsTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $DailyGratitudeCompletionsTable,
        DailyGratitudeCompletionData,
        $$DailyGratitudeCompletionsTableFilterComposer,
        $$DailyGratitudeCompletionsTableOrderingComposer,
        $$DailyGratitudeCompletionsTableProcessedTableManager,
        $$DailyGratitudeCompletionsTableInsertCompanionBuilder,
        $$DailyGratitudeCompletionsTableUpdateCompanionBuilder> {
  $$DailyGratitudeCompletionsTableProcessedTableManager(super.$state);
}

class $$DailyGratitudeCompletionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DailyGratitudeCompletionsTable> {
  $$DailyGratitudeCompletionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get morningCompleted => $state.composableBuilder(
      column: $state.table.morningCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get morningCompletedAt => $state.composableBuilder(
      column: $state.table.morningCompletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get eveningCompleted => $state.composableBuilder(
      column: $state.table.eveningCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get eveningCompletedAt => $state.composableBuilder(
      column: $state.table.eveningCompletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DailyGratitudeCompletionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DailyGratitudeCompletionsTable> {
  $$DailyGratitudeCompletionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get morningCompleted => $state.composableBuilder(
      column: $state.table.morningCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get morningCompletedAt => $state.composableBuilder(
      column: $state.table.morningCompletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get eveningCompleted => $state.composableBuilder(
      column: $state.table.eveningCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get eveningCompletedAt => $state.composableBuilder(
      column: $state.table.eveningCompletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PhysicalActivitiesTableInsertCompanionBuilder
    = PhysicalActivitiesCompanion Function({
  required String id,
  required String activityType,
  Value<String?> customName,
  required String metricType,
  required int targetValue,
  required DateTime createdAt,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$PhysicalActivitiesTableUpdateCompanionBuilder
    = PhysicalActivitiesCompanion Function({
  Value<String> id,
  Value<String> activityType,
  Value<String?> customName,
  Value<String> metricType,
  Value<int> targetValue,
  Value<DateTime> createdAt,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$PhysicalActivitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhysicalActivitiesTable,
    PhysicalActivityData,
    $$PhysicalActivitiesTableFilterComposer,
    $$PhysicalActivitiesTableOrderingComposer,
    $$PhysicalActivitiesTableProcessedTableManager,
    $$PhysicalActivitiesTableInsertCompanionBuilder,
    $$PhysicalActivitiesTableUpdateCompanionBuilder> {
  $$PhysicalActivitiesTableTableManager(
      _$AppDatabase db, $PhysicalActivitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PhysicalActivitiesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$PhysicalActivitiesTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$PhysicalActivitiesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> activityType = const Value.absent(),
            Value<String?> customName = const Value.absent(),
            Value<String> metricType = const Value.absent(),
            Value<int> targetValue = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhysicalActivitiesCompanion(
            id: id,
            activityType: activityType,
            customName: customName,
            metricType: metricType,
            targetValue: targetValue,
            createdAt: createdAt,
            isActive: isActive,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String activityType,
            Value<String?> customName = const Value.absent(),
            required String metricType,
            required int targetValue,
            required DateTime createdAt,
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhysicalActivitiesCompanion.insert(
            id: id,
            activityType: activityType,
            customName: customName,
            metricType: metricType,
            targetValue: targetValue,
            createdAt: createdAt,
            isActive: isActive,
            rowid: rowid,
          ),
        ));
}

class $$PhysicalActivitiesTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $PhysicalActivitiesTable,
        PhysicalActivityData,
        $$PhysicalActivitiesTableFilterComposer,
        $$PhysicalActivitiesTableOrderingComposer,
        $$PhysicalActivitiesTableProcessedTableManager,
        $$PhysicalActivitiesTableInsertCompanionBuilder,
        $$PhysicalActivitiesTableUpdateCompanionBuilder> {
  $$PhysicalActivitiesTableProcessedTableManager(super.$state);
}

class $$PhysicalActivitiesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PhysicalActivitiesTable> {
  $$PhysicalActivitiesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get activityType => $state.composableBuilder(
      column: $state.table.activityType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get customName => $state.composableBuilder(
      column: $state.table.customName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get metricType => $state.composableBuilder(
      column: $state.table.metricType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get targetValue => $state.composableBuilder(
      column: $state.table.targetValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter dailyActivitiesCompletionsRefs(
      ComposableFilter Function(
              $$DailyActivitiesCompletionsTableFilterComposer f)
          f) {
    final $$DailyActivitiesCompletionsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.dailyActivitiesCompletions,
            getReferencedColumn: (t) => t.activityId,
            builder: (joinBuilder, parentComposers) =>
                $$DailyActivitiesCompletionsTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.dailyActivitiesCompletions,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$PhysicalActivitiesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PhysicalActivitiesTable> {
  $$PhysicalActivitiesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get activityType => $state.composableBuilder(
      column: $state.table.activityType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get customName => $state.composableBuilder(
      column: $state.table.customName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get metricType => $state.composableBuilder(
      column: $state.table.metricType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get targetValue => $state.composableBuilder(
      column: $state.table.targetValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$DailyActivitiesCompletionsTableInsertCompanionBuilder
    = DailyActivitiesCompletionsCompanion Function({
  required String id,
  required String activityId,
  required DateTime date,
  Value<bool> completed,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$DailyActivitiesCompletionsTableUpdateCompanionBuilder
    = DailyActivitiesCompletionsCompanion Function({
  Value<String> id,
  Value<String> activityId,
  Value<DateTime> date,
  Value<bool> completed,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

class $$DailyActivitiesCompletionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyActivitiesCompletionsTable,
    DailyActivityCompletionData,
    $$DailyActivitiesCompletionsTableFilterComposer,
    $$DailyActivitiesCompletionsTableOrderingComposer,
    $$DailyActivitiesCompletionsTableProcessedTableManager,
    $$DailyActivitiesCompletionsTableInsertCompanionBuilder,
    $$DailyActivitiesCompletionsTableUpdateCompanionBuilder> {
  $$DailyActivitiesCompletionsTableTableManager(
      _$AppDatabase db, $DailyActivitiesCompletionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$DailyActivitiesCompletionsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$DailyActivitiesCompletionsTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$DailyActivitiesCompletionsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> activityId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyActivitiesCompletionsCompanion(
            id: id,
            activityId: activityId,
            date: date,
            completed: completed,
            completedAt: completedAt,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String activityId,
            required DateTime date,
            Value<bool> completed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyActivitiesCompletionsCompanion.insert(
            id: id,
            activityId: activityId,
            date: date,
            completed: completed,
            completedAt: completedAt,
            rowid: rowid,
          ),
        ));
}

class $$DailyActivitiesCompletionsTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $DailyActivitiesCompletionsTable,
        DailyActivityCompletionData,
        $$DailyActivitiesCompletionsTableFilterComposer,
        $$DailyActivitiesCompletionsTableOrderingComposer,
        $$DailyActivitiesCompletionsTableProcessedTableManager,
        $$DailyActivitiesCompletionsTableInsertCompanionBuilder,
        $$DailyActivitiesCompletionsTableUpdateCompanionBuilder> {
  $$DailyActivitiesCompletionsTableProcessedTableManager(super.$state);
}

class $$DailyActivitiesCompletionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DailyActivitiesCompletionsTable> {
  $$DailyActivitiesCompletionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get completed => $state.composableBuilder(
      column: $state.table.completed,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$PhysicalActivitiesTableFilterComposer get activityId {
    final $$PhysicalActivitiesTableFilterComposer composer = $state
        .composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.activityId,
            referencedTable: $state.db.physicalActivities,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$PhysicalActivitiesTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.physicalActivities,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$DailyActivitiesCompletionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DailyActivitiesCompletionsTable> {
  $$DailyActivitiesCompletionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get completed => $state.composableBuilder(
      column: $state.table.completed,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get completedAt => $state.composableBuilder(
      column: $state.table.completedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PhysicalActivitiesTableOrderingComposer get activityId {
    final $$PhysicalActivitiesTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.activityId,
            referencedTable: $state.db.physicalActivities,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$PhysicalActivitiesTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.physicalActivities,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

typedef $$WorkoutGroupsTableInsertCompanionBuilder = WorkoutGroupsCompanion
    Function({
  required String id,
  required String name,
  Value<String?> description,
  required DateTime createdAt,
  Value<bool> isActive,
  Value<int> orderIndex,
  Value<int> rowid,
});
typedef $$WorkoutGroupsTableUpdateCompanionBuilder = WorkoutGroupsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<bool> isActive,
  Value<int> orderIndex,
  Value<int> rowid,
});

class $$WorkoutGroupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutGroupsTable,
    WorkoutGroupData,
    $$WorkoutGroupsTableFilterComposer,
    $$WorkoutGroupsTableOrderingComposer,
    $$WorkoutGroupsTableProcessedTableManager,
    $$WorkoutGroupsTableInsertCompanionBuilder,
    $$WorkoutGroupsTableUpdateCompanionBuilder> {
  $$WorkoutGroupsTableTableManager(_$AppDatabase db, $WorkoutGroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WorkoutGroupsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WorkoutGroupsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$WorkoutGroupsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutGroupsCompanion(
            id: id,
            name: name,
            description: description,
            createdAt: createdAt,
            isActive: isActive,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            required DateTime createdAt,
            Value<bool> isActive = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutGroupsCompanion.insert(
            id: id,
            name: name,
            description: description,
            createdAt: createdAt,
            isActive: isActive,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
        ));
}

class $$WorkoutGroupsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $WorkoutGroupsTable,
    WorkoutGroupData,
    $$WorkoutGroupsTableFilterComposer,
    $$WorkoutGroupsTableOrderingComposer,
    $$WorkoutGroupsTableProcessedTableManager,
    $$WorkoutGroupsTableInsertCompanionBuilder,
    $$WorkoutGroupsTableUpdateCompanionBuilder> {
  $$WorkoutGroupsTableProcessedTableManager(super.$state);
}

class $$WorkoutGroupsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WorkoutGroupsTable> {
  $$WorkoutGroupsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter workoutRoutinesRefs(
      ComposableFilter Function($$WorkoutRoutinesTableFilterComposer f) f) {
    final $$WorkoutRoutinesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.workoutRoutines,
            getReferencedColumn: (t) => t.groupId,
            builder: (joinBuilder, parentComposers) =>
                $$WorkoutRoutinesTableFilterComposer(ComposerState($state.db,
                    $state.db.workoutRoutines, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$WorkoutGroupsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WorkoutGroupsTable> {
  $$WorkoutGroupsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$WorkoutRoutinesTableInsertCompanionBuilder = WorkoutRoutinesCompanion
    Function({
  required String id,
  required String groupId,
  required String name,
  Value<String?> description,
  required DateTime createdAt,
  Value<int> orderIndex,
  Value<int> rowid,
});
typedef $$WorkoutRoutinesTableUpdateCompanionBuilder = WorkoutRoutinesCompanion
    Function({
  Value<String> id,
  Value<String> groupId,
  Value<String> name,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<int> orderIndex,
  Value<int> rowid,
});

class $$WorkoutRoutinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutRoutinesTable,
    WorkoutRoutineData,
    $$WorkoutRoutinesTableFilterComposer,
    $$WorkoutRoutinesTableOrderingComposer,
    $$WorkoutRoutinesTableProcessedTableManager,
    $$WorkoutRoutinesTableInsertCompanionBuilder,
    $$WorkoutRoutinesTableUpdateCompanionBuilder> {
  $$WorkoutRoutinesTableTableManager(
      _$AppDatabase db, $WorkoutRoutinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WorkoutRoutinesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WorkoutRoutinesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$WorkoutRoutinesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> groupId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutRoutinesCompanion(
            id: id,
            groupId: groupId,
            name: name,
            description: description,
            createdAt: createdAt,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String groupId,
            required String name,
            Value<String?> description = const Value.absent(),
            required DateTime createdAt,
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutRoutinesCompanion.insert(
            id: id,
            groupId: groupId,
            name: name,
            description: description,
            createdAt: createdAt,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
        ));
}

class $$WorkoutRoutinesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $WorkoutRoutinesTable,
    WorkoutRoutineData,
    $$WorkoutRoutinesTableFilterComposer,
    $$WorkoutRoutinesTableOrderingComposer,
    $$WorkoutRoutinesTableProcessedTableManager,
    $$WorkoutRoutinesTableInsertCompanionBuilder,
    $$WorkoutRoutinesTableUpdateCompanionBuilder> {
  $$WorkoutRoutinesTableProcessedTableManager(super.$state);
}

class $$WorkoutRoutinesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WorkoutRoutinesTable> {
  $$WorkoutRoutinesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$WorkoutGroupsTableFilterComposer get groupId {
    final $$WorkoutGroupsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $state.db.workoutGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$WorkoutGroupsTableFilterComposer(ComposerState($state.db,
                $state.db.workoutGroups, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter trainingExercisesRefs(
      ComposableFilter Function($$TrainingExercisesTableFilterComposer f) f) {
    final $$TrainingExercisesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.trainingExercises,
            getReferencedColumn: (t) => t.routineId,
            builder: (joinBuilder, parentComposers) =>
                $$TrainingExercisesTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.trainingExercises,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$WorkoutRoutinesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WorkoutRoutinesTable> {
  $$WorkoutRoutinesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$WorkoutGroupsTableOrderingComposer get groupId {
    final $$WorkoutGroupsTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.groupId,
            referencedTable: $state.db.workoutGroups,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$WorkoutGroupsTableOrderingComposer(ComposerState($state.db,
                    $state.db.workoutGroups, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$TrainingExercisesTableInsertCompanionBuilder
    = TrainingExercisesCompanion Function({
  required String id,
  required String routineId,
  required String name,
  required String activityType,
  Value<int> targetSets,
  Value<int?> targetDurationSeconds,
  Value<int?> targetRepetitions,
  Value<double?> targetWeightKg,
  Value<int> orderIndex,
  Value<int> rowid,
});
typedef $$TrainingExercisesTableUpdateCompanionBuilder
    = TrainingExercisesCompanion Function({
  Value<String> id,
  Value<String> routineId,
  Value<String> name,
  Value<String> activityType,
  Value<int> targetSets,
  Value<int?> targetDurationSeconds,
  Value<int?> targetRepetitions,
  Value<double?> targetWeightKg,
  Value<int> orderIndex,
  Value<int> rowid,
});

class $$TrainingExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrainingExercisesTable,
    TrainingExerciseData,
    $$TrainingExercisesTableFilterComposer,
    $$TrainingExercisesTableOrderingComposer,
    $$TrainingExercisesTableProcessedTableManager,
    $$TrainingExercisesTableInsertCompanionBuilder,
    $$TrainingExercisesTableUpdateCompanionBuilder> {
  $$TrainingExercisesTableTableManager(
      _$AppDatabase db, $TrainingExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TrainingExercisesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$TrainingExercisesTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TrainingExercisesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> routineId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> activityType = const Value.absent(),
            Value<int> targetSets = const Value.absent(),
            Value<int?> targetDurationSeconds = const Value.absent(),
            Value<int?> targetRepetitions = const Value.absent(),
            Value<double?> targetWeightKg = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TrainingExercisesCompanion(
            id: id,
            routineId: routineId,
            name: name,
            activityType: activityType,
            targetSets: targetSets,
            targetDurationSeconds: targetDurationSeconds,
            targetRepetitions: targetRepetitions,
            targetWeightKg: targetWeightKg,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String routineId,
            required String name,
            required String activityType,
            Value<int> targetSets = const Value.absent(),
            Value<int?> targetDurationSeconds = const Value.absent(),
            Value<int?> targetRepetitions = const Value.absent(),
            Value<double?> targetWeightKg = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TrainingExercisesCompanion.insert(
            id: id,
            routineId: routineId,
            name: name,
            activityType: activityType,
            targetSets: targetSets,
            targetDurationSeconds: targetDurationSeconds,
            targetRepetitions: targetRepetitions,
            targetWeightKg: targetWeightKg,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
        ));
}

class $$TrainingExercisesTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $TrainingExercisesTable,
        TrainingExerciseData,
        $$TrainingExercisesTableFilterComposer,
        $$TrainingExercisesTableOrderingComposer,
        $$TrainingExercisesTableProcessedTableManager,
        $$TrainingExercisesTableInsertCompanionBuilder,
        $$TrainingExercisesTableUpdateCompanionBuilder> {
  $$TrainingExercisesTableProcessedTableManager(super.$state);
}

class $$TrainingExercisesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TrainingExercisesTable> {
  $$TrainingExercisesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get activityType => $state.composableBuilder(
      column: $state.table.activityType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get targetSets => $state.composableBuilder(
      column: $state.table.targetSets,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get targetDurationSeconds => $state.composableBuilder(
      column: $state.table.targetDurationSeconds,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get targetRepetitions => $state.composableBuilder(
      column: $state.table.targetRepetitions,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get targetWeightKg => $state.composableBuilder(
      column: $state.table.targetWeightKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$WorkoutRoutinesTableFilterComposer get routineId {
    final $$WorkoutRoutinesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.routineId,
            referencedTable: $state.db.workoutRoutines,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$WorkoutRoutinesTableFilterComposer(ComposerState($state.db,
                    $state.db.workoutRoutines, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$TrainingExercisesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TrainingExercisesTable> {
  $$TrainingExercisesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get activityType => $state.composableBuilder(
      column: $state.table.activityType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get targetSets => $state.composableBuilder(
      column: $state.table.targetSets,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get targetDurationSeconds => $state.composableBuilder(
      column: $state.table.targetDurationSeconds,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get targetRepetitions => $state.composableBuilder(
      column: $state.table.targetRepetitions,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get targetWeightKg => $state.composableBuilder(
      column: $state.table.targetWeightKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$WorkoutRoutinesTableOrderingComposer get routineId {
    final $$WorkoutRoutinesTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.routineId,
            referencedTable: $state.db.workoutRoutines,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$WorkoutRoutinesTableOrderingComposer(ComposerState($state.db,
                    $state.db.workoutRoutines, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$DailyTrainingSessionsTableInsertCompanionBuilder
    = DailyTrainingSessionsCompanion Function({
  required String id,
  Value<String?> routineId,
  required String routineName,
  Value<String?> groupName,
  required DateTime date,
  required DateTime startedAt,
  Value<DateTime?> concludedAt,
  Value<String> status,
  Value<int> rowid,
});
typedef $$DailyTrainingSessionsTableUpdateCompanionBuilder
    = DailyTrainingSessionsCompanion Function({
  Value<String> id,
  Value<String?> routineId,
  Value<String> routineName,
  Value<String?> groupName,
  Value<DateTime> date,
  Value<DateTime> startedAt,
  Value<DateTime?> concludedAt,
  Value<String> status,
  Value<int> rowid,
});

class $$DailyTrainingSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyTrainingSessionsTable,
    DailyTrainingSessionData,
    $$DailyTrainingSessionsTableFilterComposer,
    $$DailyTrainingSessionsTableOrderingComposer,
    $$DailyTrainingSessionsTableProcessedTableManager,
    $$DailyTrainingSessionsTableInsertCompanionBuilder,
    $$DailyTrainingSessionsTableUpdateCompanionBuilder> {
  $$DailyTrainingSessionsTableTableManager(
      _$AppDatabase db, $DailyTrainingSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$DailyTrainingSessionsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$DailyTrainingSessionsTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$DailyTrainingSessionsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String?> routineId = const Value.absent(),
            Value<String> routineName = const Value.absent(),
            Value<String?> groupName = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> concludedAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyTrainingSessionsCompanion(
            id: id,
            routineId: routineId,
            routineName: routineName,
            groupName: groupName,
            date: date,
            startedAt: startedAt,
            concludedAt: concludedAt,
            status: status,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            Value<String?> routineId = const Value.absent(),
            required String routineName,
            Value<String?> groupName = const Value.absent(),
            required DateTime date,
            required DateTime startedAt,
            Value<DateTime?> concludedAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyTrainingSessionsCompanion.insert(
            id: id,
            routineId: routineId,
            routineName: routineName,
            groupName: groupName,
            date: date,
            startedAt: startedAt,
            concludedAt: concludedAt,
            status: status,
            rowid: rowid,
          ),
        ));
}

class $$DailyTrainingSessionsTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $DailyTrainingSessionsTable,
        DailyTrainingSessionData,
        $$DailyTrainingSessionsTableFilterComposer,
        $$DailyTrainingSessionsTableOrderingComposer,
        $$DailyTrainingSessionsTableProcessedTableManager,
        $$DailyTrainingSessionsTableInsertCompanionBuilder,
        $$DailyTrainingSessionsTableUpdateCompanionBuilder> {
  $$DailyTrainingSessionsTableProcessedTableManager(super.$state);
}

class $$DailyTrainingSessionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DailyTrainingSessionsTable> {
  $$DailyTrainingSessionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get routineId => $state.composableBuilder(
      column: $state.table.routineId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get routineName => $state.composableBuilder(
      column: $state.table.routineName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get groupName => $state.composableBuilder(
      column: $state.table.groupName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get concludedAt => $state.composableBuilder(
      column: $state.table.concludedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter dailyTrainingRecordsRefs(
      ComposableFilter Function($$DailyTrainingRecordsTableFilterComposer f)
          f) {
    final $$DailyTrainingRecordsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.dailyTrainingRecords,
            getReferencedColumn: (t) => t.sessionId,
            builder: (joinBuilder, parentComposers) =>
                $$DailyTrainingRecordsTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.dailyTrainingRecords,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$DailyTrainingSessionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DailyTrainingSessionsTable> {
  $$DailyTrainingSessionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get routineId => $state.composableBuilder(
      column: $state.table.routineId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get routineName => $state.composableBuilder(
      column: $state.table.routineName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get groupName => $state.composableBuilder(
      column: $state.table.groupName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get concludedAt => $state.composableBuilder(
      column: $state.table.concludedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$DailyTrainingRecordsTableInsertCompanionBuilder
    = DailyTrainingRecordsCompanion Function({
  required String id,
  required String sessionId,
  required String exerciseName,
  required String activityType,
  Value<int?> sets,
  Value<int?> durationSeconds,
  Value<int?> repetitions,
  Value<double?> weightKg,
  Value<bool> isCompleted,
  Value<int> orderIndex,
  Value<int> rowid,
});
typedef $$DailyTrainingRecordsTableUpdateCompanionBuilder
    = DailyTrainingRecordsCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> exerciseName,
  Value<String> activityType,
  Value<int?> sets,
  Value<int?> durationSeconds,
  Value<int?> repetitions,
  Value<double?> weightKg,
  Value<bool> isCompleted,
  Value<int> orderIndex,
  Value<int> rowid,
});

class $$DailyTrainingRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyTrainingRecordsTable,
    DailyTrainingRecordData,
    $$DailyTrainingRecordsTableFilterComposer,
    $$DailyTrainingRecordsTableOrderingComposer,
    $$DailyTrainingRecordsTableProcessedTableManager,
    $$DailyTrainingRecordsTableInsertCompanionBuilder,
    $$DailyTrainingRecordsTableUpdateCompanionBuilder> {
  $$DailyTrainingRecordsTableTableManager(
      _$AppDatabase db, $DailyTrainingRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$DailyTrainingRecordsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$DailyTrainingRecordsTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$DailyTrainingRecordsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<String> exerciseName = const Value.absent(),
            Value<String> activityType = const Value.absent(),
            Value<int?> sets = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<int?> repetitions = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyTrainingRecordsCompanion(
            id: id,
            sessionId: sessionId,
            exerciseName: exerciseName,
            activityType: activityType,
            sets: sets,
            durationSeconds: durationSeconds,
            repetitions: repetitions,
            weightKg: weightKg,
            isCompleted: isCompleted,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String sessionId,
            required String exerciseName,
            required String activityType,
            Value<int?> sets = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<int?> repetitions = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyTrainingRecordsCompanion.insert(
            id: id,
            sessionId: sessionId,
            exerciseName: exerciseName,
            activityType: activityType,
            sets: sets,
            durationSeconds: durationSeconds,
            repetitions: repetitions,
            weightKg: weightKg,
            isCompleted: isCompleted,
            orderIndex: orderIndex,
            rowid: rowid,
          ),
        ));
}

class $$DailyTrainingRecordsTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $DailyTrainingRecordsTable,
        DailyTrainingRecordData,
        $$DailyTrainingRecordsTableFilterComposer,
        $$DailyTrainingRecordsTableOrderingComposer,
        $$DailyTrainingRecordsTableProcessedTableManager,
        $$DailyTrainingRecordsTableInsertCompanionBuilder,
        $$DailyTrainingRecordsTableUpdateCompanionBuilder> {
  $$DailyTrainingRecordsTableProcessedTableManager(super.$state);
}

class $$DailyTrainingRecordsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DailyTrainingRecordsTable> {
  $$DailyTrainingRecordsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get exerciseName => $state.composableBuilder(
      column: $state.table.exerciseName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get activityType => $state.composableBuilder(
      column: $state.table.activityType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sets => $state.composableBuilder(
      column: $state.table.sets,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get durationSeconds => $state.composableBuilder(
      column: $state.table.durationSeconds,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get repetitions => $state.composableBuilder(
      column: $state.table.repetitions,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get weightKg => $state.composableBuilder(
      column: $state.table.weightKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$DailyTrainingSessionsTableFilterComposer get sessionId {
    final $$DailyTrainingSessionsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.sessionId,
            referencedTable: $state.db.dailyTrainingSessions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$DailyTrainingSessionsTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.dailyTrainingSessions,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$DailyTrainingRecordsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DailyTrainingRecordsTable> {
  $$DailyTrainingRecordsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get exerciseName => $state.composableBuilder(
      column: $state.table.exerciseName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get activityType => $state.composableBuilder(
      column: $state.table.activityType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sets => $state.composableBuilder(
      column: $state.table.sets,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get durationSeconds => $state.composableBuilder(
      column: $state.table.durationSeconds,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get repetitions => $state.composableBuilder(
      column: $state.table.repetitions,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get weightKg => $state.composableBuilder(
      column: $state.table.weightKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCompleted => $state.composableBuilder(
      column: $state.table.isCompleted,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderIndex => $state.composableBuilder(
      column: $state.table.orderIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$DailyTrainingSessionsTableOrderingComposer get sessionId {
    final $$DailyTrainingSessionsTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.sessionId,
            referencedTable: $state.db.dailyTrainingSessions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$DailyTrainingSessionsTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.dailyTrainingSessions,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

typedef $$FinancialTransactionsTableInsertCompanionBuilder
    = FinancialTransactionsCompanion Function({
  required String id,
  required String title,
  required double amount,
  required String type,
  required DateTime date,
  Value<String?> category,
  Value<String> currencyCode,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$FinancialTransactionsTableUpdateCompanionBuilder
    = FinancialTransactionsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<double> amount,
  Value<String> type,
  Value<DateTime> date,
  Value<String?> category,
  Value<String> currencyCode,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$FinancialTransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FinancialTransactionsTable,
    FinancialTransactionData,
    $$FinancialTransactionsTableFilterComposer,
    $$FinancialTransactionsTableOrderingComposer,
    $$FinancialTransactionsTableProcessedTableManager,
    $$FinancialTransactionsTableInsertCompanionBuilder,
    $$FinancialTransactionsTableUpdateCompanionBuilder> {
  $$FinancialTransactionsTableTableManager(
      _$AppDatabase db, $FinancialTransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$FinancialTransactionsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$FinancialTransactionsTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$FinancialTransactionsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FinancialTransactionsCompanion(
            id: id,
            title: title,
            amount: amount,
            type: type,
            date: date,
            category: category,
            currencyCode: currencyCode,
            createdAt: createdAt,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String title,
            required double amount,
            required String type,
            required DateTime date,
            Value<String?> category = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              FinancialTransactionsCompanion.insert(
            id: id,
            title: title,
            amount: amount,
            type: type,
            date: date,
            category: category,
            currencyCode: currencyCode,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$FinancialTransactionsTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $FinancialTransactionsTable,
        FinancialTransactionData,
        $$FinancialTransactionsTableFilterComposer,
        $$FinancialTransactionsTableOrderingComposer,
        $$FinancialTransactionsTableProcessedTableManager,
        $$FinancialTransactionsTableInsertCompanionBuilder,
        $$FinancialTransactionsTableUpdateCompanionBuilder> {
  $$FinancialTransactionsTableProcessedTableManager(super.$state);
}

class $$FinancialTransactionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $FinancialTransactionsTable> {
  $$FinancialTransactionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get currencyCode => $state.composableBuilder(
      column: $state.table.currencyCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$FinancialTransactionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $FinancialTransactionsTable> {
  $$FinancialTransactionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get currencyCode => $state.composableBuilder(
      column: $state.table.currencyCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$FinancialCategoriesTableInsertCompanionBuilder
    = FinancialCategoriesCompanion Function({
  required String id,
  required String name,
  Value<bool> isCustom,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$FinancialCategoriesTableUpdateCompanionBuilder
    = FinancialCategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<bool> isCustom,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$FinancialCategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FinancialCategoriesTable,
    FinancialCategoryData,
    $$FinancialCategoriesTableFilterComposer,
    $$FinancialCategoriesTableOrderingComposer,
    $$FinancialCategoriesTableProcessedTableManager,
    $$FinancialCategoriesTableInsertCompanionBuilder,
    $$FinancialCategoriesTableUpdateCompanionBuilder> {
  $$FinancialCategoriesTableTableManager(
      _$AppDatabase db, $FinancialCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$FinancialCategoriesTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$FinancialCategoriesTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$FinancialCategoriesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> isCustom = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FinancialCategoriesCompanion(
            id: id,
            name: name,
            isCustom: isCustom,
            createdAt: createdAt,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String name,
            Value<bool> isCustom = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              FinancialCategoriesCompanion.insert(
            id: id,
            name: name,
            isCustom: isCustom,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$FinancialCategoriesTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $FinancialCategoriesTable,
        FinancialCategoryData,
        $$FinancialCategoriesTableFilterComposer,
        $$FinancialCategoriesTableOrderingComposer,
        $$FinancialCategoriesTableProcessedTableManager,
        $$FinancialCategoriesTableInsertCompanionBuilder,
        $$FinancialCategoriesTableUpdateCompanionBuilder> {
  $$FinancialCategoriesTableProcessedTableManager(super.$state);
}

class $$FinancialCategoriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $FinancialCategoriesTable> {
  $$FinancialCategoriesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCustom => $state.composableBuilder(
      column: $state.table.isCustom,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$FinancialCategoriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $FinancialCategoriesTable> {
  $$FinancialCategoriesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCustom => $state.composableBuilder(
      column: $state.table.isCustom,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MonthlyCurrenciesTableInsertCompanionBuilder
    = MonthlyCurrenciesCompanion Function({
  required int year,
  required int month,
  required String currencyCode,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$MonthlyCurrenciesTableUpdateCompanionBuilder
    = MonthlyCurrenciesCompanion Function({
  Value<int> year,
  Value<int> month,
  Value<String> currencyCode,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$MonthlyCurrenciesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MonthlyCurrenciesTable,
    MonthlyCurrencyData,
    $$MonthlyCurrenciesTableFilterComposer,
    $$MonthlyCurrenciesTableOrderingComposer,
    $$MonthlyCurrenciesTableProcessedTableManager,
    $$MonthlyCurrenciesTableInsertCompanionBuilder,
    $$MonthlyCurrenciesTableUpdateCompanionBuilder> {
  $$MonthlyCurrenciesTableTableManager(
      _$AppDatabase db, $MonthlyCurrenciesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MonthlyCurrenciesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$MonthlyCurrenciesTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$MonthlyCurrenciesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> year = const Value.absent(),
            Value<int> month = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MonthlyCurrenciesCompanion(
            year: year,
            month: month,
            currencyCode: currencyCode,
            createdAt: createdAt,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required int year,
            required int month,
            required String currencyCode,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MonthlyCurrenciesCompanion.insert(
            year: year,
            month: month,
            currencyCode: currencyCode,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$MonthlyCurrenciesTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $MonthlyCurrenciesTable,
        MonthlyCurrencyData,
        $$MonthlyCurrenciesTableFilterComposer,
        $$MonthlyCurrenciesTableOrderingComposer,
        $$MonthlyCurrenciesTableProcessedTableManager,
        $$MonthlyCurrenciesTableInsertCompanionBuilder,
        $$MonthlyCurrenciesTableUpdateCompanionBuilder> {
  $$MonthlyCurrenciesTableProcessedTableManager(super.$state);
}

class $$MonthlyCurrenciesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MonthlyCurrenciesTable> {
  $$MonthlyCurrenciesTableFilterComposer(super.$state);
  ColumnFilters<int> get year => $state.composableBuilder(
      column: $state.table.year,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get month => $state.composableBuilder(
      column: $state.table.month,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get currencyCode => $state.composableBuilder(
      column: $state.table.currencyCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MonthlyCurrenciesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MonthlyCurrenciesTable> {
  $$MonthlyCurrenciesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get year => $state.composableBuilder(
      column: $state.table.year,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get month => $state.composableBuilder(
      column: $state.table.month,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get currencyCode => $state.composableBuilder(
      column: $state.table.currencyCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UserHabitsTableInsertCompanionBuilder = UserHabitsCompanion Function({
  required String id,
  required DateTime selectedAt,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$UserHabitsTableUpdateCompanionBuilder = UserHabitsCompanion Function({
  Value<String> id,
  Value<DateTime> selectedAt,
  Value<bool> isActive,
  Value<int> rowid,
});

class $$UserHabitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserHabitsTable,
    UserHabitData,
    $$UserHabitsTableFilterComposer,
    $$UserHabitsTableOrderingComposer,
    $$UserHabitsTableProcessedTableManager,
    $$UserHabitsTableInsertCompanionBuilder,
    $$UserHabitsTableUpdateCompanionBuilder> {
  $$UserHabitsTableTableManager(_$AppDatabase db, $UserHabitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UserHabitsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UserHabitsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$UserHabitsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> selectedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserHabitsCompanion(
            id: id,
            selectedAt: selectedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required DateTime selectedAt,
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserHabitsCompanion.insert(
            id: id,
            selectedAt: selectedAt,
            isActive: isActive,
            rowid: rowid,
          ),
        ));
}

class $$UserHabitsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $UserHabitsTable,
    UserHabitData,
    $$UserHabitsTableFilterComposer,
    $$UserHabitsTableOrderingComposer,
    $$UserHabitsTableProcessedTableManager,
    $$UserHabitsTableInsertCompanionBuilder,
    $$UserHabitsTableUpdateCompanionBuilder> {
  $$UserHabitsTableProcessedTableManager(super.$state);
}

class $$UserHabitsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UserHabitsTable> {
  $$UserHabitsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get selectedAt => $state.composableBuilder(
      column: $state.table.selectedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UserHabitsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UserHabitsTable> {
  $$UserHabitsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get selectedAt => $state.composableBuilder(
      column: $state.table.selectedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$AssessmentsTableTableManager get assessments =>
      $$AssessmentsTableTableManager(_db, _db.assessments);
  $$AssessmentAreaScoresTableTableManager get assessmentAreaScores =>
      $$AssessmentAreaScoresTableTableManager(_db, _db.assessmentAreaScores);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$LifeAreasEvaluationsTableTableManager get lifeAreasEvaluations =>
      $$LifeAreasEvaluationsTableTableManager(_db, _db.lifeAreasEvaluations);
  $$GratitudeEntriesTableTableManager get gratitudeEntries =>
      $$GratitudeEntriesTableTableManager(_db, _db.gratitudeEntries);
  $$DailyGratitudeCompletionsTableTableManager get dailyGratitudeCompletions =>
      $$DailyGratitudeCompletionsTableTableManager(
          _db, _db.dailyGratitudeCompletions);
  $$PhysicalActivitiesTableTableManager get physicalActivities =>
      $$PhysicalActivitiesTableTableManager(_db, _db.physicalActivities);
  $$DailyActivitiesCompletionsTableTableManager
      get dailyActivitiesCompletions =>
          $$DailyActivitiesCompletionsTableTableManager(
              _db, _db.dailyActivitiesCompletions);
  $$WorkoutGroupsTableTableManager get workoutGroups =>
      $$WorkoutGroupsTableTableManager(_db, _db.workoutGroups);
  $$WorkoutRoutinesTableTableManager get workoutRoutines =>
      $$WorkoutRoutinesTableTableManager(_db, _db.workoutRoutines);
  $$TrainingExercisesTableTableManager get trainingExercises =>
      $$TrainingExercisesTableTableManager(_db, _db.trainingExercises);
  $$DailyTrainingSessionsTableTableManager get dailyTrainingSessions =>
      $$DailyTrainingSessionsTableTableManager(_db, _db.dailyTrainingSessions);
  $$DailyTrainingRecordsTableTableManager get dailyTrainingRecords =>
      $$DailyTrainingRecordsTableTableManager(_db, _db.dailyTrainingRecords);
  $$FinancialTransactionsTableTableManager get financialTransactions =>
      $$FinancialTransactionsTableTableManager(_db, _db.financialTransactions);
  $$FinancialCategoriesTableTableManager get financialCategories =>
      $$FinancialCategoriesTableTableManager(_db, _db.financialCategories);
  $$MonthlyCurrenciesTableTableManager get monthlyCurrencies =>
      $$MonthlyCurrenciesTableTableManager(_db, _db.monthlyCurrencies);
  $$UserHabitsTableTableManager get userHabits =>
      $$UserHabitsTableTableManager(_db, _db.userHabits);
}
