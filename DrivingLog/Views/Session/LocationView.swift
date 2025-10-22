import SwiftUI
import CoreLocation


struct LocationView: View {
    
    @EnvironmentObject var session: SessionClass
    let manager = LocationManager.shared.manager
    
    //hard code the intial value to 0, since we want to get around the intial location update that happens when the timer is started
    static var prevLocationCount = 0
    
    var timeIntervalForAutoStop: Int = 300
    
    var body: some View {
        
        VStack {
            if let location = LocationManager.location {
                Text("Latitude: \(location.coordinate.latitude)")
                
                Text("Longitude: \(location.coordinate.longitude)")
            } else {
                Text("Location not available")
            }
        }
        .onAppear {
            LocationManager.shared.getUserLocation { location in
                DispatchQueue.main.async {
                    LocationManager.location = location
                }
            }
        }
        .onReceive(session.timer) { _ in
            print("timer fired")
            if ((manager.authorizationStatus.rawValue == 4) && (session.elapsedTime != 0) && ((Int(session.elapsedTime) % timeIntervalForAutoStop) == 0 )){
                
                print("previous: \(LocationView.prevLocationCount)")
                print("current: \(SessionClass.locationCoordinates.count)")

                if LocationView.prevLocationCount == SessionClass.locationCoordinates.count {
                    
                    session.resetTimer()
                }
                
                //update the previous count to the current count, so we now check whether the location updates based on the previous number of location updates
                LocationView.prevLocationCount = SessionClass.locationCoordinates.count
                
            }
            
        }
    }
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView().environmentObject(SessionClass())
    }
}

