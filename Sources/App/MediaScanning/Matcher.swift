import Foundation

class Matcher {
    typealias MatchDefinition = (season: Int, episode: Int)

    private static let initialPatterns = [
        "S(\\d+)E(\\d+)": MatchDefinition(season: 1, episode: 2)
    ]

    private static let nameTransforms = [
        "\\.$": "",
        "\\.": " ",
        " $": ""
    ]

    static func episode(filename: String) -> Episode? {
        var show: String
        var season: Int? = nil
        var episode: Int? = nil
        var episodeRange: Range<String.Index>? = nil

        for (expression, matchDef) in initialPatterns {
            let regex = try? NSRegularExpression(pattern: expression)

            if let result = regex?.firstMatch(in: filename, range: NSRange(filename.startIndex..., in: filename)) {
                episodeRange = Range(result.range, in: filename)
                if let subrange = Range(result.range(at: matchDef.season), in: filename) {
                    season = Int(filename[subrange])
                }
                if let subrange = Range(result.range(at: matchDef.episode), in: filename) {
                    episode = Int(filename[subrange])
                }
                break
            }
        }

        if let season = season, let episode = episode, let episodeRange = episodeRange {
            show = String(filename[..<episodeRange.lowerBound])
            for (search, replace) in nameTransforms {
                let regex = try? NSRegularExpression(pattern: search)
                let range = NSRange(show.startIndex..., in: show)
                if let newString = regex?.stringByReplacingMatches(in: show, options: [], range: range, withTemplate: replace) {
                    show = newString
                }
            }
            return Episode(show: show, season: season, episode: episode)
        }
        else {
            print("ruh roh, we matched without filling, or didn't match at all!")
            return nil
        }
    }
}