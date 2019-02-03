import Vapor
import Jobs

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    Jobs.add(interval: .seconds(60 * 15)) {
        var inputFiles = [
            "Crazy.Cakes.S01E07.Castles.Coral.and.Camo.Cakes.720p.WEB.x264-KOMPOST.mkv",
            "The.Numbers.Game.S02E02.Are.You.a.Sucker.720p.HDTV.x264-DHD.mkv",
            "Shameless.US.S09E09.Boooooooooooone.720p.AMZN.WEB-DL.DDP5.1.H.264-NTb.mkv"
        ]

        let episodes = inputFiles.map { Matcher.episode(filename: $0) }.compactMap { $0 }
        let shows = Dictionary(grouping: episodes, by: { $0.show }).map { Show(name: $0, episodes: $1) }
        
        let apiKey = ""
        for show in shows {
            let resource = ShowsResource(apiKey: apiKey, query: show.name)
            let request = APIRequest(resource: resource)
            request.load(in: app) { (results: [ShowResult]?) in
                guard let shows = results else { return }
                for showResult in shows {
                    guard showResult.name.distance(to: show.name) < 4 else {
                        print("Non-match: \(showResult.name) -> \(show.name) [ \(showResult.name.distance(to:show.name))")
                        continue
                    }

                    print("Found match: \(showResult.name)")
                    if(showResult.name != show.name) {
                        print("Changing name from \(show.name) to \(showResult.name)")
                        show.name = showResult.name
                    }
                    print("New data: ")
                    print(show)

                    break
                }
            }
        }
    }
}