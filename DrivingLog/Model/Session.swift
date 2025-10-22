//
//  Session.swift
//  DrivingLog
//
//  Created by HAVISH PRATTIPATI on 5/30/23.
//

import Foundation
import CoreLocation

struct SampleSession {
    let data: [Session] = []
     
}

struct Session: Codable, Hashable {
    
    var id: UUID
    var startTime: String
    var endTime: String
    var nightTime: Bool
    var elapsedTime: Double
    var locations: [Coordinates]
    
    
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
        
        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    var coordinates: [CLLocationCoordinate2D] {
        locations.map { $0.coordinate }
    }
    
    
    init(startTime: String, endTime: String, nightTime: Bool, elapsedTime: Double, coordinates: [CLLocationCoordinate2D]) {
        self.id = UUID()
        self.startTime = startTime
        self.endTime = endTime
        self.nightTime = nightTime
        self.elapsedTime = elapsedTime
        self.locations = coordinates.map { coord in
            Coordinates(
                latitude: coord.latitude,
                longitude: coord.longitude
            )
        }
    }
}

func getURL() -> URL? {
    guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("sessionData.json") else {
        print("cannot find url")
        return nil
    }
    return fileURL
}


func appendSessionToJSON(appendSession: Session){
    
    guard let fileURL = getURL() else {
        print("cannot find url")
        return
    }

    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    var existingData: [Session] = Bundle.main.decode()
    
    
    
    existingData.append(appendSession)
    
    do {
        let updatedData = try encoder.encode(existingData)
        try updatedData.write(to: fileURL, options: .atomic)
        print("sucessfully appended to file at \(fileURL)")
    } catch {
        print("encoding or writing went wrong: \(error)")
    }
}



extension Bundle {
    func decode() -> [Session] {
        
        guard let fileURL = getURL() else {
            print("cannot find url")
            return []
        }

        
        guard let data = try? Data(contentsOf: fileURL) else {
            print("Could not load \(fileURL) from bundle.")
            return []
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode([Session].self, from: data) else {
            print(data)
            print("Could not decode \(fileURL) from bundle.")
            return []
        }
        
        return loadedData
    }
}

func removeItemFromJSON(id: UUID) {
    
    guard let fileURL = getURL() else {
        print("cannot find url")
        return
    }
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    var existingData: [Session] = Bundle.main.decode()
    
    existingData = existingData.filter { $0.id != id }
    
    do {
        let updatedData = try encoder.encode(existingData)
        try updatedData.write(to: fileURL, options: .atomic)
        print("sucessfully appended to file at \(fileURL)")
    } catch {
        print("encoding or writing went wrong: \(error)")
    }
    
}
