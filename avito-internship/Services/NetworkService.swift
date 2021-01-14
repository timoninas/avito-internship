import Foundation

protocol NetworkServiceProtocol: class {
    func fetchCatalog(completion: @escaping (Result<Welcome?, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    func fetchCatalog(completion: @escaping (Result<Welcome?, Error>) -> ()) {
        let response = jsonResponse
        guard let jsonResponseData: Data = response.data(using: .utf8) else { return }
        do {
            let welcome = try JSONDecoder().decode(Welcome.self, from: jsonResponseData)
            completion(.success(welcome))
        } catch let jsonError {
            completion(.failure(jsonError))
        }
    }
}
