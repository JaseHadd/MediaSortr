import FluentPostgreSQL
import Vapor

final class Torrent: PostgreSQLModel {
    var id: Int?

    var name: String
    var hash: String
    var isPrivate: Bool

    init(id: Int? = nil, name: String, hash: String, isPrivate: Bool) {
        self.id = id
        self.name = name
        self.hash = hash
        self.isPrivate = isPrivate
    }
}

extension Torrent: Content { }
extension Torrent: Parameter { }
extension Torrent: PostgreSQLMigration { }