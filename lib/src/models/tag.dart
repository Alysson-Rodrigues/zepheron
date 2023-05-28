import 'package:nyxx/nyxx.dart';
import 'package:postgres/postgres.dart';

/// A simple tag with name and content.
class Tag {
  /// The name of this tag.
  final String name;

  /// The content of this tag.
  final String content;

  /// Whether the tag  is enabled.
  bool enabled;

  /// The ID of the guild this tag belongs to.
  final Snowflake guildId;

  /// The ID of the user this tag belongs to.
  final Snowflake authorId;

  /// The id of this tag, or `null` if this tag has not been inserted into the database.
  int? id;

  /// Create a new [Tag].
  Tag({
    required this.name,
    required this.content,
    required this.enabled,
    required this.guildId,
    required this.authorId,
    this.id,
  });

  /// Create a [Tag] from a database row.
  factory Tag.fromRow(PostgreSQLResultRow row) {
    final mappedRow = row.toColumnMap();

    return Tag(
      name: mappedRow['name'] as String,
      content: mappedRow['content'] as String,
      enabled: mappedRow['enabled'] as bool,
      guildId: Snowflake(mappedRow['guild_id'] as String),
      authorId: Snowflake(mappedRow['author_id'] as String),
      id: mappedRow['id'] as int,
    );
  }
}

class TagUsedEvent {
  final int tagId;
  final DateTime usedAt;
  final bool hidden;

  TagUsedEvent({
    required this.tagId,
    required this.usedAt,
    required this.hidden,
  });

  factory TagUsedEvent.fromTag({
    required Tag tag,
    required DateTime usedAt,
    required bool hidden,
  }) =>
      TagUsedEvent(
        tagId: tag.id!,
        usedAt: usedAt,
        hidden: hidden,
      );

  factory TagUsedEvent.fromRow(PostgreSQLResultRow row) {
    final mappedRow = row.toColumnMap();

    return TagUsedEvent(
      tagId: mappedRow['command_id'] as int,
      usedAt: mappedRow['use_date'] as DateTime,
      hidden: mappedRow['hidden'] as bool,
    );
  }
}
