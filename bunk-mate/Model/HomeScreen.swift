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
    
    @AppStorage("currentDay") var currentDayIndex = 0
        
    
    @FetchRequest(entity: Subject.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Subject.name, ascending: true)]) var subjects : FetchedResults<Subject>
    
    @State var showAdvert = false
    
    @State var addSubjectIsShown = false
    @State var historyIsShown = false
    @State private var deleteSubject: Subject?
    @State private var showAlert = false
    @State private var showPurchase = false
    @State private var showSettings = false
    
    @State var hasPurchased = false
    
    let pub = NotificationCenter.default.publisher(for: Notification.Name("PurchasedNotification"))
    
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
            LinearGradient(colors: [Color.black, Color("Primary")], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack {
                VStack(alignment:.leading) {
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
                        VStack{
                            HStack{
                                if (!hasPurchased){
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
                                    if ((subjects.count >= 2) && (hasPurchased == false)){
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
                                .sheet(isPresented: $historyIsShown) {
                                    HistoricalView()
                                }
                            }
                            Button {
                                historyIsShown.toggle()
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius:7)
                                        .foregroundColor(constants.primaryColor)
                                    Text("History")
                                        .foregroundColor(constants.accent)
                                }
                                .frame(width:100,height:30)
                            }
                        }

                        
                    }
                    .padding(.top)
                }
                Rectangle()
                    .frame(height: 8)
                    .foregroundColor(.clear)
                LinearGradient(colors: [.clear,constants.accent, .clear], startPoint: .leading, endPoint: .trailing)
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
                                                    
                                                    let newHistory = HistoricAction(context: dataController.container.viewContext)
                                                    newHistory.subjectName = subject.name
                                                    newHistory.attended = true
                                                    newHistory.incremented = false
                                                    newHistory.dateSavedAt = Date.now
                                                    
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
                                                    
                                                    let newHistory = HistoricAction(context: dataController.container.viewContext)
                                                    newHistory.subjectName = subject.name
                                                    newHistory.attended = true
                                                    newHistory.incremented = true
                                                    newHistory.dateSavedAt = Date.now
                                                    
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
                                                    
                                                    let newHistory = HistoricAction(context: dataController.container.viewContext)
                                                    newHistory.subjectName = subject.name
                                                    newHistory.attended = false
                                                    newHistory.incremented = false
                                                    newHistory.dateSavedAt = Date.now
                                                    
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
                                                    
                                                    let newHistory = HistoricAction(context: dataController.container.viewContext)
                                                    newHistory.subjectName = subject.name
                                                    newHistory.attended = false
                                                    newHistory.incremented = true
                                                    newHistory.dateSavedAt = Date.now
                                                    
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

            }
            .padding(.horizontal)
            .onAppear{
                if(storeController.purchasedProducts.isEmpty == false){
                    self.hasPurchased = true
                }
                NotificationController.shared.requestPermission()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                switch(dateFormatter.string(from: Date())){
                case "Monday":
                    currentDayIndex = 0
                    break
                case "Tuesday":
                    currentDayIndex = 1
                    break
                case "Wednesday":
                    currentDayIndex = 2
                    break
                case "Thursday":
                    currentDayIndex = 3
                    break
                case "Friday":
                    currentDayIndex = 4
                    break
                case "Saturday":
                    currentDayIndex = 5
                    break
                default:
                    currentDayIndex = 6
                    break
                }
            }
            .statusBar(hidden: true)
            .onChange(of: storeController.purchasedProducts) { product in
                Task {
                    self.hasPurchased = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name.purchasedNotification)) { (output) in
                if(storeController.purchasedProducts.isEmpty == false){
                    print("Notification Received")
                    self.hasPurchased = true
                }
            }

        }
    }
    
    func deleteSubjectAction() {
            guard let subject = deleteSubject else {
                return
            }
            
            if let lecturesSet = subject.toLectures {
                let lecturesArray = lecturesSet.allObjects as! [Lecture]
                for lecture in lecturesArray {
                    dataController.container.viewContext.delete(lecture)
                }
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
