import Vapor

/// Controls basic CRUD operations on `Torrent`s.
final class TorrentController {
    /// Returns a list of all `Torrent`s.
    func index(_ req: Request) throws -> Future<[Torrent]> {
        return Torrent.query(on: req).all()
    }

    /// Saves a decoded `Torrent` to the database.
    func create(_ req: Request) throws -> Future<Torrent> {
        return try req.content.decode(Torrent.self).flatMap { Torrent in
            return Torrent.save(on: req)
        }
    }

    /// Deletes a parameterized `Torrent`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Torrent.self).flatMap { Torrent in
            return Torrent.delete(on: req)
        }.transform(to: .ok)
    }
}
