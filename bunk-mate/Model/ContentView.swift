//
//  ContentView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 11/07/23.
//

import SwiftUI

struct ContentView: View {
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().tintColor = UIColor(named: "Accent")
        UITabBar.appearance().selectedItem?.badgeColor = UIColor(named: "Accent")
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        TabView{
            HomeScreen()
                .tabItem {
                    VStack{
                        Image(systemName: "graduationcap")
                        Text("Attendance")
                    }
                }
            TimeTableView2()
                .tabItem {
                    VStack{
                        Image(systemName: "calendar")
                        Text("Timetable")
                    }
                }
        }
        .accentColor(Color("Accent"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
