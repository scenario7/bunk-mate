//
//  HomeScreen.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 11/07/23.
//

import SwiftUI

struct HomeScreen: View {
    
    let constants = Constants()
    
    var body: some View {
        ZStack(alignment:.topLeading){
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment:.leading){
                        Text(Date().formatted(date: .abbreviated, time: .omitted).uppercased())
                            .foregroundColor(.gray)
                            .font(.system(size: 17, weight: .semibold))
                        Text("Your Attendance")
                            .foregroundColor(.white)
                            .font(.system(size: 27, weight: .semibold))
                        Text("Last Updated at 14:20 on 3/7")
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .medium))
                        
                    }
                    Spacer()
                    Button {
                        print("Hello")
                    } label: {
                        ZStack{
                            Circle()
                                .foregroundColor(constants.primaryColor)
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(constants.accent)
                                .padding(14)
                        }
                        .frame(height: 50)
                    }
                    
                }
            }
            .padding()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
