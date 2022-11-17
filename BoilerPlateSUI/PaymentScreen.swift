//
//  PaymentScreen.swift
//  BoilerPlateSUI
//
//  Created by Balaganesh on 03/11/22.
//

import SwiftUI

struct PaymentMethod : Codable, Hashable {
    var description: String
    var paymentMethod: String
    var paymentMethodType: String
}

struct PaymentScreen: View {
    
    let paymentsHelper: PaymentsHelper
    
    @State private var allowTaps: Bool = true
    
    @State var paymentMethods: [PaymentMethod]
    
    var body: some View {
        VStack {
            Button {
                getPaymentMethods()
            } label: {
                Text("Get Payment Methods")
                    .customButton()
            }
            
            Button {
                startUPI()
            } label: {
                Text("Start UPI")
                    .customButton()
            }
            
            Button {
                startJuspaySafe()
            } label: {
                Text("Start JuspaySafe")
                    .customButton()
            }
            
            List {
                ForEach(paymentMethods, id: \.self) { method in
                    Text(method.description)
                }
            }
        }
        .navigationTitle("Payment Screen")
        .allowsHitTesting(allowTaps)
        .padding()
        .onAppear() {
            // Updating HyperSDKCallback to receive callback in this screen.
            updateHyperSDKCallback()
        }
    }
    
    func updateHyperSDKCallback() {
        paymentsHelper.hyperInstance.hyperSDKCallback = { response in
            
            if let response = response, let event = response["event"] as? String {
                
                print(response)
                
                if event == "hide_loader" {
                    // Hide loader
                } else if event == "process_result" {
                    allowTaps = true
                    
                    if let payload = response["payload"] as? [String : Any], let paymentMethods = payload["paymentMethods"] as? [[String: Any]] {
                        
                        do {
                            let data = try JSONSerialization.data(withJSONObject: paymentMethods)
                            let decodedPaymentMethods = try JSONDecoder().decode([PaymentMethod].self, from: data)
                            
                            self.paymentMethods = decodedPaymentMethods
                        } catch {
                            
                        }
                    }
                }
            }
        }
    }
    
    func getPaymentMethods() {
        
        let processPayload = paymentsHelper.getPaymentMethodsPayload()
        callProcess(payload: processPayload)
    }
    
    func startUPI() {
        
        let processPayload = paymentsHelper.getStartUPIPayload()
        callProcess(payload: processPayload)
    }
    
    func startJuspaySafe() {
        
        let processPayload = paymentsHelper.getStartJuspaySafePayload()
        callProcess(payload: processPayload)
    }
    
    func callProcess(payload: [String: Any]) {
        allowTaps = false
        paymentsHelper.hyperInstance.process(payload)
    }
}

struct PaymentsScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreen(paymentsHelper: PaymentsHelper(), paymentMethods: [])
    }
}
