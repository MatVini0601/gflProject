//
//  TdollPost.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/06/22.
//

import SwiftUI

struct TdollPost: View {
    @EnvironmentObject var tdollPostVM: TdollPostViewModel
    @Environment(\.presentationMode) var presentation
    
    @State private var imageURL = ""
    @State private var ID = ""
    @State private var name = ""
    @State private var manufacturer = ""
    @State private var type: TdollModel.Tdoll.TdollType = .AR
    
    @State private var isShowing = false
    
    @State private var typeSelection: TdollModel.Tdoll.TdollType = .AR
    @State private var manufacturerSelection = "16LAB"

    private var types: [TdollModel.Tdoll.TdollType] = [.AR, .HG, .MG, .RF , .SMG, .SG]
    private var manufacturers: [String] = ["16LAB", "IOP"]
    
    //Styles
    private let LightGray = Color("LightGray")
    private let Background = Color("Background")
    private let Placeholder = Color("Placeholder")
    private let lightYellow = Color("LightYellow")
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 0){
                AsyncImage(url: URL(string: imageURL))
                    .frame(width: 200, height: 300)
                    .cornerRadius(16)
                    .padding(.bottom, 20)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.7))
                    .frame(height: 1)
                    .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Image URL")
                    TextField("URL", text: $imageURL)
                        .padding(8)
                        .background(
                            Rectangle()
                                .fill(LightGray)
                                .cornerRadius(8)
                        )
                    
                    HStack(alignment: .top, spacing: 8) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Tdoll ID")
                            TextField("ID", text: $ID)
                                .padding(8)
                                .background(
                                    Rectangle()
                                        .fill(LightGray)
                                        .cornerRadius(8)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Tdoll name")
                            TextField("name", text: $name)
                                .padding(8)
                                .background(
                                    Rectangle()
                                        .fill(LightGray)
                                        .cornerRadius(8)
                                )
                        }
                    }
                    
                    HStack(alignment: .top, spacing: 8) {
                        VStack(alignment: .leading){
                            Text("Tdoll manufacturer")
                            Picker("Tdoll manufacturers", selection: self.$manufacturerSelection){
                                ForEach(self.manufacturers ,id: \.self){
                                    Text($0)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(4)
                            .background(
                                Rectangle()
                                    .fill(LightGray)
                                    .cornerRadius(8)
                            )
                        }
                        
                        VStack(alignment: .leading){
                            Text("Tdoll type")
                            Picker("Tdoll types", selection: self.$typeSelection){
                                ForEach(self.types ,id: \.self){
                                    Text($0.rawValue)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(4)
                            .background(
                                Rectangle()
                                    .fill(LightGray)
                                    .cornerRadius(8)
                            )
                        }
                    }
                }
                .padding()
                
                Button {
                    let tdoll = TdollModel.Tdoll.init(
                        id: Int(self.ID) ?? 0,
                        image: self.imageURL,
                        name: self.name,
                        manufacturer: self.manufacturerSelection,
                        type: self.typeSelection)
                    
                    tdollPostVM.postTdoll(tdoll)
                    isShowing.toggle()
                    
                } label: {
                    Text("Salvar")
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(lightYellow)
                .padding()
                .alert("Alert", isPresented: $isShowing, actions: {
                    Button("OK", role: .cancel) { presentation.wrappedValue.dismiss() }
                }, message: {
                    Text(tdollPostVM.alertMessage)
                })
            }
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .background(Background)
        .navigationTitle("Tdoll")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TdollPost_Previews: PreviewProvider {
    static var previews: some View {
        TdollPost()
            .environmentObject(TdollPostViewModel())
    }
}
