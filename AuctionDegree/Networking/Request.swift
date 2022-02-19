//
//  Request.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 01.01.2022.
//

import Foundation

class NetworkEngine {
    class func request<T: Codable>(endpoint: UrlProtocol, bodyReq: Dictionary<String, Any>?, completion: @escaping(Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        components.port = 8087
        guard let url = components.url else { return }
        debugPrint("created URL \(url)")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let body = bodyReq {
            debugPrint("created body \(body)")
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
        }
        let session = URLSession(configuration: .default)
        print(session)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                print("response data \(String(decoding: data, as: UTF8.self))")
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch (let error) {
                    debugPrint(error)
                    completion(.failure(error))
                }
//                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
//                    completion(.success(responseObject))
//                } else {
//                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey : "Failed to decode response"])
//                    completion(.failure(error))
//                }
            }

        }
        dataTask.resume()
    }
}
