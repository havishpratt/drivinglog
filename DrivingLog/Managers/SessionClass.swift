import SwiftUI
import CoreLocation

class SessionClass: ObservableObject {
    
    private let manager = LocationManager.shared.manager
    @Published public var start: Date?
    @Published public var end: Date?
    @Published public var isNight: Bool = false
    @Published public var elapsedTime: TimeInterval = 0.0
    
    @Published public var startTime: Date?
    @Published public var isRunning = false
    
    @Published public var allSessions = Bundle.main.decode()

    public static var locationCoordinates: [CLLocationCoordinate2D] = []

    @Published public var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func startTimer() {
        //if manager is authorized, start updating location
        if (manager.authorizationStatus.rawValue == 4) {
            manager.startUpdatingLocation()
        }
        if elapsedTime==0{
            isRunning = true
            startTime = Date()
            
            self.start = Date()
    
        } else{
            isRunning = true
            startTime = Date() - elapsedTime
        }
        
    }

    func stopTimer() {

        isRunning = false
        
    }

    func resetTimer() {
        if startTime != nil {
            let currentTime = Date()
            self.startTime = currentTime
            self.end = Date()
        }
        
        
        if start != nil && end != nil {
            
            let sessionSave = Session(
                startTime: formatDate(date: self.start!),
                endTime: formatDate(date: self.end!),
                nightTime: self.isNight,
                elapsedTime: self.elapsedTime,
                coordinates: SessionClass.locationCoordinates
            )
            
            appendSessionToJSON(appendSession: sessionSave)
        }
        
        isRunning = false
        startTime = nil
        elapsedTime = 0.0
        SessionClass.locationCoordinates = []
        LocationView.prevLocationCount = SessionClass.locationCoordinates.count
        
        //if the manager is updating its location, stop
        if (manager.authorizationStatus.rawValue == 4) {
            manager.stopUpdatingLocation()
        }
        
        allSessions = Bundle.main.decode()
        print(allSessions)

    }

    func updateElapsedTime() {
        if let startTime = startTime {
            elapsedTime = Date().timeIntervalSince(startTime)
        }
    }
    
    public func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy h:mm a"
        return formatter.string(from: date)
    }
}
