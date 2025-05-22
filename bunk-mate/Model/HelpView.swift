//
//  HelpView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 16/10/23.
//

import SwiftUI

struct HelpView: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment:.topLeading){
            LinearGradient(colors: [Color.black, Color("Primary")], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack(alignment:.leading){
                Text("What's New?")                            .foregroundColor(.white)
                    .font(.system(size: 27, weight: .semibold))
                Text("Here's a few tips on how to use BunkMate")                            .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .regular))
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(.clear)
                VStack(alignment:.leading, spacing:30){
                    HStack(spacing:20){
                        Image(systemName: "book.closed")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundColor(Color("Accent"))
                        Text("Add a subject on the attendance tab")                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                    }
                    HStack(spacing:20){
                        Image(systemName: "checkmark.shield")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundColor(Color("Accent"))
                        Text("Track attendance for every subject")                   .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                    }
                    HStack(spacing:20){
                        Image(systemName: "calendar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundColor(Color("Accent"))
                        Text("Add lecture to your schedule on the timetable tab")                   .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                    }
                    HStack(spacing:20){
                        Image(systemName: "hand.tap")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundColor(Color("Accent"))
                        Text("Double tap on a lecture to delete it from your schedule")                   .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                    }
                }
                Spacer()
                Text("Still facing issues? Contact BunkMate support at bunkmate.help@gmail.com")                            .foregroundColor(.gray)
                    .accentColor(Color("Accent"))
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
