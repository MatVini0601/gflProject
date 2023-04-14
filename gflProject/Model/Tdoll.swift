//
//  Tdoll.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import Foundation
    

class Tdoll{
    struct tdollData: Decodable, Hashable{
        let id: Int
        let image: String
        let name: String
        let tier: Int
        let manufacturer: String
        let type: Tdoll.TdollType
        let hasMindUpgrade: Int?
    }
    
    func getTdoll(_ id: Int) async -> tdollData?{
        do {
            return try await TdollNetworkManager.shared.getTdollById(id)
        } catch {
            return nil
        }
    }
    
    func delete(_ id: Int, completion: @escaping (_ deleted: Bool, _ error: TdollError) -> Void){
        TdollNetworkManager.shared.deleteTdoll(id) { deleted, error in
            if deleted { completion(true, .noError) }
            else{ completion(false, .connectionFailed) }
        }
    }
    
    func update(_ id: Int, _ tdoll: tdollData, completion: @escaping (_ isSuccess: Bool, _ error: TdollError) -> Void) async{
        do {
            try await TdollNetworkManager.shared.updateTdoll(id, tdoll, completion: { isSuccess, error in
                if isSuccess{ completion(true, .noError) }
                else { completion(false, .updateError) }
            })
        } catch {
            completion(false, .updateError)
        }
    }
    
    func post(_ tdoll: tdollData, completion: @escaping (_ isSuccess: Bool, _ error: TdollError) -> Void) async{
        do{
            try await TdollNetworkManager.shared.post(tdoll, completion: { isSuccess, error in
                if isSuccess{ completion(true, .noError) }
                else if error == .RequiredFieldEmpty{ completion(false, .requiredFieldEmpty) }
                else{ completion(false, .postError) }
            })
        }catch {
            completion(false, .postError)
        }
    }
    
    func getARSize() async -> Int {
        guard let ars = try? await TdollNetworkManager.shared.getTdollByType(type: .AR) else { return 0 }
        return ars.count
    }
    
    func getSMGSize() async -> Int {
        guard let smgs = try? await TdollNetworkManager.shared.getTdollByType(type: .SMG) else { return 0 }
        return smgs.count
    }
    
    private func validateTdoll(_ tdoll: tdollData) -> TdollError {
        if tdoll.id < 0 { return .invalidID }
        if tdoll.image.isEmpty || tdoll.name.isEmpty || tdoll.manufacturer.isEmpty { return .requiredFieldEmpty }
        return .noError
    }
}

extension Tdoll{
    enum TdollError: String, Error{
        case invalidID = "ID de tdoll inválido"
        case requiredFieldEmpty = "Campos obrigatórios não preenchidos"
        case connectionFailed = "Falha na conexão"
        case deleteError = "Erro ao deletar Tdoll"
        case updateError = "Erro ao atualizar Tdoll"
        case postError = "Erro ao realizar Post"
        case serverError = "Erro no servidor"
        case noError
    }
    
    enum TdollType: String, Decodable{
        case AR = "AR"
        case SMG = "SMG"
        case SG = "SG"
        case MG = "MG"
        case HG = "HG"
        case RF = "RF"
    }
}



