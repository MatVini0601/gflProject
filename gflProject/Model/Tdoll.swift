//
//  Tdoll.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import Foundation

struct Tdoll: Decodable{
    let id: Int
    let image: String
    let name: String
    let manufacturer: String
    let type: TdollType

    enum TdollType: Decodable{
        case AR
        case SMG
        case ST
        case MG
        case HG
        case RF
    }
}
