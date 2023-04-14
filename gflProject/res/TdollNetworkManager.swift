//
//  TdollNetworkManager.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 21/03/23.
//

import Foundation

class TdollNetworkManager: NSObject{
    static let shared = TdollNetworkManager()
    private let BASE_URL = "http://localhost:3000/tdolls"
    
    func post(_ tdoll: Tdoll.tdollData, completion: @escaping (_ isSuccess: Bool,_ error: TdollConnectionError) -> Void) async throws{
        guard var request = setRequest(method: .POST, string: BASE_URL) else {
            completion(false, .ServerError)
            return
        }
        
        let tdoll: [String: Any] = [
            "id" : tdoll.id,
            "image": tdoll.image,
            "name": tdoll.name,
            "tier": tdoll.tier,
            "manufacturer": tdoll.manufacturer,
            "type": tdoll.type.rawValue,
            "hasMindUpgrade": tdoll.hasMindUpgrade ?? 0
        ]
        
        let body = try? JSONSerialization.data(withJSONObject: tdoll, options: [])
        request.httpBody = body
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 201 else { completion(false, .ServerError); return }
        completion(true, .NoError)
    }
    
    func getTdolls() async  throws -> [Tdoll.tdollData]? {
        guard let request = setRequest(method: .GET, string: BASE_URL) else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList
    }
    
    func getTdollById(_ id: Int) async throws -> Tdoll.tdollData? {
        let endpoint = "\(BASE_URL)\(id)"
        guard let request = setRequest(method: .GET, string: endpoint) else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList.first
    }
    
    func getTdollByType(type: Tdoll.TdollType) async throws -> [Tdoll.tdollData]? {
        let endpoint = "\(BASE_URL)/type/\(type.rawValue)"
        guard let request = setRequest(method: .GET, string: endpoint) else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList
    }
    
    func search(_ search: String) async throws -> [Tdoll.tdollData]? {
        let endpoint = "\(BASE_URL)/search?name=\(search)"
        guard let request = setRequest(method: .GET, string: endpoint) else { return nil }
        guard let tdollList = try? await getData(with: request) else { return nil }
        return tdollList
    }
    
    func deleteTdoll(_ id: Int, completion: @escaping (_ deleted: Bool, _ error: TdollConnectionError) -> Void){
        let endpoint = "\(BASE_URL)/\(id)"
        guard let request = setRequest(method: .DELETE, string: endpoint) else {
            completion(false, .ServerError)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            error == nil ? completion(true, .NoError) : completion(false, .DeleteError)
        }.resume()
    }
    
    func updateTdoll(_ id: Int, _ tdoll: Tdoll.tdollData,  completion: @escaping (_ isSuccess: Bool,_ error: TdollConnectionError) -> Void) async throws{
        guard var request = setRequest(method: .PATCH, string: "\(BASE_URL)/\(id)") else { return }
        
        let updateTdoll: [String: Any] = [
            "id" : tdoll.id,
            "image": tdoll.image,
            "name": tdoll.name,
            "tier": tdoll.tier,
            "manufacturer": tdoll.manufacturer,
            "type": tdoll.type.rawValue,
            "hasMindUpgrade": tdoll.hasMindUpgrade ?? 0
        ]
        
        let body = try? JSONSerialization.data(withJSONObject: updateTdoll, options: [])
        request.httpBody = body
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { completion(false, .ServerError); return }
        completion(true, .NoError)
    }
    
    
    // MARK: Métodos auxiliares
    private func setRequest(method: TdollURLMethods, string urlString: String) -> URLRequest?{
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    private func getData(with request: URLRequest) async throws -> [Tdoll.tdollData]?{
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let tdollsList = try? JSONDecoder().decode([Tdoll.tdollData].self, from: data) else { return [] }
            return tdollsList
        }catch let error as DecodingError{
            print(error.localizedDescription)
        }
        return []
    }
}
extension TdollNetworkManager{
    //MARK: Error this class can throw
    enum TdollConnectionError: String, Error{
        case RequiredFieldEmpty = "Campos Obrigatorios não preenchidos"
        case NegativeID = "Campo ID não pode ser menor que zero"
        case ServerError = "Servidor: Erro ao tentar salvar nova Tdoll"
        case DeleteError = "Erro ao deletar Tdoll"
        case NoError
    }
    
    //MARK: Accepted methods
    enum TdollURLMethods: String{
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
        case PATCH = "PATCH"
    }
}
