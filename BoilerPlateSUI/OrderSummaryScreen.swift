//
//  OrderSummaryScreen.swift
//  BoilerPlateSUI
//
//  Created by Balaganesh on 04/11/22.
//

import SwiftUI
import HyperSDK

struct OrderSummaryScreen: View {
    
    @State private var isPaymentPageActive: Bool = false
    
    private let paymentsHelper = PaymentsHelper()
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Dummy Item")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Qty. 2")
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("₹ 5")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.trailing)
                }
                
                VStack {
                    Color.gray
                }
                .frame(height: 1.0)
                .frame(maxWidth: .infinity)
                .padding(.top)
                .padding(.horizontal)
                
                HStack {
                    Text("Total")
                        .padding()
                    
                    Spacer()
                    
                    Text("₹ 10")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.trailing)
                }
            }
            .padding()
            .background(
                Color.white.cornerRadius(10.0)
                    .shadow(radius: 5.0)
            )
            
            Spacer()
            
            NavigationLink(destination:
                            // Embedding PaymentScreen in a ViewController using viewControllerWithRootView
                           paymentsHelper.viewControllerWithRootView(view: PaymentScreen(paymentsHelper: paymentsHelper, paymentMethods: [])),
            isActive: $isPaymentPageActive ) {
                Text("Go to Payments")
                    .customButton()
            }
        }
        .padding()
        .navigationTitle("Order Summary")
        .onDisappear() {
            if (!isPaymentPageActive) {
                // Terminating HyperSDK on exiting OrderSummaryScreen
                paymentsHelper.hyperInstance.terminate()
            }
        }
    }
}

struct OrderSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        OrderSummaryScreen()
    }
}
