//
//  Tdoll.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import Foundation
    

class TdollModel{
    struct Tdoll: Decodable{
    let id: Int
    let image: String
    let name: String
    let manufacturer: String
    let type: TdollType

        enum TdollType: String, Decodable{
            case AR = "AR"
            case SMG = "SMG"
            case ST = "ST"
            case MG = "MG"
            case HG = "HG"
            case RF = "RF"
        }
    }

    func post(_ tdoll: Tdoll, completion: @escaping (_ isSuccess: Bool) -> Void){
        guard let baseURL = URL(string: "http://localhost:3000/tdolls") else { return }
        let tdoll: [String: Any] = [
            "id" : tdoll.id,
            "image": tdoll.image,
            "name": tdoll.name,
            "manufacturer": tdoll.manufacturer,
            "type": tdoll.type.rawValue
        ]
        let body = try? JSONSerialization.data(withJSONObject: tdoll, options: [])
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                completion(true)
                return
            }
            completion(false)
        }.resume()
    }
}



