//
//  HistoricalView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 26/08/23.
//

import SwiftUI

struct HistoricalView: View {
        
    
    @FetchRequest(entity: HistoricAction.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \HistoricAction.dateSavedAt, ascending: false)]) var actions : FetchedResults<HistoricAction>
    
    @Environment(\.presentationMode) var presentingHistory
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, yyyy 'at' HH:mm"
        return formatter
    }()
    
    var body: some View {
        
        ZStack(alignment:.topLeading){
            LinearGradient(colors: [Color.black, Color("Primary")], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea();                VStack(alignment:.leading){
                    Text("Attendance History")
                        .foregroundColor(.white)
                        .font(.system(size: 27, weight: .semibold))
                    Rectangle()
                        .frame(height:30)
                        .foregroundColor(.clear)
                    ScrollView(.vertical, showsIndicators: true) {
                        ForEach(actions){ action in
                            HStack {
                                VStack(alignment:.leading){
                                    Text("\(action.subjectName ?? "unknown") \(action.incremented ? "increased" : "decreased") \(action.attended ? "attended" : "missed")")
                                        .foregroundColor(.white)
                                        .font(.system(size: 17, weight: .regular))
                                    Text(Self.dateFormatter.string(from: action.dateSavedAt ?? Date()))
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .regular))
                                }
                                .padding([.top,.bottom], 5)
                                Spacer()
                                Image(systemName: action.incremented ? "chevron.up": "chevron.down")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(action.incremented ? .green : .red)
                                    .frame(width: 15)
                            }
                        }
                    }
                    
                }
                .padding()
        }
    }
}

struct HistoricalView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalView()
    }
}
