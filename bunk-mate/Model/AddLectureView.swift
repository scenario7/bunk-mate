//
//  AddLectureView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 02/09/23.
//

import SwiftUI
import CoreData

struct AddLectureView: View {
    
    var dataController = DataController.shared
    
    @FetchRequest(entity: Subject.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Subject.name, ascending: true)]) var subjects : FetchedResults<Subject>
    
    
    /*
    var subjects = [
    "Chemistry",
    "Mathematics",
    "Biology",
    "Physics"
    ]
    */
    
    var days = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
    ]

    @State var selectedSubject : Subject
    @State var selectedDay = 0
    @State var selectedColor = Color("Accent")
    @State var startTime : Date = Date.now
    @State var endTime : Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date.now)!
    @State var showColorBar : Bool = true
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top){
            LinearGradient(colors: [Color.black, Color("Primary")], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
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
                        Picker("Select a subject", selection: self.$selectedSubject) {
                            ForEach(subjects, id: \.self) { subject in
                                Text(subject.name ?? "Select Subject")
                                    .font(.system(size: 20))
                                    .tag(Optional(subject))
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(Color("Accent"))
                    }
                    HStack{
                        Text("Select Color")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular))
                        Spacer()
                        ColorPicker(selection: $selectedColor) {
                            Text("Choose")
                        }

                    }
                    HStack{
                        Text("Day of the Week")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular))
                        Spacer()
                        Picker("", selection: $selectedDay) {
                            Text("Monday").tag(0)
                            Text("Tuesday").tag(1)
                            Text("Wednesday").tag(2)
                            Text("Thursday").tag(3)
                            Text("Friday").tag(4)
                            Text("Saturday").tag(5)
                            Text("Sunday").tag(6)
                        }
                        .accentColor(Color("Accent"))
                    }
                    HStack{
                        Text("Start Time")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular))
                        Spacer()
                        DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                            .colorScheme(.dark)
                    }
                    HStack{
                        Text("End Time")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .regular))
                        Spacer()
                        DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                            .colorScheme(.dark)
                    }
                    Button {
                        let newLecture = Lecture(context: dataController.container.viewContext)
                        newLecture.toSubject = selectedSubject
                        newLecture.day = Int16(selectedDay)
                        newLecture.redValue = Double(UIColor(selectedColor).cgColor.components?[0] ?? 0.0)
                        newLecture.greenValue = Double(UIColor(selectedColor).cgColor.components?[1] ?? 0.0)
                        newLecture.blueValue = Double(UIColor(selectedColor).cgColor.components?[2] ?? 0.0)
                        newLecture.startTime = startTime
                        newLecture.endTime = endTime
                        dataController.saveData()
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(((endTime < startTime) || subjects.count == 0) ? .gray : Color("Primary"))
                            Text("Add")
                                .foregroundColor(((endTime < startTime) || subjects.count == 0) ? .black : Color("Accent"))
                                .font(.system(size: 17, weight: .medium))
                        }
                        .frame(width: 120, height: 50)
                    }
                    .disabled(((endTime < startTime) || subjects.count == 0))
                    if(endTime<startTime){
                        Text("End time cannot be before start time.")
                            .foregroundColor(.red)
                    }

                }
            }
            .padding()
        }
    }
}

//struct AddLectureView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddLectureView()
//    }
//}

