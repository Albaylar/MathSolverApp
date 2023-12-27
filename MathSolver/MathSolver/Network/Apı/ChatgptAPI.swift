//
//  ChatgptAPI.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 8.12.2023.
//


import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()

    private let model = API.ChatGPTModel
    private let apiKey = API.ChatGPTKey
    private let baseURL = API.ChatGPTapiUrl

    func getChatCompletion(messages: [Message], completion: @escaping (Result<String, Error>) -> Void) {
        
        let messageDictArray = messages.map { $0.asDictionary() }

        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "NetworkServiceError", code: 1, userInfo: nil)))
            return
        }
        let requestBody: [String: Any] = createChatCompletionRequest(messages: messageDictArray)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: apiKey),
            .contentType("application/json")
        ]

        AF.request(url, method: .post, parameters: requestBody, encoding: JSONEncoding.default, headers: headers)
          .responseJSON { response in
              switch response.result {
              case .success(let value):
                  if let json = value as? [String: Any],
                     let assistantResponse = (json["choices"] as? [[String: Any]])?.first?["message"] as? [String: String],
                     let content = assistantResponse["content"] {
                      completion(.success(content))
                  } else {
                      completion(.failure(NSError(domain: "NetworkServiceError", code: 3, userInfo: nil)))
                  }
              case .failure(let error):
                  completion(.failure(error))
              }
          }
    }
    private func createChatCompletionRequest(messages: [[String: String]]) -> [String: Any] {
        return [
            "model": model,
            "messages": messages,
            "temperature": 0,
        ]
    }
}


