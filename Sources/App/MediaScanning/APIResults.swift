struct ShowWrapper: Decodable {
    let page, totalResults, totalPages: Int
    let results: [ShowResult]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct ShowResult: Decodable {
    let id: Int
    let name, originalName: String
    let originCountries: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case originCountries = "origin_country"
    }
}