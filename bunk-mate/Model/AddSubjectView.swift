//
//  AddSubjectView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 11/07/23.
//

import SwiftUI

struct AddSubjectView: View {
    
    let constants = Constants()
    
    @State var subjectName = ""
    @State var attended = 1
    @State var missed = 0
    @State var requirement = 75
    
    var body: some View {
        ZStack(alignment:.top){
            Color.black.ignoresSafeArea()
            VStack{
                Text("Subject Name")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                VStack {
                    TextField("Ex. Biology", text: $subjectName)
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .semibold))
                        .multilineTextAlignment(.center)
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width:300,height: 1)
                }
                HStack(spacing:30){
                    VStack{
                        Button {
                            attended+=1
                        } label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(constants.primaryColor)
                                Image(systemName: "chevron.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(constants.accent)
                                    .padding(19)
                            }
                            .frame(height: 50)
                        }
                        Text("\(attended)")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Attended")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.white)
                        Button {
                            attended-=1
                        } label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(constants.primaryColor)
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor((attended==0) || (missed==0 && attended==1) ? .gray : constants.accent)
                                    .padding(19)
                            }
                            .frame(height: 50)
                        }
                        .disabled((attended==0) || (missed==0 && attended==1))
                    }
                    VStack{
                        Button {
                            missed+=1
                        } label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(constants.primaryColor)
                                Image(systemName: "chevron.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(constants.accent)
                                    .padding(19)
                            }
                            .frame(height: 50)
                        }
                        Text("\(missed)")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Missed")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.white)
                        Button {
                            missed-=1
                        } label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(constants.primaryColor)
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor((attended==0 && missed==1) || (missed==0) ? .gray : constants.accent)
                                    .padding(19)
                            }
                            .frame(height: 50)
                        }
                        .disabled((attended==0 && missed==1) || (missed==0))
                    }
                    VStack{
                        Button {
                            requirement += 5
                        } label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(constants.primaryColor)
                                Image(systemName: "chevron.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(requirement>91 ? .gray : constants.accent)
                                    .padding(19)
                            }
                            .frame(height: 50)
                        }
                        .disabled(requirement>91)
                        Text("\(((requirement)))%")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Requirement")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.white)
                        Button {
                            requirement -= 5
                        } label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(constants.primaryColor)
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(requirement < 9 ? .gray : constants.accent)
                                    .padding(19)
                            }
                            .frame(height: 50)
                        }
                        .disabled(requirement < 9)
                    }
                }
            }
            .padding()
        }
    }
}

struct AddSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectView()
    }
}
