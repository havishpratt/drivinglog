//
//  DrivingLogView.swift
//  DrivingLog
//
//  Created by VAMSI PRATTIPATI on 5/21/23.
//

import SwiftUI


struct DrivingLogView: View {
    
    @EnvironmentObject var session: SessionClass
    @State var filter: Bool = false
    
    var body: some View {
        var newSession: [Session] = []
        
        if session.allSessions.count == 0 {
            Text("No Sessions Available")
                .font(.title)
                .bold()
        } else {
            
            Toggle(isOn: $filter) {
                Text("Show Night Sessions Only?")
            }.padding(.horizontal)
                .onChange(of: filter, perform: { value in
                    if value {
                        newSession = []
                        
                        session.allSessions.forEach { session in
                            if session.nightTime {
                                newSession.append(session)
                                print("appended to night")
                            }
                        }
                    } else {
                        newSession = []
                        session.allSessions.forEach { session in
                            if session.nightTime == false {
                                newSession.append(session)
                                print("appended to day")
                            }
                        }
                    }
                })
            List {
                ForEach(session.allSessions, id: \.self) { session in
                    NavigationLink {
                        SessionDetail(session: session)
                    } label: {
                        SessionRow(session: session)
                    }
                    
                }
                .onDelete { offsets in
                    for index in offsets {
                        if index < session.allSessions.count {
                            
                            let deletedItem = session.allSessions[index]
                            removeItemFromJSON(id: deletedItem.id)
                            
                            print("Deleted item: \(deletedItem)")
                        }
                    }
                    //self.session.allSessions = Bundle.main.decode()
                }
            }
            .onAppear {
                session.allSessions = Bundle.main.decode()
            }
        }
    }
}
struct DrivingLogView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingLogView().environmentObject(SessionClass())
    }
}
