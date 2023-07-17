//
//  PurchaseScreen.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 17/07/23.
//

import SwiftUI

struct PurchaseScreen: View {
    
    @Environment(\.presentationMode) var isPresented
    
    var body: some View {
        ZStack(alignment:.top){
            Color.black.ignoresSafeArea()
            VStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(Color("Accent"))
                    .offset(x:-200,y:-200)
                .blur(radius: 20)
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.yellow)
                    .offset(x:200,y:200)
                    .blur(radius: 20)
            }
            VStack(spacing:40){
                VStack {
                    Text("Purchase BunkMate Pro")
                        .foregroundColor(.white)
                    .font(.system(size: 30, weight: .semibold))
                    Text("Unlock All Access Forever")
                        .foregroundColor(.gray)
                        .font(.system(size: 20, weight: .semibold))
                }
                HStack{
                    ZStack {
                        Text("₹49")
                            .font(.system(size: 50, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                        Text("-----")
                            .font(.system(size: 50, weight: .semibold))
                        .foregroundColor(.red)
                    }
                    Text("₹9")
                        .font(.system(size: 50, weight: .semibold))
                        .foregroundColor(.white)

                }
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


                    }
                    VStack(spacing:30){
                        Text("Track Unlimited Subjects")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Receive all future Pro exclusive updates")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)

                    }
                    .multilineTextAlignment(.center)
                }
                Spacer()
                Text("This is a one time purchase that will grant you lifetime access to all the features of BunkMate Pro")
                    .foregroundColor(.gray)
                    .font(.system(size: 20, weight: .regular))
                    .multilineTextAlignment(.center)
                Button {
                    print("Hello")
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("Accent"))
                        Text("Complete Purchase")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)

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
