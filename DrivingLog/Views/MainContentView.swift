//
//  ContentView.swift
//  DrivingLog
//
//  Created by HAVISH PRATTIPATI on 5/21/23.
//

import SwiftUI


struct MainContentView: View {
    @EnvironmentObject var session: SessionClass
    var body: some View {
        NavigationView{
            VStack {

                //master view
                Spacer()
                    .navigationTitle("MileStat")

                //driving session view
                NavigationLink(destination: SessionView().navigationTitle("Driving Session")){
                    Text(session.elapsedTime != 0 ? "Continue Session" : "Start Session")
                        .font(.title)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        

                }
                    .padding()


                //Driving log view
                NavigationLink(destination: DrivingLogView().navigationTitle("Driving Sessions")) {
                    Text("Driving Log")
                        .font(.title)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                }.padding()
                Spacer()
            }

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var session = SessionClass()
        MainContentView().environmentObject(session)
    }
}
