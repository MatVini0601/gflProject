//
//  PostButton.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 20/08/22.
//

import SwiftUI

struct PostButton: View {
    @EnvironmentObject var tdollPostVM: TdollActionsViewModel
    @Environment(\.presentationMode) var presentation

    
    var ID: String?
    var imageURL: String?
    var name: String?
    var tier: Int?
    var manufacturerSelection: String?
    var typeSelection: Tdoll.TdollType?
    
    var isEditing: Bool
    
    init(tdoll: Tdoll, isEditing: Bool){
        self.ID = String(tdoll.id)
        self.imageURL = tdoll.image
        self.name = tdoll.name
        self.tier = tdoll.tier
        self.manufacturerSelection = tdoll.manufacturer
        self.typeSelection = tdoll.type
        self.isEditing = isEditing
    }
    
    @State private var isShowing = false
    @State private var isPerformingPost = false
    
    var body: some View {
        Button {
            isPerformingPost = true
            
            // Recupera os dados do formulário
            let tdoll = Tdoll.init(
                id: Int(self.ID ?? "0") ?? 0,
                image: self.imageURL ?? "",
                name: self.name ?? "",
                tier: self.tier ?? 1,
                manufacturer: self.manufacturerSelection ?? "16LAB",
                type: self.typeSelection ?? .AR,
                hasMindUpgrade: nil
                )
            
            
            // Executa a ação baseado na intenção do usuário
            // variavel "isEditing" é atribuida na view "TdollDetails(destination)"
            Task{
                if isEditing{
                    await tdollPostVM.updateTdoll(id: Int(self.ID ?? "0") ?? 0, tdoll)
                }else{
                    await tdollPostVM.postTdoll(tdoll)
                }
                isPerformingPost = false
                isShowing = true
            }
        } label: {
            Text("Salvar")
        }
        .disabled(isPerformingPost)
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(Color.lightYellow)
        .alert("Alert", isPresented: $isShowing, actions: {
            Button("OK", role: .cancel) {
                if tdollPostVM.ErrorType == .NoError { presentation.wrappedValue.dismiss() }
            }
        }, message: {
            Text(tdollPostVM.alertMessage)
        })

    }
}

struct PostButton_Previews: PreviewProvider {
    static var previews: some View {
        PostButton(tdoll:
                Tdoll(
                id: 56,
                image: "https://iopwiki.com/images/a/a2/ST_AR-15_S.png",
                name: "ST AR-15",
                tier: 4,
                manufacturer: "16LAB",
                type: .AR,
                hasMindUpgrade: nil), isEditing: false
        )
        .environmentObject(TdollActionsViewModel())
    }
}
