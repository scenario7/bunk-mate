//
//  TimeTableView2.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 26/08/23.
//

import SwiftUI

struct TimeTableView2: View {
    @State private var addLectureShowing = false
    @AppStorage("currentDay") var currentDayIndex = 0
    @State private var showHelp : Bool = false

    @FetchRequest(entity: Subject.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Subject.name, ascending: true)]) var subjects: FetchedResults<Subject>

    var days = [0, 1, 2, 3, 4, 5, 6]
    

    var body: some View {
        ZStack(alignment: .topLeading) {
            LinearGradient(colors: [Color.black, Color("Primary")], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment:.leading){
                        Text(Date().formatted(date: .abbreviated, time: .omitted).uppercased())
                            .foregroundColor(.gray)
                            .font(.system(size: 17, weight: .semibold))
                        Text("Class Schedule")
                            .foregroundColor(.white)
                            .font(.system(size: 27, weight: .semibold))
                        
                    }
                    Spacer()
                    Button(action: {
                        self.showHelp.toggle()
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("Primary"))
                            Image(systemName: "questionmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("Accent"))
                                .padding(14)
                        }
                        .frame(height: 50)
                    }
                    Button(action: {
                        addLectureShowing.toggle()
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(subjects.isEmpty ? .gray : Color("Primary"))
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(subjects.isEmpty ? .white : Color("Accent"))
                                .padding(14)
                        }
                        .frame(height: 50)
                    }
                    .disabled(subjects.isEmpty)
                }
                Rectangle()
                    .frame(height: 10)
                    .foregroundColor(.clear)

                // Set the initial selection of the TabView based on the current day
                TabView(selection: $currentDayIndex) {
                    ForEach(days, id: \.self) { day in
                        DayView(day: day)
                            .tag(day)
                    }
                }
                .tabViewStyle(.page)
            }
            .padding()
        }
        .sheet(isPresented: $addLectureShowing) {
            AddLectureView(selectedSubject: subjects.first!)
        }
        .sheet(isPresented: $showHelp, content: {
            HelpView()
        })
        .statusBar(hidden: true)
    }
}

struct TimeTableView2_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableView2()
    }
}



struct LectureCardView: View {
    var subjectName: String
    var startTime: Date
    var endTime: Date
    var color: Color
    var skippable: Bool
    var subject : Subject

    // DateFormatter for formatting the time
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    @State private var showSkippable = true
    private let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            ZStack {
                LinearGradient(colors: [color, .black], startPoint: .bottomLeading, endPoint: .topTrailing)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 15)
                    )
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color("Primary"))
                    .padding(1)
            }
            HStack(alignment:.center) {
                VStack(alignment:.leading){
                    Text(subjectName)
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .semibold))
                    Text("\(timeFormatter.string(from: startTime)) to \(timeFormatter.string(from: endTime))")
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .medium))
                }

                Spacer()
                VStack(alignment:.trailing) {
                    if showSkippable {
                        Text(skippable ? "Can Skip" : "Cannot Skip")
                            .foregroundColor(skippable ? .green : .red)
                            .font(.system(size: 15, weight: .semibold))
                    } else {
                        Text(String(format: "%.0f%%", (((subject.attended)/(subject.attended+subject.missed))*100)))
                            .foregroundColor(skippable ? .green : .red)
                            .font(.system(size: 15, weight: .medium))
                    }
                }
            }
            .padding()
        }
        .onReceive(timer) { _ in
            showSkippable.toggle()
        }
        .statusBar(hidden: true)
    }
}



struct DayView: View {
    
    @FetchRequest(entity: Lecture.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Lecture.startTime, ascending: true)]) var lectures : FetchedResults<Lecture>
    
    
    let dataController = DataController.shared
    
    @State private var currentDayIndex = Calendar.current.component(.weekday, from: Date()) - 2
    
    @State var deleteLecture : Lecture?
    @State var showAlert = false
    
    var day : Int
    
    var body: some View {
            VStack(spacing:20) {
                Text(returnDayName(number:day).uppercased())
                    .foregroundColor(Color("Accent"))
                    .font(.system(size: 17, weight: .semibold))
                    .padding([.top,.bottom],8)
                    .padding([.leading,.trailing],12)
                    .cornerRadius(20)
                    .background{
                        Color("Primary")
                            .cornerRadius(20)
                    }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        ForEach(lectures, id: \.self){ lecture in
                            if(lecture.day == day){
                                LectureCardView(subjectName: lecture.toSubject?.name ?? "Unknown", startTime: lecture.startTime!, endTime: lecture.endTime!, color: Color(UIColor(red: lecture.redValue, green: lecture.greenValue, blue: lecture.blueValue, alpha: 1)), skippable: skippableOrNot(lecture: lecture), subject:lecture.toSubject!)
                                    .onTapGesture(count:2,perform: {
                                        deleteLecture = lecture
                                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                        showAlert.toggle()
                                    })
                                    .padding(3)
                            }
                            
                        }
                    }
                }

            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to delete \(returnDayName(number:Int(deleteLecture!.day)))'s \(deleteLecture?.toSubject?.name ?? "this subject") lecture?"),
                    primaryButton: .cancel(Text("Cancel")),
                    secondaryButton: .destructive(Text("Delete")) {
                        dataController.container.viewContext.delete(deleteLecture!)
                        dataController.saveData()
                        deleteLecture = nil
                    }
                )
            }
            .statusBar(hidden: true)
        .padding([.leading,.trailing], 10)
        .background{
            Color.clear
        }
    }
    
    func skippableOrNot(lecture : Lecture) -> Bool {
        let attended = lecture.toSubject!.attended
        let missed = lecture.toSubject!.missed
        let total = attended+missed
        let requirement = lecture.toSubject!.requirement
        
        let skippable = Int((attended-requirement*(attended+missed))/requirement)
        
        if(skippable <= 0){
            return false
        } else {
            return true
        }
    }
    
    func returnDayName(number:Int) -> String{
        
        var day = ""
        
        switch(number){
        case 0:
            day = "Monday"
            break
        case 1:
            day = "Tuesday"
            break
        case 2:
            day =  "Wednesday"
            break
        case 3:
            day =  "Thursday"
            break
        case 4:
            day =  "Friday"
            break
        case 5:
            day =  "Saturday"
            break
        default:
            day =  "Sunday"
            break
        }
        
        return day
    }
    
}
