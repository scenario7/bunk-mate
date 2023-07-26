//
//  SettingsView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 22/07/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("proAppIcon") var showProAppIcon = false
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.white]
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
                Color.black.ignoresSafeArea()
                VStack(spacing:20){
                    HStack{
                        Text("Use Pro App Icon")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                        Toggle("", isOn: $showProAppIcon)
                    }
                    Spacer()
//                    Text("Thank you for being a BunkMate Pro user.")
//                        .font(.system(size: 17, weight: .semibold))
//                        .foregroundColor(.white.opacity(0.6))
//                        .multilineTextAlignment(.center)
                    Text(funnySentences[Int.random(in: 0...10)])
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                }
                .padding()
                .navigationTitle("Settings")
            }
            .onChange(of: showProAppIcon) { _ in
                if (showProAppIcon == false) {
                    UIApplication.shared.setAlternateIconName(nil)
                } else {
                    UIApplication.shared.setAlternateIconName("ProAppIcon")
                }
        }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
