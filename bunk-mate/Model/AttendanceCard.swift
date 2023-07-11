//
//  AttendanceCard.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 11/07/23.
//

import SwiftUI

struct AttendanceCard: View {
    
    let constants = Constants()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(constants.primaryColor)
            HStack{
                VStack(alignment:.leading){
                    Text("Basic Mechanical Engineering")
                        .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                    Text("Minimum Requirement : 75%")
                        .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .regular))
                    Spacer()
                    VStack(alignment:.leading) {
                        Text("Attended : 5")
                            .foregroundColor(.white)
                        .font(.system(size: 14, weight: .regular))
                        Text("Missed : 5")
                            .foregroundColor(.white)
                        .font(.system(size: 14, weight: .regular))
                    }
                    Spacer()
                    Text("Must attend 4 more classes")
                        .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 14, weight: .medium))
                    
                }
                Spacer()
                ZStack{
                    Circle()
                        .stroke(lineWidth: 9)
                        .foregroundColor(.gray.opacity(0.5))
                    Circle()
                        .trim(from: 0, to: 0.25)
                        .stroke(lineWidth: 6)
                        .foregroundColor(.green)
                        .shadow(color: .green, radius: 10)
                        .rotationEffect(Angle(degrees: 270))
                    Text("75%")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                }
                .frame(height: 110)

            }
            .padding()
        }
        .padding()
        .frame(height: 230)
    }
}

struct AttendanceCard_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceCard()
    }
}
