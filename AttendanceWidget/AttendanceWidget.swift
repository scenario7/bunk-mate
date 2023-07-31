//
//  AttendanceWidget.swift
//  AttendanceWidget
//
//  Created by Kevin Thomas on 15/07/23.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

struct Provider: TimelineProvider {
    let subjects = getData()

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), subjects: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), subjects: getData())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let midnight = Calendar.current.startOfDay(for: Date())
        let entries = [SimpleEntry(date: midnight, subjects: getData())]
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
    let subjects: [Subject]
}

struct AttendanceWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
            switch(widgetFamily){
            case .systemSmall:
                SmallWidgetView(entry: entry)
                
            case .systemMedium:
                LargeWidgetView(entry: entry)
                
            case .accessoryRectangular:
                if (!StoreController().purchasedBunkMatePro){
                    AccessoryRectangularView(entry: entry)
                } else {
                    Text("Purchase BunkMate Pro")
                }
                
            case .accessoryCircular:
                AccessoryCircular()

            default:
                Text("Unavail")
            }
    }
}

struct SmallWidgetView : View {
    var entry : Provider.Entry
    var subject1 : Subject {
        return entry.subjects[0]
    }
    var subject2 : Subject {
        return entry.subjects[1]
    }
    var subject3 : Subject {
        return entry.subjects[2]
    }
    
    var body: some View{
        ZStack{
            Color.black
            VStack{
                ZStack{
                    Circle()
                        .stroke(lineWidth: 5)
                        .foregroundColor(.gray.opacity(0.5))
                    Circle()
                        .trim(from: 0, to: getPercentage(attended: subject1.attended, missed: subject1.missed))
                        .stroke(lineWidth: 3)
                        .foregroundColor(returnColor(percentage: getPercentage(attended: subject1.attended, missed: subject1.missed), requirement: subject1.requirement))
                        .shadow(color: returnColor(percentage: getPercentage(attended: subject1.attended, missed: subject1.missed), requirement: subject1.requirement), radius: 3)
                        .rotationEffect(Angle(degrees: 270))

                    Text("\(Int((getPercentage(attended: subject1.attended,    missed: subject1.missed)*100)))%")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .medium))
                }
                .frame(height: 70)
                Spacer()
                Text(entry.subjects[0].name!)
                    .font(.system(size: 13, weight: .semibold))
                    .multilineTextAlignment(.center)
                Text(getClassesSkippable(percentage:getPercentage(attended: subject1.attended, missed: subject1.missed),attended:subject1.attended,missed:subject1.missed,requirement:subject1.requirement))
                    .foregroundColor(.white.opacity(0.7))
                .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(.white)
            .padding()
        }
    }


}

func getPercentage(attended : Double, missed: Double) -> Double {
    return ((attended)/(attended+missed))
}
func getClassesSkippable(percentage: Double, attended : Double, missed : Double, requirement : Double) -> String{
    if (getPercentage(attended: attended, missed: missed)) > requirement {
        let skippable = Int((attended-requirement*(attended+missed))/requirement)
        if skippable == 0 {
            return "Cannot skip classes"
        } else {
            return "Can skip next \(skippable)"
        }
    } else if (getPercentage(attended: attended, missed: missed)) < requirement {
        let needToAttend = Int((requirement*(attended+missed)-attended)/(1-requirement))
        return "Must attend next \(needToAttend)"
    } else {
        return "Cannot Skip Classes"
    }
}

func returnColor(percentage : Double, requirement : Double) -> Color{
    if (percentage > requirement){
        return .green
    } else if (percentage > requirement*0.6){
        return .yellow
    } else {
        return .red
    }
}

struct LargeWidgetView : View {
    var entry : Provider.Entry
    var subject1 : Subject {
        return entry.subjects[0]
    }
    var subject2 : Subject {
        return entry.subjects[1]
    }
    var subject3 : Subject {
        return entry.subjects[2]
    }
    var subject4 : Subject {
        return entry.subjects[3]
    }
    
    var body: some View{
        ZStack{
            Color.black
            VStack{
                HStack{
                    Text(subject1.name!)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(Int(getPercentage(attended:subject1.attended, missed:subject1.missed)*100))%")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white)
                    ZStack(alignment:.leading){
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:100, height: 10)
                            .foregroundColor(.gray.opacity(0.5))
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:getPercentage(attended: subject1.attended, missed: subject1.missed)*100, height: 10)
                            .foregroundColor(returnColor(percentage: getPercentage(attended: subject1.attended, missed: subject1.missed), requirement: subject1.requirement))
                    }
                    
                }
                HStack{
                    Text(subject2.name!)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(Int(getPercentage(attended:subject2.attended, missed:subject2.missed)*100))%")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white)
                    ZStack(alignment:.leading){
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:100, height: 10)
                            .foregroundColor(.gray.opacity(0.5))
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:getPercentage(attended: subject2.attended, missed: subject2.missed)*100, height: 10)
                            .foregroundColor(returnColor(percentage: getPercentage(attended: subject2.attended, missed: subject2.missed), requirement: subject2.requirement))
                    }
                    
                }
                HStack{
                    Text(subject3.name!)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(Int(getPercentage(attended:subject3.attended, missed:subject3.missed)*100))%")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white)
                    ZStack(alignment:.leading){
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:100, height: 10)
                            .foregroundColor(.gray.opacity(0.5))
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:getPercentage(attended: subject3.attended, missed: subject3.missed)*100, height: 10)
                            .foregroundColor(returnColor(percentage: getPercentage(attended: subject3.attended, missed: subject3.missed), requirement: subject3.requirement))
                    }
                    
                }
                HStack{
                    Text(subject4.name!)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(Int(getPercentage(attended:subject4.attended, missed:subject4.missed)*100))%")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white)
                    ZStack(alignment:.leading){
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:100, height: 10)
                            .foregroundColor(.gray.opacity(0.5))
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:getPercentage(attended: subject4.attended, missed: subject4.missed)*100, height: 10)
                            .foregroundColor(returnColor(percentage: getPercentage(attended: subject4.attended, missed: subject4.missed), requirement: subject4.requirement))
                    }
                    
                }
            }
            .padding()
        }
    }
    
    func getPercentage(attended : Double, missed: Double) -> Double {
        return ((attended)/(attended+missed))
    }
    func getClassesSkippable(percentage: Double, attended : Double, missed : Double, requirement : Double) -> String{
        if (getPercentage(attended: attended, missed: missed)) > requirement {
            let skippable = Int((attended-requirement*(attended+missed))/requirement)
            return "Can skip next \(skippable)"
        } else if (getPercentage(attended: attended, missed: missed)) < requirement {
            let needToAttend = Int((requirement*(attended+missed)-attended)/(1-requirement))
            return "Must attend next \(needToAttend)"
        } else {
            return "Cannot Skip Classes"
        }
    }

    func returnColor(percentage : Double, requirement : Double) -> Color{
        if (percentage > requirement){
            return .green
        } else if (percentage > requirement*0.6){
            return .yellow
        } else {
            return .red
        }
    }
}
struct AccessoryRectangularView : View {
    var entry : Provider.Entry
    var subject : Subject {
        return entry.subjects[0]
    }
    var body: some View {
        VStack(spacing : 5){
            HStack(spacing:5) {
                Image("circularWidget")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                Rectangle()
                    .frame(width: 1.5, height: 13)
                Text(subject.name!)
                    .fontWeight(.semibold)
                Spacer()
            }
            HStack {
                Text(getClassesSkippable(percentage: getPercentage(attended: subject.attended, missed: subject.missed), attended: subject.attended, missed: subject.missed, requirement: subject.requirement))
                    .font(.system(size: 10))
                Spacer()
            }
            HStack{
                Text("\(Int(getPercentage(attended:subject.attended,missed:subject.missed)*100))%")
                ZStack(alignment:.leading){
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.5)
                        .frame(width: 93, height: 10)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: getPercentage(attended: subject.attended, missed: subject.missed)*93, height: 10)
                }
                Spacer()

            }
        }
    }
    func getPercentage(attended : Double, missed: Double) -> Double {
        return ((attended)/(attended+missed))
    }
    func getClassesSkippable(percentage: Double, attended : Double, missed : Double, requirement : Double) -> String{
        if (getPercentage(attended: attended, missed: missed)) > requirement {
            let skippable = Int((attended-requirement*(attended+missed))/requirement)
            if skippable == 0 {
                return "Cannot skip classes"
            } else {
                return "Can skip next \(skippable)"
            }
        } else if (getPercentage(attended: attended, missed: missed)) < requirement {
            let needToAttend = Int((requirement*(attended+missed)-attended)/(1-requirement))
            return "Attend next \(needToAttend)"
        } else {
            return "Cannot Skip Classes"
        }
    }

    func returnColor(percentage : Double, requirement : Double) -> Color{
        if (percentage > requirement){
            return .green
        } else if (percentage > requirement*0.6){
            return .yellow
        } else {
            return .red
        }
    }
}



struct AccessoryCircular : View {
    var body: some View{
        ZStack{
            Circle()
                .opacity(0.2)
            Image("circularWidget")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct AttendanceWidget: Widget {
    let kind: String = "AttendanceWidget"
        
    private let supportedFamilies: [WidgetFamily] = {
        if #available(iOSApplicationExtension 16.0, *) {
                return [.systemSmall, .systemMedium, .accessoryCircular, .accessoryRectangular]
        } else if #available(iOSApplicationExtension 15.0, *) {
            return [.systemSmall, .systemMedium]
        } else {
            return [.systemSmall, .systemMedium]
        }
    }()
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AttendanceWidgetEntryView(entry: entry)

        }
        .configurationDisplayName("Attendance Widget")
        .description("This widget shows your attendance statistics")
        .supportedFamilies(supportedFamilies)
    }
    
}


private func getData() -> [Subject] {
    let container = DataController.shared.container
    let request = Subject.fetchRequest()
    let sortDescriptor = NSSortDescriptor(keyPath: \Subject.missed, ascending: true) // Sort in ascending order of missed days
    request.sortDescriptors = [sortDescriptor]
    
    var result: [Subject] = []
    
    do {
        result.removeAll()
        result = try container.viewContext.fetch(request) as [Subject]
    } catch {
        fatalError("COULD NOT FETCH: \(error)")
    }
    
    result.sort { (subject1, subject2) -> Bool in
        let attendancePercentage1 = Double(subject1.attended) / Double(subject1.attended + subject1.missed)
        let attendancePercentage2 = Double(subject2.attended) / Double(subject2.attended + subject2.missed)
        return attendancePercentage1 < attendancePercentage2
    }
    
    if result.count < 4 {
        // Calculate the number of fallback subjects needed
        let fallbackCount = 4 - result.count
        
        for _ in 0..<fallbackCount {
            let fallBackSubject = Subject(context: container.viewContext)
            fallBackSubject.name = "Add A Subject"
            fallBackSubject.attended = 3
            fallBackSubject.missed = 0
            fallBackSubject.requirement = 0.75
            result.append(fallBackSubject)
        }
    }
    
    return result
}

@available(iOSApplicationExtension 16.0, *)
struct AttendanceWidget_Previews: PreviewProvider {
    static var previews: some View {
        AttendanceWidgetEntryView(entry: SimpleEntry(date: Date(), subjects: []))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
