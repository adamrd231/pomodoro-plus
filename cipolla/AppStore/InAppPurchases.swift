//
//  InAppPurchases.swift
//  cipolla
//
//  Created by Adam Reed on 8/28/23.
//

import SwiftUI

struct InAppPurchases: View {
    
    @State var store: StoreManager
    
    var body: some View {
        List {
            Section(header: Text("Advertising")) {
                HStack {
                    Text("Remove Advertising")
                    Spacer()
                    Button(store.purchasedNonConsumables.contains(where: { $0.id == "cryptoRemoveAds" }) ? "Thanks!" : "Remove!") {
                        Task {
                            try await store.attemptInAppPurchase(cartVM.store.products.first(where: {$0.id == "cryptoRemoveAds"})!)
                        }
                    }
                    .disabled(store.purchasedNonConsumables.contains(where: { $0.id == "cryptoRemoveAds" }))
                }
            }
            Section(header:Text("Restore")) {
                VStack {
                    Text("Restore any previously made purchases.")
                    Button("Restore") {
                        
                    }
                }
            }
        }
    }
}

struct InAppPurchases_Previews: PreviewProvider {
    static var previews: some View {
        InAppPurchases(store: StoreManager())
    }
}
