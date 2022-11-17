//
//  PaymentsHelper.swift
//  BoilerPlateSUI
//
//  Created by Balaganesh on 16/11/22.
//

import SwiftUI
import HyperSDK

class PaymentsHelper {
    
    lazy var hyperInstance = HyperServices()

    // MARK: Helper functions
    func initiateHyper(payload: [String: Any]) {
        // Passing a dummy ViewController object. Later it can be updated with the actual base view controller.
        hyperInstance.initiate(UIViewController(), payload: payload) { [unowned self] response in
            if let response = response, let event = response["event"] as? String {
                if event == "initiate_result" {
                    // Check if you are getting success status in the response.
                    // If not please check errorMessage for the reason.
                    print(response)
                }
            }
        }
    }
    
    // Generic function to create a UIHostingController with a rootView and set it as the baseViewController of HyperSDK.
    // baseViewController is the screen on which HyperSDK will render its UI.
    struct HyperViewController<T: View>: UIViewControllerRepresentable {
        
        var rootView : T
        var hyperInstance : HyperServices
        
        func makeUIViewController(context: Context) -> UIHostingController<T> {
            
            let hostingVC = UIHostingController(rootView: rootView)
            hyperInstance.baseViewController = hostingVC
            return hostingVC
        }
        
        func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {
            
        }
    }
    
    // To embed a Screen view into a ViewController to use with HyperSDK
    func viewControllerWithRootView<T: View>(view: T) -> some View {
        // To initiate HyperSDK in case it's not initialised/deallocated.
        // This step is mandatory since the webview might get deallocated if the app is in the background for a long time.
        if (!hyperInstance.isInitialised()) {
            hyperInstance.terminate()
            initiateHyper(payload: getInitiatePayload())
        }
        return HyperViewController<T>(rootView: view, hyperInstance: hyperInstance).ignoresSafeArea()
    }
    
    
    // MARK: Sample initiate payload
    func getInitiatePayload() -> [String: Any] {
        let initiatePayload = [
            "service": "in.juspay.hyperapi",
            "requestId": UUID().uuidString,
            "payload": [
                "action": "initiate",
                "merchantId": "getsimpl",
                "clientId": "getsimpl",
                "customerId": "test_customer",
                "environment": "sandbox"
            ]
        ] as [String : Any]
        
        return initiatePayload
    }
    
    
    // MARK: Sample process payloads
    func getPaymentMethodsPayload() -> [String: Any] {
        
        let processPayload = [
            "service": "in.juspay.hyperapi",
            "requestId": UUID().uuidString,
            "payload": [
                "action": "getPaymentMethods"
            ]
        ] as [String : Any]
        
        return processPayload
    }
    
    func getStartUPIPayload() -> [String: Any] {
        
        let processPayload = [
            "service": "in.juspay.hyperapi",
            "requestId": UUID().uuidString,
            "payload": [
                "clientAuthToken": "tkn_c3e7c7d4ec244e4da69432848037ca95",
                "orderId": "hyperorder8599472",
                "action": "upiTxn",
                "displayNote": "UPI Intent",
                "showLoader": false,
                "upiSdkPresent": false
            ]
        ] as [String : Any]
        
        return processPayload
    }
    
    func getStartJuspaySafePayload() -> [String: Any] {
        
        let processPayload = [
            "service": "in.juspay.hyperapi",
            "requestId": UUID().uuidString,
            "payload": [
                "orderId": "test_order",
                "action": "startJuspaySafe",
                "url": "https://paytm.com",
                "endUrls": []
            ]
        ] as [String : Any]
        
        return processPayload
    }
    
}
