import FluentPostgreSQL
import Vapor

final class Torrent: PostgreSQLModel {
    var id: ID?

    var name: String
    var hash: String
    var isPrivate: Bool

    init(id: ID? = nil, name: String, hash: String, isPrivate: Bool) {
        self.id = id
        self.name = name
        self.hash = hash
        self.isPrivate = isPrivate
    }
}