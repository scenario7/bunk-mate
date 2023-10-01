//
//  TimeTableView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 15/08/23.
//

import SwiftUI

struct TimeTableView: View {
    
    let constants = Constants()
    
    let subjects = [
    "Mathematics",
    "Chemistry",
    "DS & Algo",
    "History",
    "Basic Electrical Technology"
    ]
    
    var body: some View {
        ZStack(alignment:.topLeading){
            Color.black.ignoresSafeArea()
            VStack(alignment:.leading){
                HStack {
                    VStack(alignment:.leading){
                        Text(Date().formatted(.dateTime.weekday(.wide)).uppercased())
                            .foregroundColor(.gray)
                            .font(.system(size: 17, weight: .semibold))
                        Text("Class Schedule")
                            .foregroundColor(.white)
                            .font(.system(size: 27, weight: .semibold))
                        
                    }
                    Spacer()
                    Button {
                        print("Hello")
                    } label: {
                        ZStack{
                            Circle()
                                .foregroundColor(constants.primaryColor)
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(constants.accent)
                                .padding(14)
                        }
                        .frame(height: 50)
                    }

                }
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment:.leading){
                        Text("Monday")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                        ScrollView(.horizontal){
                            HStack(spacing:15){
                                ForEach(subjects, id: \.self){ subject in
                                    ZStack(alignment:.topLeading){
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(subject=="Chemistry" ? constants.accent : constants.primaryColor)
                                        VStack(alignment:.leading) {
                                            Text(subject)
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(subject=="Chemistry" ? .black : .white)
                                            Spacer()
                                            Text("9:00 to 10:00")
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                    }
                                    .frame(width: 180, height: 100)
                                    
                                }
                            }
                            .padding()
                        }
                        Text("Tuesday")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                        ScrollView(.horizontal){
                            HStack(spacing:15){
                                ForEach(subjects, id: \.self){ subject in
                                    ZStack(alignment:.topLeading){
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(subject=="Chemistry" ? constants.accent : constants.primaryColor)
                                        VStack(alignment:.leading) {
                                            Text(subject)
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(subject=="Chemistry" ? .black : .white)
                                            Spacer()
                                            Text("9:00 to 10:00")
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                    }
                                    .frame(width: 180, height: 100)
                                    
                                }
                            }
                            .padding()
                        }
                        Text("Wednesday")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                        ScrollView(.horizontal){
                            HStack(spacing:15){
                                ForEach(subjects, id: \.self){ subject in
                                    ZStack(alignment:.topLeading){
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(subject=="Chemistry" ? constants.accent : constants.primaryColor)
                                        VStack(alignment:.leading) {
                                            Text(subject)
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(subject=="Chemistry" ? .black : .white)
                                            Spacer()
                                            Text("9:00 to 10:00")
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                    }
                                    .frame(width: 180, height: 100)
                                    
                                }
                            }
                            .padding()
                        }
                        Text("Thursday")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                        ScrollView(.horizontal){
                            HStack(spacing:15){
                                ForEach(subjects, id: \.self){ subject in
                                    ZStack(alignment:.topLeading){
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(subject=="Chemistry" ? constants.accent : constants.primaryColor)
                                        VStack(alignment:.leading) {
                                            Text(subject)
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(subject=="Chemistry" ? .black : .white)
                                            Spacer()
                                            Text("9:00 to 10:00")
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                    }
                                    .frame(width: 180, height: 100)
                                    
                                }
                            }
                            .padding()
                        }
                        Text("Friday")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                        ScrollView(.horizontal){
                            HStack(spacing:15){
                                ForEach(subjects, id: \.self){ subject in
                                    ZStack(alignment:.topLeading){
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(subject=="Chemistry" ? constants.accent : constants.primaryColor)
                                        VStack(alignment:.leading) {
                                            Text(subject)
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(subject=="Chemistry" ? .black : .white)
                                            Spacer()
                                            Text("9:00 to 10:00")
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                    }
                                    .frame(width: 180, height: 100)
                                    
                                }
                            }
                            .padding()
                        }
                    }
                    VStack(alignment: .center, spacing:10){
                        HStack {
                            Text("Your stats".uppercased())
                                .foregroundColor(.gray)
                            .fontWeight(.semibold)
                        }
                        HStack{
                            VStack{
                                Text("47")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25, weight: .bold))
                                Text("Attended")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            Spacer()
                            VStack{
                                Text("23")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25, weight: .bold))
                                Text("Missed")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            Spacer()
                            VStack{
                                Text("87%")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25, weight: .bold))
                                Text("Overall")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                    }
                    .padding([.leading, .trailing])
                }
                .ignoresSafeArea()


            }
            .padding([.top,.leading,.trailing])
        }
    }
}

struct TimeTableView_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableView()
    }
}
