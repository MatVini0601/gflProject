//
//  TdollDetails.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/08/22.
//

import SwiftUI

struct TdollDetails: View {
    @EnvironmentObject var tdollActionVm: TdollActionsViewModel
    @State var id: Int?
    @State var tdoll: TdollModel.Tdoll?
    @State var shouldUpdate: Bool = false
    @State var active: Bool = false
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
                    HStack(alignment: .top, spacing: 8) {
                        Text(tdoll?.name ?? "Tdoll Detail")
                            .font(.custom("Montserrat", size: 36))
                            .foregroundColor(.white)
                            .bold()
                    
                        Spacer()
                        
                        if(tdoll?.tier == 7){
                            Text("Extra")
                                .foregroundColor(Color.Extra)
                                .font(.custom("Montserrat", size: 24))
                        }else{
                            ForEach(0..<tdoll!.tier, id: \.self){_ in
                                Text(String("★"))
                                    .foregroundColor(Color.lightYellow)
                                    .font(.custom("Montserrat", size: 24))
                            }
                        }
                    }
                    Divider()
                    
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
                                .frame(width: 200, height: 200, alignment: .topLeading)
                            
                            Text("IOP description")
                        }
                    }
                }
                .padding()
                
    //                NavigationLink(
    //                    destination: TdollPost(tdoll: tdoll!, isEditing: true), isActive: $active) {
    //                        Text(tdoll?.name ?? "Tdoll name")
    //                            .onTapGesture {
    //                                shouldUpdate.toggle()
    //                                active = true
    //                            }
                
                
            }
            .background(Color.Gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task {
                if shouldUpdate{
                    tdoll = await tdollActionVm.getTdoll(id: tdoll!.id)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct TdollDetails_Previews: PreviewProvider {
    static var previews: some View {
        TdollDetails()
            .environmentObject(TdollActionsViewModel())
    }
}
