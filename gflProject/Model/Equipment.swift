//
//  Equipment.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import Foundation


class EquipmentModel{
    struct Equipment: Decodable{
        let id: Int
        let image: String
        let name: String
        let type: EquipmentType
        
        enum EquipmentType: String, Decodable{
            case ACCESSORIES = "Accessories"
            case MAGAZINE = "Magazine"
            case TDOLL = "Tdoll"
        }
    }
    
    func getEquipments() async  throws -> [Equipment]? {
        guard let request = setRequest(method: "GET", string: "http://localhost:3000/equipments") else { return nil }
        guard let equipmentList = try? await getData(with: request) else { return nil }
        return equipmentList
    }
    
    func search(_ search: String) async throws -> [Equipment]? {
        guard let request = setRequest(method: "GET", string: "http://localhost:3000/equipments/search?name=\(search)") else { return nil }
        guard let equipmentList = try? await getData(with: request) else { return nil }
        return equipmentList
    }
    
    func setRequest(method: String, string url: String) -> URLRequest?{
        guard let baseURL = URL(string: url) else { return nil}
        var request = URLRequest(url: baseURL)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }

    func getData(with request: URLRequest) async throws -> [Equipment]?{
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let equipmentList = try? JSONDecoder().decode([Equipment].self, from: data) else { return [] }
        return equipmentList
    }
}
