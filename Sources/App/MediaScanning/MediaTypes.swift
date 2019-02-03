protocol Media {}

class Movie: Media {
    let name: String
    let year: Int

    init(name: String, year: Int) {
        self.name = name
        self.year = year
    }
}

class Show: CustomStringConvertible {
    var name: String
    var episodes: [Episode]

    init(name: String, episodes: [Episode] = []) {
        self.name = name
        self.episodes = episodes
    }

    var description: String {
        return "\(name) \(episodes)"
    }
}

class Episode: Media, CustomStringConvertible {
    var show: String
    let season, episode: Int
    var episodeName: String?
    var matched: Bool = false

    init(show: String, season: Int, episode: Int) {
        self.show = show
        self.season = season
        self.episode = episode
        self.episodeName = nil
    }

    var description: String {
        let seasonString = season < 10 ? "0\(season)" : "\(season)"
        let episodeString = episode < 10 ? "0\(episode)" : "\(episode)"
        var nameString = ""
        if let episodeName = episodeName {
            nameString = " - \(episodeName)"
        }
        return "s\(seasonString)e\(episodeString)\(nameString) (\(matched ? "" : "un")matched)"
    }
}