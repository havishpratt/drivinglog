//
//  SessionRow.swift
//  DrivingLog
//
//  Created by VAMSI PRATTIPATI on 5/31/23.
//

import SwiftUI
import CoreLocation

struct SessionRow: View {
    
    var session: Session
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            Text("Date: \(session.startTime.prefix(8).description)")
            
            Text("Start Time: \(session.startTime.suffix(from: session.startTime.index(session.startTime.startIndex, offsetBy: 8)).description)")
            
            Text("End Time: \(session.endTime.suffix(from: session.endTime.index(session.endTime.startIndex, offsetBy: 8)).description)")
            
            if session.elapsedTime < 60{
                Text("Elapsed Time: \(Int(round(session.elapsedTime))) seconds")
            } else {
                Text("Elapsed Time: \(Int(round(session.elapsedTime/60))) minutes")
            }
            
        }
        .font(.title3)
    }
}

struct SessionRow_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        
        let allSessions = Bundle.main.decode()
        
        SessionRow(session: allSessions[0])
        
    }
    
    
}

