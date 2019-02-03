import Foundation

protocol APIResource {
	associatedtype Model
	var methodPath: String { get }
    var queryParams: [String: String] { get }
	func makeModel(data: Data) -> Model
}

extension APIResource {
	var url: URL {
		let baseURL = "https://api.themoviedb.org/3"
        let params = queryParams.map { "\($0)=\($1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)" }.joined(separator: "&")
        let url = "\(baseURL)/\(methodPath)?\(params)"
		return URL(string: url)!
	}
}

struct ShowsResource: APIResource {
	let methodPath = "search/tv"
    let apiKey: String
    let query: String
    var queryParams: [String: String] {
        return [
            "api_key": apiKey,
            "query": query
        ]
    }
	
	func makeModel(data: Data) -> [ShowResult] {
        let decoder = JSONDecoder()
        let wrapper = try? decoder.decode(ShowWrapper.self, from: data)
        return wrapper?.results ?? []
	}
}