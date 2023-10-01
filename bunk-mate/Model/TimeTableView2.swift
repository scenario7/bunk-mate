//
//  TimeTableView2.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 26/08/23.
//

import SwiftUI

struct TimeTableView2: View {
    
    @State var addLectureShowing = false
    
    var days = [0,1,2,3,4,5,6]
        
    var body: some View {
        ZStack(alignment:.topLeading){
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment:.leading){
                        Text("Class Schedule")
                            .foregroundColor(.white)
                            .font(.system(size: 27, weight: .semibold))
                        
                    }
                    Spacer()
                    Button {
                        addLectureShowing.toggle()
                    } label: {
                        ZStack{
                            Circle()
                                .foregroundColor(Color("Primary"))
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("Accent"))
                                .padding(14)
                        }
                        .frame(height: 50)
                    }

                }
                Rectangle()
                    .frame(height: 30)
                    .foregroundColor(.clear)
                TabView {
                    ForEach(days, id:\.self){ day in
                        DayView(day: day)
                    }
                }
                .tabViewStyle(.page)

            }
            .padding()
        }
        .sheet(isPresented: $addLectureShowing) {
            AddLectureView()
        }
    }
}

struct TimeTableView2_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableView2()
    }
}


import SwiftUI

struct LectureCardView: View {
    var subjectName: String
    var startTime: Date
    var endTime: Date
    var color: Color
    var skippable: Bool
    
    // DateFormatter for formatting the time
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color("Primary"))
                .shadow(color: color, radius: 0, x: 0, y: 3)
            HStack {
                    Text(subjectName)
                        .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))

                Spacer()
                VStack(alignment:.trailing) {
                    Text(skippable ? "Can skip" : "Cannot skip")
                        .foregroundColor(skippable ? .green : .red)
                    .font(.system(size: 15, weight: .semibold))
                    Text("\(timeFormatter.string(from: startTime)) to \(timeFormatter.string(from: endTime))")
                        .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .medium))
                }
            }
            .padding()
        }
    }
}


struct DayView: View {
    
    var day : Int
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing:20) {
                Text(returnDayName(number:day))
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                LectureCardView(subjectName: "Chemistry", startTime: Date.now, endTime: Date.now, color: .yellow, skippable: true)
                LectureCardView(subjectName: "Mathematics", startTime: Date.now, endTime: Date.now, color: .blue, skippable: true)
                LectureCardView(subjectName: "Biology", startTime: Date.now, endTime: Date.now, color: .orange, skippable: false)
            }
        }
        .padding([.leading,.trailing], 10)
        .background{
            Color.black.ignoresSafeArea()
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
            day =  "Friday"
            break
        case 4:
            day =  "Saturday"
            break
        case 5:
            day =  "Sunday"
            break
        default:
            day =  "Invalid"
            break
        }
        
        return day
    }
    
}
