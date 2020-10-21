// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CanchaDao _canchaDaoInstance;

  DiaryDao _diaryDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Cancha` (`id` INTEGER, `name` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Diary` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `fecha` TEXT, `id_cancha` INTEGER, `userName` TEXT, FOREIGN KEY (`id_cancha`) REFERENCES `Cancha` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CanchaDao get canchaDao {
    return _canchaDaoInstance ??= _$CanchaDao(database, changeListener);
  }

  @override
  DiaryDao get diaryDao {
    return _diaryDaoInstance ??= _$DiaryDao(database, changeListener);
  }
}

class _$CanchaDao extends CanchaDao {
  _$CanchaDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _canchaInsertionAdapter = InsertionAdapter(
            database,
            'Cancha',
            (Cancha item) =>
                <String, dynamic>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Cancha> _canchaInsertionAdapter;

  @override
  Future<List<Cancha>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Cancha',
        mapper: (Map<String, dynamic> row) =>
            Cancha(row['id'] as int, row['name'] as String));
  }

  @override
  Future<Cancha> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM Cancha WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) =>
            Cancha(row['id'] as int, row['name'] as String));
  }

  @override
  Future<void> insertCancha(Cancha canchas) async {
    await _canchaInsertionAdapter.insert(canchas, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertCanchas(List<Cancha> canchas) {
    return _canchaInsertionAdapter.insertListAndReturnIds(
        canchas, OnConflictStrategy.abort);
  }
}

class _$DiaryDao extends DiaryDao {
  _$DiaryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _diaryInsertionAdapter = InsertionAdapter(
            database,
            'Diary',
            (Diary item) => <String, dynamic>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'id_cancha': item.idCancha,
                  'userName': item.userName
                }),
        _diaryDeletionAdapter = DeletionAdapter(
            database,
            'Diary',
            ['id'],
            (Diary item) => <String, dynamic>{
                  'id': item.id,
                  'fecha': item.fecha,
                  'id_cancha': item.idCancha,
                  'userName': item.userName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Diary> _diaryInsertionAdapter;

  final DeletionAdapter<Diary> _diaryDeletionAdapter;

  @override
  Future<List<Diary>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Diary',
        mapper: (Map<String, dynamic> row) => Diary(
            row['id'] as int,
            row['fecha'] as String,
            row['id_cancha'] as int,
            row['userName'] as String));
  }

  @override
  Future<Diary> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM Diary WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Diary(
            row['id'] as int,
            row['fecha'] as String,
            row['id_cancha'] as int,
            row['userName'] as String));
  }

  @override
  Future<List<Diary>> findByDate(int idCancha, String fecha) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Diary WHERE id_cancha = ? AND fecha = ?',
        arguments: <dynamic>[idCancha, fecha],
        mapper: (Map<String, dynamic> row) => Diary(
            row['id'] as int,
            row['fecha'] as String,
            row['id_cancha'] as int,
            row['userName'] as String));
  }

  @override
  Future<int> insertDiary(Diary diary) {
    return _diaryInsertionAdapter.insertAndReturnId(
        diary, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteDiary(Diary diary) {
    return _diaryDeletionAdapter.deleteAndReturnChangedRows(diary);
  }
}
