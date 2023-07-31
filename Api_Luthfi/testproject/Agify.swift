//
//  Agify.swift
//  testproject
//
//  Created by Muhammad Luthfi Fahrezi on 31/07/23.
//

import Foundation
import SwiftUI

struct Person: Hashable, Codable {
    let count: Int
    let name: String
    let age: Int
}

class AgeViewModel : ObservableObject {
    @Published var person : Person = Person(count: 0, name: "....", age: 0)
    
    @Published var name = ""
    
    func fetchData() {
        guard let url = URL(string: "https://api.agify.io/?name=\(name)") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Person.self, from: data)
                DispatchQueue.main.async {
                    self.person = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct GuessAgeView: View {
    @StateObject var ageViewModel = AgeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 35) {
                VStack {
                    Text("Your Name is \(ageViewModel.person.name),")
                        .frame(width: 250, alignment: .leading)
                    Text("I Guess you are \(ageViewModel.person.age),")
                        .frame(width: 250, alignment: .leading)
                    Text("With the total count \(ageViewModel.person.count).")
                        .frame(width: 250, alignment: .leading)
                    }
                    
                    TextField("Insert the name here", text: $ageViewModel.name)
                        .padding()
                        .background(Color.white)
                        .frame(width: 300, height: 50)
                        .cornerRadius(20)
                    
                    Button(action: {
                        ageViewModel.fetchData()
                    },
                           label: {
                        Text("Guess the age")
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    })
                }
            }
            .navigationTitle("Guess Age")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct GuessAgeApi_Previews: PreviewProvider {
    static var previews: some View {
        GuessAgeView()
    }
}


