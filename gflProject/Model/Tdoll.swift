//
//  Tdoll.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import Foundation
    

class TdollModel{
    
    private let baseURL = "http://localhost:3000/tdolls"
    
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
        
        guard var request = setRequest(method: "POST", string: baseURL) else { return }
        
        let tdoll: [String: Any] = [
            "id" : tdoll.id,
            "image": tdoll.image,
            "name": tdoll.name,
            "tier": tdoll.tier,
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
        guard let request = setRequest(method: "GET", string: baseURL) else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList
    }
    
    func search(_ search: String) async throws -> [Tdoll]? {
        guard let request = setRequest(method: "GET", string: "\(baseURL)/search?name=\(search)") else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList
    }
    
    func deleteTdoll(_ id: Int, completion: @escaping (_ deleted: Bool) -> Void){
        guard let request = setRequest(method: "DELETE", string: "\(baseURL)\(id)") else { return }
            URLSession.shared.dataTask(with: request) { _, _, error in
                error != nil ? completion(true) : completion(false)
            }
    }
    
    func getTdollByType(type: Tdoll.TdollType) async throws -> [Tdoll]? {
        guard let request = setRequest(method: "GET", string: "\(baseURL)/type/\(type.rawValue)") else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList
    }
    
    func getTdollById(_ id: Int) async throws -> Tdoll? {
        guard let request = setRequest(method: "GET", string: "\(baseURL)\(id)") else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList.first
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
            "type": tdoll.type.rawValue,
            "tier": tdoll.tier
        ]
        
        guard var request = setRequest(method: "PATCH", string: "\(baseURL)\(id)") else { return }
        
        let body = try? JSONSerialization.data(withJSONObject: updateTdoll, options: [])
        request.httpBody = body
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { completion(false, .ServerError); return }
        completion(true, .NoError)
    }
    
    func getTdollGallery(_ id: Int) async throws -> [galleryLinks]?{
        guard let request = setRequest(method: "GET", string: "\(baseURL)/gallery/\(id)") else { return nil }
        let (data, _) = try await URLSession.shared.data(for: request)
        do{
            let gallery = try JSONDecoder().decode([galleryLinks].self, from: data)
            return gallery
        }catch let error as DecodingError{
            print(error.localizedDescription)
        }
        return nil
    }
    
    func getTdollTags(_ id: Int) async throws -> [tdollTags]?{
        guard let request = setRequest(method: "GET", string: "\(baseURL)/tags/\(id)") else { return nil }
        let (data, _) = try await URLSession.shared.data(for: request)
        do{
            let gallery = try JSONDecoder().decode([tdollTags].self, from: data)
            return gallery
        }catch let error as DecodingError{
            print(error.localizedDescription)
        }
        return nil
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
        do{
            let tdollsList = try JSONDecoder().decode([Tdoll].self, from: data)
            return tdollsList
        }catch let error as DecodingError{
            print(error.localizedDescription)
        }
        return []
    }
    
    private func validateTdoll(_ tdoll: Tdoll) -> errorTypes {
        if tdoll.id < 0 { return .NegativeID }
        if tdoll.image.isEmpty || tdoll.name.isEmpty || tdoll.manufacturer.isEmpty { return .RequiredFieldEmpty }
        return .NoError
    }
    
    struct galleryLinks: Decodable, Hashable{
        let image_link: String
        let model_name: String
    }
    
    struct tdollTags: Decodable, Hashable{
        let tagName: String
    }
}



