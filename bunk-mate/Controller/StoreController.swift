//
//  StoreController.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 22/07/23.
//

import StoreKit
import SwiftUI

class StoreController : ObservableObject {
    
    @Published var products : [Product] = []
    @Published var purchasedIDs : [String] = []
    @Published var purchasedBunkMatePro : Bool = false
    
    func fetchProducts(){
        
        print("Fetching Products")
        Task.init {
            do{
                let products = try await Product.products(for: ["bunkmatepro_all_access"])
                DispatchQueue.main.async {
                    self.products = products
                }
                if let product = products.first {
                    await checkPurchase(product: product)
                }
            } catch {
                
            }
        }
    }
    
    func checkPurchase(product : Product) async {
        print("Checking Purchase")
        Task.init {
            let state = await product.currentEntitlement
            switch(state){
            case .verified(let transaction):
                DispatchQueue.main.async {
                    self.purchasedIDs.append(transaction.productID)
                    self.purchasedBunkMatePro = true
                    print("Verified")
                }
            case .unverified(_):
                print("Not Purchase")
            default:
                print("Error")
            }
        }
    }
    
    func purchase(){
        
        guard let product = products.first else {return}
        
        Task.init {
            do{
                let result = try await product.purchase()
                switch(result){
                case .success(let verification):
                    switch(verification){
                    case .verified(let transaction):
                        print(transaction.productID)
                        fetchProducts()
                        if await UIApplication.shared.supportsAlternateIcons {
                            do{
                                try await UIApplication.shared.setAlternateIconName("ProAppIcon")
                            } catch {
                                print("Unable to change icon")
                            }
                        }
                    case .unverified(let transaction):
                        print("Unverified txn.")
                    }
                case .pending:
                    print("Pending")
                case .userCancelled:
                    print("Cancelled by user")
                default:
                    print("Unrecognized")
                }
            }catch{
                
            }
        }
    }
}
