//
//  Tags.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 29/11/22.
//

import Foundation

class Tags {
    private let baseURL = "http://localhost:3000/tdolls"
    private var tagsSize = 0
    
    struct tagData: Decodable, Hashable{
        let tagName: String
    }
    
    //MARK: Functions
    func getTags(_ id: Int) async throws -> [tagData]?{
        guard let request = setRequest(method: "GET", string: "\(baseURL)/tags/\(id)") else { return nil }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return nil }
        do{
            let tags = try JSONDecoder().decode([tagData].self, from: data)
            tagsSize = tags.count
            return tags
        }catch let error as DecodingError{
            print(error.localizedDescription)
        }
        return nil
    }
    
    func hasTags(_ id: Int) -> Bool {
        return tagsSize > 0
    }
    
    
    //MARK: AUX
    private func setRequest(method: String, string url: String) -> URLRequest?{
        guard let EPurl = URL(string: url) else { return nil }
        var request = URLRequest(url: EPurl)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
}
