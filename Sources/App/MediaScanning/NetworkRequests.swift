import Foundation
import Vapor

protocol NetworkRequest: class {
	associatedtype Model
	func load(in container: Container, withCompletion completion: @escaping (Model?) -> Void)
	func decode(_ data: Data) -> Model?
}

extension NetworkRequest {
	fileprivate func load(_ url: URL, in container: Container, withCompletion completion: @escaping (Model?) -> Void) {
		let client = try? container.client()
		if let res = client?.get(url) {
			res.do { response in
				guard let data = response.http.body.data else {
					return
				}
				completion(self.decode(data))
			}.catch { _ in completion(nil) }
		} else {
			print("Ruh roh")
		}
	}
}

class APIRequest<Resource: APIResource> {
	let resource: Resource
	
	init(resource: Resource) {
		self.resource = resource
	}
}

extension APIRequest: NetworkRequest {
	func decode(_ data: Data) -> Resource.Model? {
		return resource.makeModel(data: data)
	}
	
	func load(in container: Container, withCompletion completion: @escaping (Resource.Model?) -> Void) {
		load(resource.url, in: container, withCompletion: completion)
	}
}
