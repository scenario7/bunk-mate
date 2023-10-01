//
//  SplashScreenView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 24/07/23.
//

import SwiftUI

struct SplashScreenView: View {
    
   @State var animationValue = 0
    @State var showSplash = 0
    @StateObject var storeController = StoreController()
    
    var body: some View {
        ZStack {
            
            GeometryReader{ proxy in
                let size = proxy.size
                ContentView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .offset(y: showSplash==1 ? 0 : (size.height+50))
                if(showSplash==0){
                    ZStack{
                        Color.black.ignoresSafeArea()
                        VStack(spacing:40){
                            ZStack{
                                Text("%")
                                    .foregroundColor(.white)
                                    .font(.custom("Lufga", size: 70))
                                Circle()
                                    .trim(from: 0, to: animationValue==1 ? 1 : 0)
                                    .stroke(lineWidth: 10)
                                    .foregroundColor(.green)
                                    .shadow(color: .green, radius: 5)
                                    .rotationEffect(Angle(degrees: -90))
                                    .animation(.easeInOut(duration: 1))
                            }
                            .frame(width: 150, height: 150)
                            HStack {
                                Text("BunkMate")
                                        .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .bold))
                            }
                        }
                    }
                }
            }
            .onAppear{
                animationValue = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1){
                    withAnimation(.easeInOut){
                        self.showSplash = 1
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
