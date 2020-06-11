//
//  Banco.swift
//  Reusable Filter
//
//  Created by Marcelly Luise on 11/06/20.
//  Copyright © 2020 Celly Inc.,. All rights reserved.
//

import UIKit

class Banco: Codable {
    let name: String
    let codigo: String
    
    init(name: String, codigo: String) {
        self.name = name
        self.codigo = codigo
    }
}
