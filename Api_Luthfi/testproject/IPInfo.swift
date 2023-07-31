//
//  IPInfo.swift
//  testproject
//
//  Created by Muhammad Luthfi Fahrezi on 31/07/23.
//

import Foundation
import SwiftUI

struct LocationInfo : Hashable, Codable {
    let ip: String
    let city: String
    let region: String
    let country: String
    let loc: String
    let org: String
    let postal: String
    let timezone: String
    let readme: String
}

class LocationInfoViewModel : ObservableObject {
    @Published var location : LocationInfo = LocationInfo(ip: "", city: "", region: "", country: "", loc: "", org: "", postal: "", timezone: "", readme: "")
    
    @Published var ip = ""
    
    func fetchData() {
        guard let url = URL(string: "https://ipinfo.io/\(ip)/geo") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(LocationInfo.self, from: data)
                DispatchQueue.main.async {
                    self.location = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct IpInfoView: View {
    @StateObject var locationViewModel = LocationInfoViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 35) {
                    VStack {
                        Text("City : \(locationViewModel.location.city)")
                            .frame(width: 250, alignment: .leading)
                        Text("Region : \(locationViewModel.location.region)")
                            .frame(width: 250, alignment: .leading)
                        Text("Country : \(locationViewModel.location.country)")
                            .frame(width: 250, alignment: .leading)
                        Text("Location : \(locationViewModel.location.loc)")
                            .frame(width: 250, alignment: .leading)
                    }
                        
                    VStack {
                        TextField("Insert the ip here", text: $locationViewModel.ip)
                            .padding()
                            .background(Color.white)
                            .frame(width: 300, height: 50)
                            .cornerRadius(20)
                        
                        Text("e.g 161.185.160.93")
                            .frame(width: 300, alignment: .leading)
                            .font(.system(size: 15))
                    }
                    
                        Button(action: {
                            locationViewModel.fetchData()
                        },
                               label: {
                            Text("Show Location Info")
                                .bold()
                                .frame(width: 300, height: 50)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        })
                    
                }
            }
            .navigationTitle("IP Info")
            .navigationBarTitleDisplayMode(.inline)
            }
        }
        
}

struct IpInfoView_Previews: PreviewProvider {
    static var previews: some View {
        IpInfoView()
    }
}

