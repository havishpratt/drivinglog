import SwiftUI
import MapKit

struct MapView: View {
    var session: Session
    
    
    var body: some View {
        
        let startPoint = CLLocationCoordinate2D(
            latitude: session.locations[0].latitude,
            longitude: session.locations[0].longitude)
        
        let endPoint = CLLocationCoordinate2D(
            latitude: session.locations[session.locations.endIndex-1].latitude,
            longitude: session.locations[session.locations.endIndex-1].longitude)
        
        Map() {
            Marker("Start Point", systemImage: "location.circle.fill" ,coordinate: startPoint)
                .tint(.red)
            
            Marker("End Point", coordinate: endPoint)
                .tint(.blue)
        }
        
        
    }
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let allSessions = Bundle.main.decode()
        let session = allSessions[0]
        return MapView(session: session)
    }
}

