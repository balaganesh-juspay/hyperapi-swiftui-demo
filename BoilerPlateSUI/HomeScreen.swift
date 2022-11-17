//
//  HomeScreen.swift
//  BoilerPlateSUI
//
//  Created by Balaganesh on 04/11/22.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(
                Color.blue.cornerRadius(10.0)
            )
    }
}

extension View {
    func customButton() -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier())
    }
}


struct HomeScreen: View {
    
    @State var goToCart: Bool = false
    
    var body: some View {
        NavigationView(content: {
            VStack() {
                Spacer()
                NavigationLink {
                    OrderSummaryScreen()
                } label: {
                    Text("Go to Cart")
                        .customButton()
                }
            }
            .navigationTitle("Home Screen")
            .padding()
        })
    }
}

struct HomeScreen_Previews: PreviewProvider {

    static var previews: some View {
        HomeScreen()
    }
}
