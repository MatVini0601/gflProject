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
            case SG = "SG"
            case MG = "MG"
            case HG = "HG"
            case RF = "RF"
        }
    }
    
    enum errorTypes: String{
        case RequiredFieldEmpty = "Campos Obrigatorios não preenchidos"
        case NegativeID = "Campo ID não pode ser menor que zero"
        case ServerError = "Servidor: Erro ao tentar salvar nova Tdoll"
        case NoError
    }

    func post(_ tdoll: Tdoll, completion: @escaping (_ isSuccess: Bool,_ error: errorTypes) -> Void) async throws{
        let validation = validateTdoll(tdoll)
        switch(validation){
            case .RequiredFieldEmpty:
                completion(false, .RequiredFieldEmpty)
                return
            case .NegativeID:
                completion(false, .NegativeID)
                return
            default: break
        }
        
        guard var request = setRequest(method: "POST", string: "http://localhost:3000/tdolls") else { return }
        
        let tdoll: [String: Any] = [
            "id" : tdoll.id,
            "image": tdoll.image,
            "name": tdoll.name,
            "manufacturer": tdoll.manufacturer,
            "type": tdoll.type.rawValue
        ]
        
        let body = try? JSONSerialization.data(withJSONObject: tdoll, options: [])
        request.httpBody = body
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 201 else { completion(false, .ServerError); return }
        completion(true, .NoError)
    }
    
    func getTdolls() async  throws -> [Tdoll]? {
        guard let request = setRequest(method: "GET", string: "http://localhost:3000/tdolls") else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList
    }
    
    func search(_ search: String) async throws -> [Tdoll]? {
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
    
    func updateTdoll(_ id: Int, _ tdoll: Tdoll,  completion: @escaping (_ isSuccess: Bool,_ error: errorTypes) -> Void) async throws{
        let validation = validateTdoll(tdoll)
        switch(validation){
            case .RequiredFieldEmpty:
                completion(false, .RequiredFieldEmpty)
                return
            case .NegativeID:
                completion(false, .NegativeID)
                return
            default: break
        }
        
        let updateTdoll: [String: Any] = [
            "image": tdoll.image,
            "name": tdoll.name,
            "manufacturer": tdoll.manufacturer,
            "type": tdoll.type.rawValue
        ]
        
        guard var request = setRequest(method: "PATCH", string: "http://localhost:3000/tdolls/\(id)") else { return }
        
        let body = try? JSONSerialization.data(withJSONObject: updateTdoll, options: [])
        request.httpBody = body
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { completion(false, .ServerError); return }
        completion(true, .NoError)
    }
    
    
    // MARK: Métodos auxiliares
    private func setRequest(method: String, string url: String) -> URLRequest?{
        guard let baseURL = URL(string: url) else { return nil}
        var request = URLRequest(url: baseURL)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }

    private func getData(with request: URLRequest) async throws -> [Tdoll]?{
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let tdollsList = try? JSONDecoder().decode([Tdoll].self, from: data) else { return [] }
        return tdollsList
    }
    
    private func validateTdoll(_ tdoll: Tdoll) -> errorTypes {
        if tdoll.id < 0 { return .NegativeID }
        if tdoll.image.isEmpty || tdoll.name.isEmpty || tdoll.manufacturer.isEmpty { return .RequiredFieldEmpty }
        return .NoError
    }
}



