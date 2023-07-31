//
//  Genderize.swift
//  testproject
//
//  Created by Muhammad Luthfi Fahrezi on 31/07/23.
//

import Foundation
import SwiftUI

struct Persons: Hashable, Codable {
    let count: Int
    let name: String
    let gender: String?
    let probability: Double?
}

class GenderViewModel : ObservableObject {
    @Published var persons : Persons = Persons(count: 0, name: "", gender: "", probability: nil)
    
    @Published var name = ""
    
    func fetchData() {
        guard let url = URL(string: "https://api.genderize.io/?name=\(name)") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Persons.self, from: data)
                DispatchQueue.main.async {
                    self.persons = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct GuessGenderView: View {
    @StateObject var genderViewModel = GenderViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 75) {
                    Text("Your Gender Is")
                        .bold()
                        .padding()
                    
                    VStack(spacing: 35) {
                        
                        if let gender = genderViewModel.persons.gender {
                            Text("\(gender)")
                                .font(.system(size: 50))
                                .bold()
                                .padding()
                        } else {
                            Text("Unknown name")
                                .font(.system(size: 30))
                                .bold()
                                .padding()
                        }
                        
                        if let prob = genderViewModel.persons.probability {
                            Text("Probability : \(prob)")
                                .bold()
                                .padding()
                        } else {
                            Text("Probability : ")
                                .bold()
                                .padding()
                        }
                        
                    }
                    
                    
                    TextField("Insert the name here", text: $genderViewModel.name)
                        .padding()
                        .background(Color.white)
                        .frame(width: 300, height: 50)
                        .cornerRadius(20)
                    
                    Button(action: {
                        genderViewModel.fetchData()
                    },
                           label: {
                        Text("Show your gender")
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    })
                }
            }
            .navigationTitle("Guess Gender")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct GuessGender_Previews: PreviewProvider {
    static var previews: some View {
        GuessGenderView()
    }
}


