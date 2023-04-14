//
//  TdollDetails.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/08/22.
//

import SwiftUI

struct TdollDetails: View {
    @EnvironmentObject var ViewModel: TdollDetailsViewModel
    @Environment(\.presentationMode) var presentation
    
    @State var tdoll: Tdoll.tdollData
    @State var tdollTags: [Tags.tagData]?
    
    @State private var isShowingAlert = false
    @State private var LoadingData = true
    
    //Gradient blur
    private let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color.BackgroundColor, location: 0),
            .init(color: Color.BackgroundColor.opacity(0.5), location: 0.1),
            .init(color: .clear, location: 0.2)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        ScrollView{
            //MARK: Main Content
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: tdoll.image)){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }placeholder: {
                    ProgressView()
                        .frame(width: 300, height: 400, alignment: .center)
                }
                .frame(alignment: .leading)
                .overlay { gradient }
                
                VStack{
                    TagsView()
                    
                    //MARK: Tdoll data(name, tier)
                    VStack(alignment: .leading){
                        Text(tdoll.name)
                            .font(.title).bold()
                            .bold()
                    
                        HStack{
                            if(tdoll.tier == 7){
                                Text("Extra")
                                    .foregroundColor(Color.ColorExtra)
                            }else{
                                ForEach(0..<tdoll.tier, id: \.self){_ in
                                    Text(String("★"))
                                        .foregroundColor(Color.Accent)
                                }
                            }
                        }
                        .font(.custom("Montserrat", size: 18))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    //MARK: Manufacturer
                    VStack{
                        Text("Manufacturer")
                            .font(.custom("Montserrat", size: 24))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        HStack{
                            Image(tdoll.manufacturer)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 150, alignment: .center)
                            
                            Spacer()
                        
                            Text(ViewModel.getManufacturer(tdoll.manufacturer))
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                }
                .padding(.horizontal, 10)
                
                GalleryView()
            }
        }
        .foregroundColor(Color.TextPrimary)
        .background(Color.BackgroundColor)
        .toolbar {
            //MARK: Delete Tdoll
            ToolbarItem {
                Button {
                    isShowingAlert = true
                } label: {
                    Image(systemName: "trash.circle").foregroundColor(Color.Accent)
                }
                .alert(tdoll.name, isPresented: $isShowingAlert, actions: {
                    Button("Não", role: .cancel) { }
                    Button("Sim", role: .destructive) {
                        Task{ await self.ViewModel.deleteTdoll(id: tdoll.id) }
                        if ViewModel.ErrorType == .NoError { presentation.wrappedValue.dismiss() }
                    }
                }, message: {
                    Text("Você irá exluir '\(tdoll.name)' do banco de dados, quer continuar?")
                })
            }
            //MARK: Edit Tdoll
            ToolbarItem{
                NavigationLink {
                    TdollForm(tdoll: tdoll, isEditing: true)
                } label: {
                    Image(systemName: "pencil").foregroundColor(Color.Accent)
                }
            }
        }
        .task {
            await ViewModel.getTdollTags(id: tdoll.id)
            await ViewModel.getTdollGallery(id: tdoll.id)
            self.LoadingData = false
        }
    }
}

struct TdollDetails_Previews: PreviewProvider {
    static var previews: some View {
        TdollDetails(tdoll: Tdoll.tdollData(
            id: 56,
            image: "https://iopwiki.com/images/a/a2/ST_AR-15_S.png",
            name: "ST AR-15",
            tier: 4,
            manufacturer: "16LAB",
            type: .AR,
            hasMindUpgrade: nil))
            .environmentObject(TdollDetailsViewModel())
    }
}
