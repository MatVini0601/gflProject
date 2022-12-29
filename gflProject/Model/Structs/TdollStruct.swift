//
//  TdollStruct.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 05/09/22.
//

import Foundation

struct Tdoll: Decodable, Hashable{
    let id: Int
    let image: String
    let name: String
    let tier: Int
    let manufacturer: String
    let type: TdollType
    let hasMindUpgrade: Int?


    enum TdollType: String, Decodable{
        case AR = "AR"
        case SMG = "SMG"
        case SG = "SG"
        case MG = "MG"
        case HG = "HG"
        case RF = "RF"
    }
}
