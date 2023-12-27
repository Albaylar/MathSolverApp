//
//  MathPixAPI.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 8.12.2023.
//

import Foundation
import Alamofire

enum MathpixError: Error {
    case invalidURL
    case decodingError
    case customError(message: String)
}

class MathpixAPI {
    private static let apiUrl = API.MathPiapiUrl
    private static let appID = API.MathPiappID
    private static let apiKey = API.MathPixapiKey

    static func parseLatex(imageBase64: String, completion: @escaping (Result<String, MathpixError>) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "app_id": appID,
            "app_key": apiKey
        ]

        let parameters: [String: Any] = [
            "src": imageBase64,
            "math_inline_delimiters": ["$", "$"],
            "rm_spaces": true
        ]

        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let responseDict = value as? [String: Any], let latex = responseDict["latex"] as? String {
                        completion(.success(latex))
                    } else {
                        completion(.failure(MathpixError.customError(message: "Invalid response format")))
                    }
                case .failure(let error):
                    completion(.failure(MathpixError.customError(message: "Error: \(error.localizedDescription)")))
                }
            }
    }
}





