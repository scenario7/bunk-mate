//
//  PurchaseScreen.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 17/07/23.
//

import SwiftUI
import CoreData
import StoreKit 

struct PurchaseScreen: View {
    
    @Environment(\.presentationMode) var isPresented
    @StateObject var storeController = StoreController()
    @State private var isRotating = 0.0
    
    
    var body: some View {
        ZStack(alignment:.top){
            Color.black.ignoresSafeArea()
            VStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(Color("Accent"))
                    .offset(x:200,y:-200)
                    .rotationEffect(.degrees(isRotating))
                    .onAppear {
                        withAnimation(.linear(duration: 10)
                                .repeatForever(autoreverses: false)) {
                                    isRotating = 360.0
                        }
                    }
                .blur(radius: 20)
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.yellow)
                    .offset(x:200,y:200)
                    .blur(radius: 20)
                    .rotationEffect(.degrees(isRotating))
                    .onAppear {
                        withAnimation(.linear(duration: 10)
                                .repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                    }
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.red)
                    .offset(x:-200,y:200)
                    .blur(radius: 20)
                    .rotationEffect(.degrees(isRotating))
                    .onAppear {
                        withAnimation(.linear(duration: 10)
                                .repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                    }
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.green)
                    .offset(x:-200,y:-200)
                    .blur(radius: 20)
                    .rotationEffect(.degrees(isRotating))
                    .onAppear {
                        withAnimation(.linear(duration: 10)
                                .repeatForever(autoreverses: false)) {
                            isRotating = 360.0
                        }
                    }
            }
            VStack(spacing:25){
                VStack {
                    Text("Purchase BunkMate Pro")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .semibold))
                    Text("One Time Purchase")
                        .foregroundColor(.gray)
                        .font(.system(size: 22, weight: .semibold))
                }
                Image(uiImage: UIImage(named: "AppIcon60x60") ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit
                    )
                    .frame(width: 100)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                //                HStack{
                //                    ZStack {
                //                        Text("₹49")
                //                            .font(.system(size: 50, weight: .semibold))
                //                            .foregroundColor(.white.opacity(0.7))
                //                        Text("-----")
                //                            .font(.system(size: 50, weight: .semibold))
                //                        .foregroundColor(.red)
                //                    }
                //                    Text("₹9")
                //                        .font(.system(size: 50, weight: .semibold))
                //                        .foregroundColor(.white)
                //
                //                }
                HStack(spacing:30){
                    VStack(spacing:40){
                        Image(systemName: "internaldrive")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("Accent"))
                            .frame(height: 30)
                        Image(systemName: "star")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("Accent"))
                            .frame(height: 30)
                        Image(systemName: "rectangle.3.group")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("Accent"))
                            .frame(height: 30)
                        
                        
                    }
                    VStack(spacing:45){
                        Text("Track Unlimited Subjects")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Future Pro Upgrades")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Lockscreen Widgets")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                    }
                    .multilineTextAlignment(.center)
                }
                Text("This is a one time purchase that will grant you lifetime access to all the features of BunkMate Pro")
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
                
                
                ForEach(storeController.storeProducts){ product in
                    Button {
                        Task{
                            try? await storeController.purchase(product)
                            isPresented.wrappedValue.dismiss()
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("Accent"))
                            Text("Purchase " + product.displayName)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.black)

                        }
                        .frame(height: 50)
                    }
                }
                Text("⚠️ Restart app after purchase")
                    .foregroundColor(.yellow)
                    .font(.system(size: 20, weight: .semibold))
                    .multilineTextAlignment(.center)
                Button {
                    Task{
                        try? await AppStore.sync()
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("Primary"))
                        Text("Restore Purchase")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("Accent"))

                    }
                    .frame(height: 50)
                }



            }
            .padding()
            
        }

    }
}

struct PurchaseScreen_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseScreen()
    }
}
