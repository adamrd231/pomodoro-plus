//
//  InAppPurchases.swift
//  cipolla
//
//  Created by Adam Reed on 8/28/23.
//

import SwiftUI

struct InAppPurchases: View {
    var body: some View {
        VStack {
            Text("Remove Advertising")
            Button("Restore Purchases") {
                print("Restore")
            }
        }
    }
}

struct InAppPurchases_Previews: PreviewProvider {
    static var previews: some View {
        InAppPurchases()
    }
}
