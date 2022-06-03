//
//  User.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import Foundation

struct User: Decodable{
    let id: Int
    let email: String
    let password: String
    let image: String
}
