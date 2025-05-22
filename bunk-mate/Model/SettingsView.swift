//
//  SettingsView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 22/07/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("proAppIcon") var showProAppIcon = false
    @State private var isCircleVisible = true
    @AppStorage("allowNotifications") var allowNotifications = false
    @AppStorage("reminderTime") var reminderTimeShadow: Double = 0
    
    @FetchRequest(entity: Subject.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Subject.name, ascending: true)]) var subjects: FetchedResults<Subject>
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    let funnySentences: [String] = [
        "You've joined the elite club of attendance aficionados! Welcome! 🙏",
        "Congratulations on reaching Pro level! Your attendance game just got real. 📈",
        "With great power comes great responsibility... and unlimited subject tracking! 💪",
        "By going Pro, you've unlocked the secrets of attendance mastery. Use it wisely! 🤓",
        "You're now the CEO of attendance management. Meetings with yourself allowed! 💼",
        "Welcome to the Pro party! Attendance tracking will never be the same again. 🪩",
        "To Pro or not to Pro? You chose Pro and gained unlimited awesomeness! 🤙",
        "Prepare for attendance domination! Pro users always come out on top! 🔝",
        "You're now part of the Pro league. High fives, virtual confetti! 🎉",
        "Did you hear the news? You're officially a Pro-attendee. 👏",
        "Enjoy unlimited subject tracking and show em who's boss 😎"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color.black, Color("Primary")], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    HStack {
                        Text("Use Pro App Icon")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                        Toggle("", isOn: $showProAppIcon)
                    }
                    HStack {
                        Text("Daily Reminder")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                        Toggle("", isOn: $allowNotifications)
                            .onChange(of: allowNotifications, perform: { newValue in
                                if newValue {
                                    NotificationController.shared.scheduleNotification()
                                }
                            })
                        .toggleStyle(SwitchToggleStyle(tint: Color("Accent")))
                    }
                    Spacer()
                    HStack {
                        VStack {
                            Text("Attended")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .semibold))
                            Text("\(returnAttended())")
                                .foregroundColor(.white)
                                .font(.system(size: 45, weight: .semibold))
                        }
                        Spacer()
                        VStack {
                            Text("Missed")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .semibold))
                            Text("\(returnMissed())")
                                .foregroundColor(.white)
                                .font(.system(size: 45, weight: .semibold))
                        }
                        Spacer()
                        VStack {
                            Text("Overall %")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .semibold))
                            Text(String(format: "%.0f%%", returnOVR()))
                                .foregroundColor(Color("Accent"))
                                .font(.system(size: 45, weight: .semibold))
                        }
                    }
                    .padding()
                    Text(funnySentences[Int.random(in: 0...10)])
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                }
                .padding()
                .navigationTitle("Settings")
            }
            .onChange(of: showProAppIcon) { _ in
                if !showProAppIcon {
                    UIApplication.shared.setAlternateIconName(nil)
                } else {
                    UIApplication.shared.setAlternateIconName("ProAppIcon")
                }
            }
        }
    }
    
    private func returnAttended() -> Int {
        subjects.reduce(0) { $0 + Int($1.attended) }
    }
    
    private func returnMissed() -> Int {
        subjects.reduce(0) { $0 + Int($1.missed) }
    }
    
    private func returnOVR() -> Double {
        let attended = Double(returnAttended())
        let missed = Double(returnMissed())
        let total = attended + missed
        return (attended / total) * 100.0
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
