//
//  InAppPurchases.swift
//  cipolla
//
//  Created by Adam Reed on 8/28/23.
//

import SwiftUI

struct InAppPurchases: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        List {
            Section(header: Text("About this app.")) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Developed by Adam Reed")
                        .bold()
                    Text("To sustain my app's development, I utilize in-app purchases and ads. This model lets users enjoy the core features for free while offering premium upgrades and relevant ads, ensuring both user satisfaction and financial support.")
                    Text("Thanks for contributing!")
                        
                }
                .font(.callout)
            }
            Section(header: Text("Advertising")) {
                HStack {
                    ForEach(vm.store.products, id: \.self) { product in
                        HStack {
                            Text(product.displayName)
                            Spacer()
                            if vm.store.purchasedNonConsumables.contains(where: { $0.displayName == "Remove Advertising"}) {
                                Text("Thanks!")
                           
                            } else {
                                Button(product.displayPrice) {
                                    Task {
                                        try await vm.store.attemptInAppPurchase(product)
                                    }
                                }
                            }
                           
                        }
                    }
                }
            }

            Section(header:Text("Restore")) {
                VStack(alignment: .leading) {
                    Text("Restores any previously made purchases from the before fore time..")
                    Button("Restore") {
                        Task {
                            try await vm.store.restorePurchases()
                        }
                    }
                }
            }
        }
    }
}

struct InAppPurchases_Previews: PreviewProvider {
    static var previews: some View {
        InAppPurchases()
            .environmentObject(HomeViewModel())
    }
}
