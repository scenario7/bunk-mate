//
//  AttendanceCard.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 11/07/23.
//

import SwiftUI

struct AttendanceCard: View {
    
    let constants = Constants()
    
    var name : String
    var attended : Double
    var missed : Double
    var requirement : Double
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(constants.primaryColor)
                HStack{
                    VStack(alignment:.leading){
                        Text(name)
                            .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        Text("Minimum Requirement : \(Int(requirement*100))%")
                            .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .regular))
                        Spacer()
                        VStack(alignment:.leading) {
                            Text("Attended : \(Int(attended))")
                                .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            Text("Missed : \(Int(missed))")
                                .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                        }
                        Spacer()
                        Text(getClassesSkippable(percentage:getPercentage(attended: attended, missed: missed),attended:attended,missed:missed,requirement:requirement))
                            .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 14, weight: .medium))
                        
                    }
                    Spacer()
                    ZStack{
                        Circle()
                            .stroke(lineWidth: 9)
                            .foregroundColor(.gray.opacity(0.5))
                        Circle()
                            .trim(from: 0, to: getPercentage(attended: attended, missed: missed))
                            .stroke(lineWidth: 6)
                            .foregroundColor(.green)
                            .shadow(color: .green, radius: 5)
                            .rotationEffect(Angle(degrees: 270))

                        Text("\(Int((getPercentage(attended:attended,    missed: missed)*100)))%")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .frame(height: 110)

                }
                .padding()
            }
            .frame(height: 200)

    }
    
    func getPercentage(attended : Double, missed: Double) -> Double {
        return ((attended)/(attended+missed))
    }
    func getClassesSkippable(percentage: Double, attended : Double, missed : Double, requirement : Double) -> String{
        if (getPercentage(attended: attended, missed: missed)) > requirement {
            var skippable = Int((attended-requirement*(attended+missed))/requirement)
            return "Can Skip \(skippable) Classes"
        } else if (getPercentage(attended: attended, missed: missed)) < requirement {
            var needToAttend = Int((requirement*(attended+missed)-attended)/(1-requirement))
            return "Must attend \(needToAttend) Classes"
        } else {
            return "Cannot Skip Classes"
        }
    }
}

struct AttendanceCard_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceCard(name: "Test", attended: 22.0, missed: 15.0, requirement: 0.75)
    }
}
