//
//  AddLectureView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 02/09/23.
//

import SwiftUI
import CoreData

struct AddLectureView: View {
    
    //@FetchRequest(entity: Subject.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Subject.name, ascending: true)]) var subjects : FetchedResults<Subject>
    
    var subjects = [
    "Chemistry",
    "Mathematics",
    "Biology",
    "Physics"
    ]
    
    var days = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
    ]

    @State var selectedSubject = 0
    @State var selectedDay = 0
    @State var selectedColor = Color.blue
    @State var startTime : Date = Date.now
    @State var endTime : Date = Date.now
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        ZStack(alignment: .top){
            Color.black.ignoresSafeArea()
            VStack(spacing:80){
                Text("Add a Lecture")
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .semibold))
                VStack(spacing:25) {
                    HStack {
                        Text("Select Subject")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular))
                        Spacer()
                        Picker("Select a subject", selection: $selectedSubject) {
                            ForEach(subjects, id: \.self){ subject in
                                Text(subject)
                                    .font(.system(size:20))
                            }
                        }
                        .accentColor(Color("Accent"))
                    }
                    HStack{
                        Text("Select Color")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular))
                        ColorPicker("",selection: $selectedColor)
                            .preferredColorScheme(.dark)
                    }
                    HStack{
                        Text("Day of the Week")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular))
                        Spacer()
                        Picker("", selection: $selectedDay) {
                            ForEach(days, id: \.self){ subject in
                                Text(subject)
                                    .font(.system(size:20))
                            }
                        }
                        .accentColor(Color("Accent"))
                    }
                    HStack{
                        Text("Start Time")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular))
                        Spacer()
                        DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                    }
                    HStack{
                        Text("End Time")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular))
                        Spacer()
                        DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                    }
                }
            }
            .padding()
        }
    }
}

struct AddLectureView_Previews: PreviewProvider {
    static var previews: some View {
        AddLectureView()
    }
}
