//
//  Message.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 8.12.2023.
//

import Foundation

struct Message: Codable {
    
    let role: String
    let content: String
    
    func asDictionary() -> [String: String] {
        return ["role": role, "content": content]
    }
}
