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
    
    func getTdolls() async  throws -> [Tdoll]? {
        guard let request = setRequest(method: "GET", string: "http://localhost:3000/tdolls") else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList
    }
    
    func search(_ search: String, completion: @escaping (_ isSuccess: Bool) -> Void) async throws -> [Tdoll]? {
        guard let request = setRequest(method: "GET", string: "http://localhost:3000/tdolls/search?name=\(search)") else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList
    }
    
    func getTdollByType(type: Tdoll.TdollType) async throws -> [Tdoll]? {
        guard let request = setRequest(method: "GET", string: "http://localhost:3000/tdolls/type/\(type.rawValue)") else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList
    }
    
    func getTdollById(_ id: Int) async throws -> [Tdoll]? {
        guard let request = setRequest(method: "GET", string: "http://localhost:3000/tdolls/\(id)") else { return nil }
        guard let tdollList = try? await getData(with: request) else { return [] }
        return tdollList
    }
    
    
    //Métodos auxiliares
    func setRequest(method: String, string url: String) -> URLRequest?{
        guard let baseURL = URL(string: url) else { return nil}
        var request = URLRequest(url: baseURL)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }

    func getData(with request: URLRequest) async throws -> [Tdoll]?{
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let tdollsList = try? JSONDecoder().decode([Tdoll].self, from: data) else { return [] }
        return tdollsList
    }
}



