//
//  Form.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 20/08/22.
//

import SwiftUI

struct TdollForm: View {
    @EnvironmentObject var tdollPostVM: TdollActionsViewModel
    
    @State var tdollName: String = ""
    @State var tdollId: String = ""
    @State var tdollImage: String = ""
    @State var tdollTier: Int = 2
    @State var tdollManufacturer: String = ""
    @State var tdollType: Tdoll.TdollType = .AR
    
    @State var tdoll: Tdoll?
    @State var isEditing: Bool = false
    
    init(tdoll: Tdoll?, isEditing: Bool){
        guard let tdoll = tdoll else {
            return
        }
        _tdoll = State(initialValue: tdoll)
        _isEditing = State(initialValue: isEditing)
    }
    
    @State private var typeSelection: Tdoll.TdollType = .AR
    @State private var manufacturerSelection = "16LAB"
    @State private var tierSelection = 2
    
    private var types: [Tdoll.TdollType] = [.AR, .HG, .MG, .RF , .SMG, .SG]
    private var manufacturers: [String] = ["16LAB", "IOP"]
    private var tiers: [Int] = [2, 3, 4, 5, 6, 7]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            AsyncImagePreview(url: $tdollImage)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Image URL")
                TextField("URL", text: $tdollImage)
                    .padding(8)
                    .background(
                        Rectangle()
                            .fill(Color.LightGray)
                            .cornerRadius(8)
                    )
            }
            
            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("ID")
                    TextField("ID", text: $tdollId)
                        .padding(8)
                        .background(
                            Rectangle()
                                .fill(Color.LightGray)
                                .cornerRadius(8)
                        )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name")
                    TextField("name", text: $tdollName)
                        .padding(8)
                        .background(
                            Rectangle()
                                .fill(Color.LightGray)
                                .cornerRadius(8)
                        )
                }
            }
            
            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading){
                    Text("Manufacturer").lineLimit(1)
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
                            .fill(Color.LightGray)
                            .cornerRadius(8)
                    )
                }
                
                VStack(alignment: .leading){
                    Text(" Type")
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
                            .fill(Color.LightGray)
                            .cornerRadius(8)
                    )
                }
                
                VStack(alignment: .leading){
                    Text("Tier")
                    Picker("Tdoll tiers", selection: self.$tierSelection){
                        ForEach(self.tiers ,id: \.self){ item in
                          if item == 7{
                                Text(String("Extra"))
                                    .frame(maxWidth: .infinity)
                            }else{
                                Text(String(item))
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(4)
                    .background(
                        Rectangle()
                            .fill(Color.LightGray)
                            .cornerRadius(8)
                    )
                }
            }
            PostButton(
                tdoll: Tdoll.init(
                            id: Int(tdollId) ?? 0,
                            image: tdollImage,
                            name: tdollName,
                            tier: tierSelection,
                            manufacturer: manufacturerSelection,
                            type: typeSelection,
                            hasMindUpgrade: nil,
                            gallery_id: nil,
                            tags: nil), isEditing: self.isEditing)
            .environmentObject(TdollActionsViewModel())
        }
        .padding()
        .onAppear(){
            self.tdollImage = tdoll?.image ?? ""
            self.tdollId = String(tdoll?.id ?? 0)
            self.tdollName = tdoll?.name ?? ""
            self.tierSelection = tdoll?.tier ?? 2
            self.manufacturerSelection = tdoll?.manufacturer ?? "16LAB"
            self.typeSelection = tdoll?.type ?? .AR
        }
    }
}

struct Form_Previews: PreviewProvider {
    static var previews: some View {
        TdollForm(tdoll: Tdoll(
            id: 56,
            image: "https://iopwiki.com/images/a/a2/ST_AR-15_S.png",
            name: "ST AR-15",
            tier: 4,
            manufacturer: "16LAB",
            type: .AR,
            hasMindUpgrade: nil,
            gallery_id: nil,
            tags: nil), isEditing: false)
            .environmentObject(TdollActionsViewModel())
    }
}
