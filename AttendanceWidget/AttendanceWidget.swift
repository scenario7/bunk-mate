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

struct Provider: IntentTimelineProvider {
    
    let subjects = getData()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), subjects: getData())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        print("Snapshot called")
        let entry = SimpleEntry(date: Date(), configuration: configuration, subjects: getData())
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print("TimeLine called")

        let entry = SimpleEntry(date: Date(), configuration: configuration, subjects: getData())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration : ConfigurationIntent
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
                AccessoryRectangularView(entry: entry)
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
                        .animation(.easeInOut)
                        .shadow(color: returnColor(percentage: getPercentage(attended: subject1.attended, missed: subject1.missed), requirement: subject1.requirement), radius: 3)
                        .rotationEffect(Angle(degrees: 270))

                    Text("\(Int((getPercentage(attended: subject1.attended,    missed: subject1.missed)*100)))%")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .medium))
                }
                .frame(height: 70)
                Spacer()
                Text(entry.subjects[0].name!)
                    .font(.system(size: 15, weight: .semibold))
                    .multilineTextAlignment(.center)
                Spacer()
                Text(getClassesSkippable(percentage:getPercentage(attended: subject1.attended, missed: subject1.missed),attended:subject1.attended,missed:subject1.missed,requirement:subject1.requirement))
                    .foregroundColor(.white.opacity(0.7))
                .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(.white)
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
        VStack{
            Text(subject.name!)
                .fontWeight(.semibold)
            HStack{
                Text("\(Int(getPercentage(attended:subject.attended,missed:subject.missed)*100))%")
                ZStack(alignment:.leading){
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.5)
                        .frame(width: 93, height: 10)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: getPercentage(attended: subject.attended, missed: subject.missed)*93, height: 10)
                }
            }
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
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            AttendanceWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.accessoryRectangular,.systemSmall,.systemMedium,.accessoryCircular])
    }
}

private func getData() -> [Subject] {
    let container = DataController.shared.container
    let request = Subject.fetchRequest()
    let sortDescriptor = NSSortDescriptor(keyPath: \Subject.missed, ascending: false)
    request.sortDescriptors = [sortDescriptor]
    
    var result: [Subject] = []
    
    do {
        result.removeAll()
        result = try container.viewContext.fetch(request) as [Subject]
        print("RESULT BEFORE MOD")
        print(result)
    } catch {
        fatalError("COULD NOT FETCH: \(error)")
    }
    
    // Check if there are less than three subjects and add fallback subjects accordingly
    let missingSubjectsCount = max(0, 3 - result.count)
    if missingSubjectsCount > 0 {
        let fallBack = Subject(context: container.viewContext)
        fallBack.name = "Add A Subject"
        fallBack.attended = 2
        fallBack.missed = 1
        fallBack.requirement = 0.6
        
        for _ in 0..<missingSubjectsCount {
            result.append(fallBack)
        }
    }
    
    print("RESULT IS")
    print(result)
    
    return result
}


