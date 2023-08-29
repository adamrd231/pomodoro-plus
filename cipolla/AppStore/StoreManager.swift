//
//  StoreManager.swift
//  CryptoGame
//
//  Created by Adam Reed on 8/7/23.
//

import Foundation
import StoreKit

class StoreManager: ObservableObject {
    
    @Published var products:[Product] = []
    @Published var purchasedNonConsumables:Set<Product> = []
    @Published var purchasedConsumables: [Product] = []
    
    @Published var entitlements:[Transaction] = []
    var transactionListener: Task<Void, Error>?
    
    private var productIDs = [
        "cryptoRemoveAds",
        "design.rdconcepts.purchaseOneThousand",
        "design.rdconcepts.crypto.tenThousand",
        "design.rdconcepts.crypto.oneHundredThousand",
        "design.rdconepts.crypto.fifteenThousand",
        "design.rdconcepts.crypto.twentyFiveThousand",
        "design.rdconcepts.crypto.fiveThousand"
    ]
    
    init() {
        transactionListener = listenForTransactions()
        Task {
            await requestProducts()
            // Must be called after products have already been fetched
            // Transactions do not contain product or product info
            await updateCurrentEntitlements()
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            products = try await Product.products(for: productIDs).sorted(by: { $0.price < $1.price })
        } catch let error {
            print("Error fetching products: \(error)")
        }
    }
    
    @MainActor
    func attemptInAppPurchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        switch result {
        case .success(.verified(let transaction)):
   
            purchasedNonConsumables.insert(product)
           
            await transaction.finish()
            return transaction
        default: return nil
            
        }
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                await self.handle(transactionVerification: result)
            }
        }
    }
    
    private func updateCurrentEntitlements() async {
        for await result in Transaction.currentEntitlements {
            await self.handle(transactionVerification: result)
        }
    }
    
    @MainActor
    func restorePurchases() async throws {
        try await AppStore.sync()

    }
    
    @MainActor
    func handle(transactionVerification result: VerificationResult<Transaction>) async {
        switch result {
        case let .verified(transaction):
            guard let product = self.products.first(where: { $0.id == transaction.productID }) else { return }
            self.purchasedNonConsumables.insert(product)
            await transaction.finish()
        default: return
        }
    }
}
