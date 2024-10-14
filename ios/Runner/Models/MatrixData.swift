//
//  MatrixData.swift
//  Runner
//
//  Created by Joel Asencios on 12/10/24.
//
import Foundation
struct MatrixData : Codable {
    let title: String
    let buttonText: String
    let matrix: [[String]]
    
    init(_ title: String,_ buttonText: String,_ matrix:[[String]]){
        self.title = title
        self.matrix = matrix
        self.buttonText = buttonText
    }
    
    init(_ jsonString :String){
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let myStruct = try! decoder.decode(MatrixData.self, from: jsonData)
        self.title = myStruct.title
        self.matrix = myStruct.matrix
        self.buttonText = myStruct.buttonText
    }
    
    func getStringMatrix()-> String{
        var result = ""
        for x in 0..<matrix.count {
            for y in 0..<matrix.count {
                result.append(" " + matrix[x][y])
            }
            result.append("\n")
        }
        return result
    }
}
