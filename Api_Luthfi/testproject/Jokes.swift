//
//  Jokes.swift
//  testproject
//
//  Created by Muhammad Luthfi Fahrezi on 31/07/23.
//

import SwiftUI

struct Jokes: Hashable, Codable {
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}

class JokeViewModel : ObservableObject {
    @Published var jokes: Jokes = Jokes(type: "general", setup: "Please welcome to jokes collection", punchline: "", id: 115)
    
    func fetchData() {
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Jokes.self, from: data)
                DispatchQueue.main.async {
                    self.jokes = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct JokeApiView: View {
    @StateObject var jokeViewModel = JokeViewModel()
    
    @Environment(\.presentationMode) var presentationModes
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all)
            
                    VStack(spacing: 100) {
                    Text("Jokes Type : General \n \n \(jokeViewModel.jokes.setup) \n \n \n \(jokeViewModel.jokes.punchline)")
                    
                    Button(action: {
                        jokeViewModel.fetchData()
                    },
                           label: {
                        Text("Generate Jokes")
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    })
                }
            }
            .navigationTitle("Jokes Collection")
            .navigationBarTitleDisplayMode(.inline)
        }
    
    }
}

struct JokeApiView_Previews: PreviewProvider {
    static var previews: some View {
        JokeApiView()
    }
}


