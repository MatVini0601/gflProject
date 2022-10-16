//
//  TdollDetails.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/08/22.
//

import SwiftUI

struct TdollDetails: View {
    @EnvironmentObject var tdollActionVm: TdollActionsViewModel
    @Namespace var CategoryAnimation
    @State var id: Int?
    @State var tdoll: Tdoll?
    @State var tags: Int?
    @State var gallery: [TdollModel.galleryLinks]?
    @State var tdollTags: [TdollModel.tdollTags]?
    @State var shouldUpdate: Bool = false
    @State var active: Bool = false
    
    
    @State var skinSelection = "Default Skin"
    @State var skinLink = "https://iopwiki.com/images/2/2e/ST_AR-15.png"
    
    //game minimum tdoll tier
    var tier = 2
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: URL(string: tdoll?.image ?? "")){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, alignment: .top)
                    
                }placeholder: {
                    ProgressView()
                }
                .frame(alignment: .top)
            
                
                VStack{
                    VStack(alignment: .leading) {
                        Text(tdoll?.name ?? "Tdoll Detail")
//                            .font(.custom("Montserrat", size: 36))
                            .font(.title).bold()
                            .foregroundColor(.white)
                            .bold()
                    
                        HStack(alignment: .top){
                            if(tdoll?.tier == 7){
                                Text("Extra")
                                    .foregroundColor(Color.Extra)
                                    .font(.custom("Montserrat", size: 18))
                            }else{
                                ForEach(0..<tdoll!.tier, id: \.self){_ in
                                    Text(String("★"))
                                        .foregroundColor(Color.lightYellow)
                                        .font(.custom("Montserrat", size: 18))
                                }
                            }
                        }
                        
                        HStack(alignment: .top){
                            ForEach(tdollTags ?? [], id: \.self){tag in
                                Text(tag.tagName)
                                    .foregroundColor(Color.white)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .background{
                                        Capsule().stroke(lineWidth: 1).fill(Color.LightGray)
                                            Capsule()
                                            .fill(Color.Gray)
                                        }
                            }
                            .contentShape(Capsule())
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                    
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.7))
                    .frame(height: 1)
                    .padding()
                
                VStack{
                    Text("Manufacturer")
                        .font(.custom("Montserrat", size: 24))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    HStack{
                        Image(tdoll!.manufacturer)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 150, alignment: .center)
                        
                        Spacer()
                        
                        Text("16LAB Research Institute[1] (also rendered “16Lab”) is the company created by Persicaria in 2057, and one of IOP's first-party manufacturer and R&D partners in the Tactical Doll market.")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                
                VStack{
                    Text("Gallery")
                        .font(.custom("Montserrat", size: 24))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    HStack{
                        ForEach(gallery ?? [], id: \.self){ item in
                            Text(item.model_name)
                                .foregroundColor(Color.white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background{
                                    Capsule().stroke(lineWidth: 1).fill(Color.LightGray)
                                    if skinSelection == item.model_name{
                                        Capsule()
                                            .fill(Color.lightYellow)
                                            .matchedGeometryEffect(id: "SKIN", in: CategoryAnimation)
                                    }else{
                                        Capsule()
                                            .fill(Color.Gray)
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
                    
                    AsyncImage(url: URL(string: skinLink)){image in
                        image
                            .resizable()
                            .scaledToFill()
                            .padding()
                    }placeholder: {
                        ProgressView()
                            .frame(width: 200, height: 400, alignment: .leading)
                            .scaledToFill()
                    }
                }
                .padding()
            }
        }
        .background(Color.Gray)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            gallery = await tdollActionVm.getTdollGallery(id: tdoll!.id)
            tdollTags = await tdollActionVm.getTdollTags(id: tdoll!.id)
            if shouldUpdate{
                tdoll = await tdollActionVm.getTdoll(id: tdoll!.id)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarColor(backgroundColor: Color(red: 255, green: 255, blue: 255, opacity: 0), titleColor: UIColor(Color.lightYellow))
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
            hasMindUpgrade: nil,
            gallery_id: 57,
            tags: 57))
            .environmentObject(TdollActionsViewModel())
    }
}
