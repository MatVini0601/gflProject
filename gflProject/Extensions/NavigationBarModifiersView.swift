//
//  NavigationBarModifiersView.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 05/09/22.
//

import SwiftUI

import SwiftUI

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?
    var blur: UIBlurEffect?
    

    init(backgroundColor: Color, titleColor: UIColor?, blur: UIBlurEffect?) {
        self.backgroundColor = UIColor(backgroundColor)
        
        let coloredAppearance = UINavigationBarAppearance()
        let image = UIImage(systemName: "chevron.backward")?.withTintColor(titleColor ?? .white, renderingMode: .alwaysOriginal)
    
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(backgroundColor)
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.shadowColor = .clear
        coloredAppearance.backgroundEffect = blur ?? .none
        coloredAppearance.setBackIndicatorImage(image, transitionMaskImage: image)
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = titleColor
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {

    func navigationBarColor(backgroundColor: Color, titleColor: UIColor?, blur: UIBlurEffect?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor, blur: blur))
    }

}
