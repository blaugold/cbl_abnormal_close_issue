import 'package:cbl/cbl.dart';
import 'package:cbl_dart/cbl_dart.dart';

void main() async {
  await CouchbaseLiteDart.init(edition: Edition.enterprise);
  Database.log.console.level = LogLevel.info;

  final db = await Database.openAsync('db');

  try {
    final collection = await db.createCollection('test', 'test');

    final document = (await collection.document('test'))?.toMutable() ??
        MutableDocument.withId('test');
    document.setDate(DateTime.now(), key: 'now');
    await collection.saveDocument(document);

    final replicator = await Replicator.createAsync(
      ReplicatorConfiguration(
        target: UrlEndpoint(
          Uri.parse('wss://4sechbkxbpm-yxf4.apps.cloud.couchbase.com/test'),
        ),
        authenticator: BasicAuthenticator(
          username: 'test',
          password: 'asdfASDF.1',
        ),
      )..addCollection(collection),
    );

    final done = replicator
        .changes()
        .where((change) =>
            change.status.activity == ReplicatorActivityLevel.stopped)
        .first;
    await replicator.start();
    await done;
  } finally {
    await db.close();
  }
}
