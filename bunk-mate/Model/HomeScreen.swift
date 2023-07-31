//
//  HomeScreen.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 11/07/23.
//

import SwiftUI
import CoreData

struct HomeScreen: View {
    
    let constants = Constants()
    
    //@Environment(\.managedObjectContext) var moc
    private var dataController = DataController.shared
    @StateObject var storeController = StoreController()
        
    
    @FetchRequest(entity: Subject.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Subject.name, ascending: true)]) var subjects : FetchedResults<Subject>
    
    @State var addSubjectIsShown = false
    @State private var deleteSubject: Subject?
    @State private var showAlert = false
    @State private var showPurchase = false
    @State private var showSettings = false
    
    @State private var showNotPurchasedAlert = false
    
    let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    
    @State var appleWatchSubjects : [Subject] = []
    
    var actionDate: String {
        let userDefaults = UserDefaults.standard
        if let storedDate = userDefaults.object(forKey: "lua") as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM 'at' HH:mm"
            return dateFormatter.string(from: storedDate)
        }
        return "unknown"
    }
    
    var body: some View {
        ZStack(alignment:.topLeading){
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment:.leading){
                        Text(Date().formatted(date: .abbreviated, time: .omitted).uppercased())
                            .foregroundColor(.gray)
                            .font(.system(size: 17, weight: .semibold))
                        Text("Your Attendance")
                            .foregroundColor(.white)
                            .font(.system(size: 27, weight: .semibold))
                        Text("Last Updated on \(actionDate)")
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .medium))
                        
                    }
                    Spacer()
                    if (!storeController.purchasedBunkMatePro){
                        Button {
                            showPurchase.toggle()
                        } label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(constants.primaryColor)
                                Image(systemName: "bag")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(constants.accent)
                                    .padding(14)
                            }
                            .frame(height: 50)
                        }
                        .sheet(isPresented: $showPurchase) {
                            PurchaseScreen()
                        }
                    } else {
                        Button {
                            showSettings.toggle()
                        } label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(constants.primaryColor)
                                Image(systemName: "gearshape")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(constants.accent)
                                    .padding(14)
                            }
                            .frame(height: 50)
                        }
                        .sheet(isPresented: $showSettings) {
                            SettingsView()
                        }
                    }
                    Button {
                        if ((subjects.count >= 2) && (storeController.purchasedIDs.isEmpty == true)){
                            showNotPurchasedAlert.toggle()
                        } else {
                            addSubjectIsShown.toggle()
                        }
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
                    .sheet(isPresented: $addSubjectIsShown) {
                        AddSubjectView()
                    }
                    
                }
                .padding(.top)
                Rectangle()
                    .frame(height: 8)
                    .foregroundColor(.clear)
                LinearGradient(colors: [.black,constants.accent,.black], startPoint: .leading, endPoint: .trailing)
                    .mask {
                        Rectangle()
                            .frame(height: 3)
                            .foregroundColor(constants.accent)
                    }
                    .frame(height: 3)
                Rectangle()
                    .frame(height: 8)
                    .foregroundColor(.clear)
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns:columns, spacing : 10){
                            ForEach(subjects){ subject in
                                VStack {
                                    AttendanceCard(name: subject.name ?? "Unknown", attended: subject.attended, missed: subject.missed, requirement: subject.requirement)
                                    HStack(alignment:.bottom){
                                        VStack(alignment:.center) {
                                            Text("Attended")
                                                .font(.system(size: 13))
                                                .foregroundColor(.white)
                                            HStack{
                                                Button {
                                                    subject.attended-=1
                                                    dataController.saveData()
                                                } label: {
                                                    Image(systemName: "minus.circle")
                                                        .foregroundColor((subject.attended==0) || (subject.missed==0 && subject.attended==1) ? .gray : constants.accent)
                                                        .padding(4)
                                                        .frame(width:30, height:30)
                                                        .background {
                                                            constants.primaryColor
                                                        }
                                                        .cornerRadius(8)
                                                }
                                                .disabled((subject.attended==0) || (subject.missed==0 && subject.attended==1))
                                                Button {
                                                    subject.attended+=1
                                                    dataController.saveData()
                                                    

                                                } label: {
                                                        Image(systemName: "plus.circle")
                                                            .foregroundColor(constants.accent)
                                                            .padding(4)
                                                            .frame(width:30, height:30)
                                                            .background {
                                                                constants.primaryColor
                                                            }
                                                            .cornerRadius(8)
                                                    }
                                                
                                            }
                                        }
                                        Spacer()
                                        Button {
                                            deleteSubject = subject
                                            showAlert = true
                                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                                        } label: {
                                            Text("Delete")
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(.red)
                                                .padding(7)
                                                .background {
                                                    Color.red.opacity(0.2)
                                                }
                                                .cornerRadius(8)
                                        }
                                        .alert(isPresented: $showNotPurchasedAlert) {
                                            Alert(
                                                title: Text("BunkMate Pro Required"),
                                                message: Text("Tracking more than 2 subjects requires a BunkMate Pro subscription"),
                                                primaryButton: .cancel(Text("Ok")),
                                                secondaryButton: .default(Text("Purchase"), action: {
                                                    showNotPurchasedAlert.toggle()
                                                    showPurchase.toggle()
                                                })
                                            )
                                        }
                                        Spacer()
                                        
                                        VStack {
                                            Text("Missed")
                                                .font(.system(size: 13))
                                                .foregroundColor(.white)
                                            HStack{
                                                Button {
                                                    subject.missed-=1
                                                    dataController.saveData()
                                                    

                                                } label: {
                                                        Image(systemName: "minus.circle")
                                                            .foregroundColor((subject.attended==0 && subject.missed==1) || (subject.missed==0) ? .gray : constants.accent)
                                                            .padding(4)
                                                            .frame(width:30, height:30)
                                                            .background {
                                                                constants.primaryColor
                                                            }
                                                            .cornerRadius(8)
                                                    }
                                                    .disabled((subject.attended==0 && subject.missed==1) || (subject.missed==0))
                                                
                                                Button {
                                                    subject.missed+=1
                                                    dataController.saveData()
                                                    
                                                } label: {
                                                        Image(systemName: "plus.circle")
                                                            .foregroundColor(constants.accent)
                                                            .padding(4)
                                                            .frame(width:30, height:30)
                                                            .background {
                                                                constants.primaryColor
                                                            }
                                                            .cornerRadius(8)
                                                    }
                                                
                                            }
                                            .alert(isPresented: $showAlert) {
                                                Alert(
                                                    title: Text("Confirm Deletion"),
                                                    message: Text("Are you sure you want to delete \(deleteSubject!.name ?? "this subject")?"),
                                                    primaryButton: .cancel(Text("Cancel")),
                                                    secondaryButton: .destructive(Text("Delete")) {
                                                        deleteSubjectAction()
                                                    }
                                                )
                                            }
                                        }
                                    }
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(height:20)

                                }
                                
                            }
                        }
                    }
                    .ignoresSafeArea()
            }
            .padding(.horizontal)
            .onAppear{
                storeController.fetchProducts()
            }
            .statusBar(hidden: true)

        }
    }
    
    func deleteSubjectAction() {
            guard let subject = deleteSubject else {
                return
            }
            
            dataController.container.viewContext.delete(subject)
            dataController.saveData()
            deleteSubject = nil
        }
}
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
