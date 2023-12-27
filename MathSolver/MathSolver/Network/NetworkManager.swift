//
//  NetworkManager.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 11.12.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchMathSteps(for question: String, completion: @escaping (Result<String, Error>) -> Void) {
        let newQuery = "I want you to act like a mathematician. I will write mathematical expressions and you will answer with the result of the calculation of the expression. I want you to answer step by step. The steps should be in the order Step-1, Step-2, Step-3. Give the final solution as Solution: answer but only answer, no explanation. The solution should be just the solution, not any words. When I need to tell you something in English, I will do it by putting the text in square brackets {like this}. And this expression will be a latex expression. Again, I don't want any words. My first expression: {\(question)}"

        NetworkService.shared.getChatCompletion(messages: [Message(role: "user", content: newQuery)]) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    func fetchChatGPTResponse(for query: String, completion: @escaping (Result<String, Error>) -> Void) {
            let fullQuery = query + "What is the result of this question? Don't write any words, just the result."
            
            NetworkService.shared.getChatCompletion(messages: [Message(role: "user", content: fullQuery)]) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
}


