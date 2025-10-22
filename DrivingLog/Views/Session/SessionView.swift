//
//  SessionView.swift
//  DrivingLog
//
//  Created by HAVISH PRATTIPATI on 5/21/23.
//
import SwiftUI


struct SessionView: View {
    
    @EnvironmentObject var session: SessionClass
    private let manager = LocationManager.shared.manager
    
    

    private var formattedElapsedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: session.elapsedTime) ?? "00:00:00"
    }
    
    

    var body: some View {
        VStack {
            
            Toggle(isOn: $session.isNight) {
                Text("Night Driving?")
            }.padding(.horizontal)
            

            Text("\(formattedElapsedTime)")
                .font(.largeTitle)
                .padding()

            HStack {
                Button(action: {
                    if session.isRunning {
                        session.stopTimer()
                    } else {
                        session.startTimer()
                        
                    }
                }) {
                    Text(session.isRunning ? "Pause" : "Start")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            
            }
            
            Text("Start Time: " + session.formatDate(date: session.start ?? Date())).padding(.vertical)
            Text("End Time: " + session.formatDate(date: session.end ?? Date())).padding(.vertical)
            
            LocationView()
            
            Spacer(minLength: 0)
                .padding(.bottom,20)
            
            HStack{
                Spacer()
                
                Button(action: {
                    session.resetTimer()
                }) {
                    Text("End Session")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .foregroundColor(.white)
                        
                        
                }
                .opacity(session.elapsedTime != 0 ? 100 : 0)
                .cornerRadius(10)
                
                Spacer()
            }
            
        }
        .onReceive(session.timer) { _ in
            if session.isRunning {
                
                session.updateElapsedTime()
            }
        }
    }

    
    
    
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        
        SessionView()
            .environmentObject(SessionClass())
    }
}


