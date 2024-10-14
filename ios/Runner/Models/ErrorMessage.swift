//
//  ErrorMessage.swift
//  Runner
//
//  Created by Joel Asencios on 12/10/24.
//
import Foundation
struct ErrorMessage : Codable {
    let title: String
    let description: String
    let displayDuration: Double
    
    init(_ title: String,_ description: String,_ displayDuration: Double){
        self.title = title
        self.description = description
        self.displayDuration = displayDuration
    }
    
    init(_ jsonString :String){
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let myStruct = try! decoder.decode(ErrorMessage.self, from: jsonData)
        self.title = myStruct.title
        self.description = myStruct.description
        self.displayDuration = myStruct.displayDuration
    }
}

