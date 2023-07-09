class Tables {
  Tables._();

  ///region DutyTypeTable

  static const dutyTypeTableName = 'duty_type';

  static const List<String> dutyTypeColumnNames = ['id', 'name'];

  static final String dutyTypeTableCreateCommand = '''
  CREATE TABLE $dutyTypeTableName (
  ${dutyTypeColumnNames[0]} INTEGER NOT NULL,
  ${dutyTypeColumnNames[1]} TEXT NOT NULL,
  PRIMARY KEY(${dutyTypeColumnNames[0]} AUTOINCREMENT)  
  );
  ''';

  ///endregion DutyTypeTable

  ///region DutyTable

  static const dutyTableName = 'duty';

  static const List<String> dutyColumnNames = ['id', 'title', 'done', 'type_id'];

  static final dutyTableCreateCommand = '''
  CREATE TABLE $dutyTableName (
	${dutyColumnNames[0]}	INTEGER NOT NULL,
	${dutyColumnNames[1]}	TEXT NOT NULL,
	${dutyColumnNames[2]} INTEGER NOT NULL,
	${dutyColumnNames[3]} INTEGER NOT NULL,
	PRIMARY KEY(${dutyColumnNames[0]} AUTOINCREMENT),
	FOREIGN KEY(${dutyColumnNames[3]}) REFERENCES $dutyTypeTableName(${dutyTypeColumnNames[0]})
  );
  ''';

  ///endregion DutyTable
}
