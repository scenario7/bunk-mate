//
//  TestsView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 23/11/23.
//

import SwiftUI
import Charts

struct TestsView: View {
    
    let data = [[23,92,80,75,99],[23,92,80,75,99],[23,92,80,75,99],[23,92,80,75,99],[23,92,80,75,99],[23,92,80,75,99]]
    
    var body: some View {
        ZStack(alignment:.topLeading){
            LinearGradient(colors: [Color.black, Color("Primary")], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack{
                HStack {
                    VStack(alignment:.leading){
                        Text(Date().formatted(date: .abbreviated, time: .omitted).uppercased())
                            .foregroundColor(.gray)
                            .font(.system(size: 17, weight: .semibold))
                        Text("Test Performance")
                            .foregroundColor(.white)
                            .font(.system(size: 27, weight: .semibold))
                        
                    }
                    Spacer()
                    Button(action: {
                    }) {
                        ZStack {
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
                    .foregroundColor(.clear)
                    .frame(height: 20)
                ScrollView(.vertical, showsIndicators: false) {
                        
                }
            }
            .padding()
            .ignoresSafeArea(edges:.bottom)
        }
    }
}

#Preview {
    TestsView()
}


struct TestView : View {
    
    let data = [23,92,80,75,99]
    
    var body: some View {
        if #available(iOS 16.0, *){
            VStack(alignment:.leading) {
                HStack {
                    Text("Mathematics")
                        .foregroundColor(.white)
                    .font(.system(size: 22, weight: .regular))
                    Spacer()
                    Text("Avg : 87%")
                        .foregroundColor(.white)
                    .font(.system(size: 15, weight: .regular))
                }
                ZStack{
                    Color.white.opacity(0.1)
                        .blur(radius: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Chart{
                        
                        RuleMark(y: .value("Limit", 33))
                            .foregroundStyle(.gray.opacity(0.2))
                        
                        ForEach(Array(data.enumerated()), id: \.offset) { index, value in
                            LineMark(
                                x: .value("Index", index),
                                y: .value("Value", value)
                            )
                            .foregroundStyle(.purple)
                            
                            PointMark(
                                                x: .value("Index", index),
                                                y: .value("Value", value)
                                            )
                            .foregroundStyle(.white)
                        }
                    }
                    .padding()
                }
                .frame(height: 200)
            }
        } else {
            Text("Unavailable")
        }
    }
}
