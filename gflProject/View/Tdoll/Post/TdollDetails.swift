//
//  TdollDetails.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/08/22.
//

import SwiftUI

struct TdollDetails: View {
    @EnvironmentObject var tdollActionVM: TdollActionsViewModel
    @Environment(\.presentationMode) var presentation
    @Namespace var CategoryAnimation
    @State var id: Int?
    @State var tdoll: Tdoll
    @State var tags: Int?
    @State var gallery: [Gallery.galleryData]?
    @State var tdollTags: [Tags.tagData]?
    @State var active: Bool = false
    
    @State var skinSelection = "Default Skin"
    @State var skinLink: String?
    
    @State private var isShowing = false
    
    //game minimum tdoll tier
    var tier = 2
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: URL(string: tdoll.image)){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }placeholder: {
                    ProgressView()
                        .frame(width: 300, height: 400, alignment: .topLeading)
                }
                .frame(alignment: .top)
            
                
                VStack{
                    VStack(alignment: .leading) {
                        Text(tdoll.name)
                            .font(.title).bold()
                            .bold()
                    
                        HStack(alignment: .top){
                            if(tdoll.tier == 7){
                                Text("Extra")
                                    .foregroundColor(Color.Extra)
                                    .font(.custom("Montserrat", size: 18))
                            }else{
                                ForEach(0..<tdoll.tier, id: \.self){_ in
                                    Text(String("★"))
                                        .foregroundColor(Color.lightYellow)
                                        .font(.custom("Montserrat", size: 18))
                                }
                            }
                        }
                        
                        if tdollActionVM.tdollHasTags(id!){
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .top){
                                    ForEach(tdollTags!, id: \.self){tag in
                                        Text(tag.tagName)
                                            .padding(.vertical, 4)
                                            .padding(.horizontal, 8)
                                            .lineLimit(1)
                                            .background{
                                                Capsule().stroke(lineWidth: 1).fill(Color.LightGray)
                                                    Capsule()
                                                    .fill(Color.Gray)
                                                }
                                    }
                                    .contentShape(Capsule())
                                }
                                .padding([.trailing])
                                .padding([.top, .bottom], 2)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading])
                    
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.7))
                    .frame(height: 1)
                    .padding()
                
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
                        
                        if tdoll.manufacturer == "16LAB"{
                            Text(tdollActionVM.getLAB())
                                
                        }else if tdoll.manufacturer == "IOP"{
                            Text(tdollActionVM.getIOP())
                        }else{
                            Text(tdollActionVM.getUnknow())
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                
                if tdollActionVM.tdollHasGallery(id!){
                    VStack{
                        Text("Gallery")
                            .font(.custom("Montserrat", size: 24))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(gallery!, id: \.self){ item in
                                    Text(item.model_name)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 8)
                                        .background{
                                            Capsule().stroke(lineWidth: 1).fill(Color.LightGray)
                                            if skinSelection == item.model_name{
                                                Capsule()
                                                    .fill(Color.lightYellow)
                                                    .matchedGeometryEffect(id: "SKIN", in: CategoryAnimation)
                                            }
                                        }
                                        .lineLimit(1)
                                        .onTapGesture {
                                            withAnimation{skinSelection = item.model_name}
                                            skinLink = item.image_link
                                        }
                                }
                                .contentShape(Capsule())
                            }
                            .padding()
                        }
                        
                        AsyncImage(url: URL(string: skinLink!)){image in
                            image
                                .resizable()
                                .scaledToFill()
                        }placeholder: {
                            ProgressView()
                                .frame(width: 200, height: 400, alignment: .leading)
                                .scaledToFill()
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .foregroundColor(.white)
        .background(Color.Gray)
        .task {
            gallery = await tdollActionVM.getTdollGallery(id: tdoll.id)
            tdollTags = await tdollActionVM.getTdollTags(id: tdoll.id)
            skinLink = gallery?.first?.image_link
        }
        .toolbar {
            ToolbarItem {
                Button {
                        isShowing = true
                } label: {
                    Image(systemName: "trash.circle")
                        .foregroundColor(.lightYellow)
                }
                .alert("Alert", isPresented: $isShowing, actions: {
                    Button("Voltar", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                        Task{ await self.tdollActionVM.deleteTdoll(id: tdoll.id) }
                        if tdollActionVM.ErrorType == .NoError { presentation.wrappedValue.dismiss() }
                    }
                }, message: {
                    Text("Essa ação é irreversivel, quer continuar?")
                })
            }
        }
        .navigationBarColor(backgroundColor: Color.white.opacity(0.1), titleColor: UIColor(Color.lightYellow), blur: UIBlurEffect(style: .dark))
    }
}

struct TdollDetails_Previews: PreviewProvider {
    static var previews: some View {
        TdollDetails(tdoll: Tdoll(
            id: 56,
            image: "https://iopwiki.com/images/a/a2/ST_AR-15_S.png",
            name: "ST AR-15",
            tier: 4,
            manufacturer: "16LAB",
            type: .AR,
            hasMindUpgrade: nil))
            .environmentObject(TdollActionsViewModel())
    }
}
