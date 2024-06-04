//
//  Network.swift
//  GoghPhotoAI
//
//  Created by Elif Tüm on 28.01.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    private let session = URLSession.shared
    static let shared = NetworkManager()
    private init() {}

    func request<T: Decodable, P: Encodable>(with requestType: RequestType, parameters: P? = nil, completion: @escaping (Result<T, NetworkError>) -> Void) {

        guard let url = requestType.endPoint else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        print(url)
        request.httpMethod = requestType.httpMethod.rawValue

        if request.httpMethod == HttpMethod.POST.rawValue {
            if let parameters = parameters {
                if let jsonData = try? JSONEncoder().encode(parameters) {
                    request.httpBody = jsonData
                    print(jsonData.prettyPrintedJSONString)
                }
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }

        let task = session.dataTask(with: request) { (data, response, error) in
            print("Data:", data?.prettyPrintedJSONString)
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
    
    func request<T: Decodable>(with requestType: RequestType, completion: @escaping (Result<T, NetworkError>) -> Void) {

        guard let url = requestType.endPoint else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        print(url)
        request.httpMethod = requestType.httpMethod.rawValue

        let task = session.dataTask(with: request) { (data, response, error) in
            print("Data:", data?.prettyPrintedJSONString)
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
    
    func requestAF<T: Decodable>(with requestType: RequestType,params:Parameters, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = requestType.endPoint else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)

        AF.request(url, method: .post, parameters: params).response { response in
            if let data = response.data {
                print("Data:", data.prettyPrintedJSONString)
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidData
}


extension Data {
    var prettyPrintedJSONString: NSString? { 
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}





