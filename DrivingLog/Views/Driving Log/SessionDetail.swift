//
//  SessionDetail.swift
//  DrivingLog
//
//  Created by VAMSI PRATTIPATI on 6/4/23.
//

import SwiftUI
import MapKit

struct SessionDetail: View {
let session: Session
    var body: some View {
        VStack {
            
            MapView(session: session)
            
            VStack (alignment: .leading) {
                
                Text("Date: \(session.startTime.prefix(8).description)")
                
                Text("Start Time: \(session.startTime.suffix(from: session.startTime.index(session.startTime.startIndex, offsetBy: 8)).description)")
                
                Text("End Time: \(session.endTime.suffix(from: session.endTime.index(session.endTime.startIndex, offsetBy: 8)).description)")
                
                if session.elapsedTime < 60{
                    Text("Elapsed Time: \(Int(round(session.elapsedTime))) seconds")
                } else {
                    Text("Elapsed Time: \(Int(round(session.elapsedTime/60))) minutes")
                }
                
            }.font(.title)
            
            
        }
        
    }
}

struct SessionDetail_Previews: PreviewProvider {
    static var previews: some View {
        let allSessions = Bundle.main.decode()
        SessionDetail(session: allSessions[0])
    }
}
