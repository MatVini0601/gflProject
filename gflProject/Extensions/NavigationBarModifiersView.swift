//
//  NavigationBarModifiersView.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 05/09/22.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {

    private var backgroundColor: UIColor?
    private var titleColor: UIColor?
    private var blur: UIBlurEffect?
    

    init(backgroundColor: Color, titleColor: UIColor?, blur: UIBlurEffect?) {
        self.backgroundColor = UIColor(backgroundColor)
        self.titleColor = titleColor
        self.blur = blur
        
        let coloredAppearance = UINavigationBarAppearance()
        let image = UIImage(systemName: "chevron.backward")?.withTintColor(titleColor ?? .white, renderingMode: .alwaysOriginal)
    
        coloredAppearance.configureWithDefaultBackground()
        coloredAppearance.backgroundColor = self.backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: self.titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: self.titleColor ?? .white]
        coloredAppearance.shadowColor = .clear
        coloredAppearance.backgroundEffect = self.blur ?? .none
        coloredAppearance.setBackIndicatorImage(image, transitionMaskImage: image)
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = titleColor
    }

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
//            ZStack{
//                VStack {
//                    Color(self.backgroundColor ?? .clear)
//                        .frame(height: geometry.safeAreaInsets.top)
//                        .edgesIgnoringSafeArea(.top)
//                    Spacer()
//                }
//                content
//            }
        }
    }
}

extension View {
    func navigationBarColor(backgroundColor: Color, titleColor: UIColor?, blur: UIBlurEffect?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor, blur: blur))
    }

}
