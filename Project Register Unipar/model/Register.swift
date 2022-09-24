//
//  Register.swift
//  Project Register Unipar
//
//  Created by Celio Ferreira on 16/09/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Register: Identifiable, Codable {
    
    @DocumentID var id: String?
    
    var title: String
    var fornecedor: String
    var phone: String
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case fornecedor
        case phone 
        case image
    }
}
