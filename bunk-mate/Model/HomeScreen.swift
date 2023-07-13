//
//  HomeScreen.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 11/07/23.
//

import SwiftUI
import CoreData

struct HomeScreen: View {
    
    let constants = Constants()
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Subject.entity(), sortDescriptors: []) var subjects : FetchedResults<Subject>
    
    @State var addSubjectIsShown = false
    
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
                        addSubjectIsShown.toggle()
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
                    .sheet(isPresented: $addSubjectIsShown) {
                        AddSubjectView()
                    }
                    
                }
                Rectangle()
                    .frame(height: 30)
                    .foregroundColor(.clear)
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(subjects){ subject in
                        VStack {
                            AttendanceCard(name: subject.name ?? "Unknown", attended: subject.attended, missed: subject.missed, requirement: subject.requirement)
                            HStack(alignment:.bottom){
                                VStack {
                                    Text("Attended")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    HStack{
                                        Button {
                                            subject.attended-=1
                                            try? moc.save()
                                        } label: {
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(constants.accent)
                                                .padding(4)
                                                .background {
                                                    constants.primaryColor
                                                }
                                                .cornerRadius(8)
                                        }
                                        Button {
                                            subject.attended+=1
                                            try? moc.save()                                    } label: {
                                            Image(systemName: "plus.circle")
                                                .foregroundColor(constants.accent)
                                                .padding(4)
                                                .background {
                                                    constants.primaryColor
                                                }
                                                .cornerRadius(8)
                                        }

                                    }
                                }
                                Spacer()
                                Button {
                                    moc.delete(subject)
                                    try? moc.save()
                                } label: {
                                    Text("Delete")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.red)
                                        .padding(7)
                                        .background {
                                            Color.red.opacity(0.2)
                                        }
                                        .cornerRadius(8)
                                }
                                Spacer()

                                VStack {
                                    Text("Missed")
                                        .font(.system(size: 13))
                                        .foregroundColor(.white)
                                    HStack{
                                        Button {
                                            subject.missed-=1
                                            try? moc.save()                                    } label: {
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(constants.accent)
                                                .padding(4)
                                                .background {
                                                    constants.primaryColor
                                                }
                                                .cornerRadius(8)
                                        }
                                        Button {
                                            subject.missed+=1
                                            try? moc.save()                                    } label: {
                                            Image(systemName: "plus.circle")
                                                .foregroundColor(constants.accent)
                                                .padding(4)
                                                .background {
                                                    constants.primaryColor
                                                }
                                                .cornerRadius(8)
                                        }

                                    }
                                }
                            }
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height:20)
                        }
                        .animation(.easeInOut)

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
