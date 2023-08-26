//
//  AddSubjectView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 11/07/23.
//

import SwiftUI
import CoreData

struct AddSubjectView: View {
    
    let constants = Constants()
    
    //@Environment(\.managedObjectContext) var moc
    private var dataController = DataController.shared
    
    
    @State var subjectName = ""
    @State var attended : Double = 1.0
    @State var missed : Double = 0.0
    @State var requirement : Double = 75.0
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment:.top){
            Color.black.ignoresSafeArea()
            VStack(spacing:30){
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
                HStack(/*spacing:30*/){
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
                        Text("\(Int(attended))")
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
                    Spacer()
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
                        Text("\(Int(missed))")
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
                    Spacer()
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
                        Text("\(Int((requirement)))%")
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
                .padding()
                Button {
                    let newSubject = Subject(context: dataController.container.viewContext)
                    newSubject.name = subjectName.trimmingCharacters(in: .whitespacesAndNewlines)
                    newSubject.attended = attended
                    newSubject.missed = missed
                    newSubject.requirement = requirement*0.01
                                        
                    dataController.saveData()
                    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(constants.primaryColor)
                        Text("Add")
                            .foregroundColor(subjectName.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? .gray : constants.accent)
                            .font(.system(size: 17, weight: .medium))
                    }
                    .frame(width: 120, height: 50)
                }
                .disabled(subjectName.trimmingCharacters(in: .whitespacesAndNewlines) == "")
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
