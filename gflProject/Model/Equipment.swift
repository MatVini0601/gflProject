//
//  Equipment.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import Foundation

struct Equipment: Decodable{
    let id: Int
    let image: String
    let name: String
    let type: EquipmentType
    
    enum EquipmentType: Decodable{
        case ACCESSORIES
        case MAGAZINE
        case TDOLL
    }
}
