//
//  Dogs.swift
//  testproject
//
//  Created by Muhammad Luthfi Fahrezi on 31/07/23.
//

import Foundation
import SwiftUI

struct Dog: Hashable, Codable {
    let message: String
    let status: String
}

class DogViewModel : ObservableObject {
    @Published var dogs : Dog = Dog(message: "https://images.dog.ceo/breeds/ridgeback-rhodesian/n02087394_760.jpg", status: "success")

    func fetchData() {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(Dog.self, from: data)
                DispatchQueue.main.async {
                    self.dogs = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct DogApiView: View {
    @StateObject var dogViewModel = DogViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 100) {
                    AsyncImage(url: URL(string: dogViewModel.dogs.message)) {image in

                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.blue)
                    }
                    .frame(width: 500, height: 250)


                    Button(action: {
                        dogViewModel.fetchData()
                    },
                           label: {
                        Text("Next Picture")
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    })
                }
            }
            .navigationTitle("Dog Photo Collection")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

struct DogApiView_Previews: PreviewProvider {
    static var previews: some View {
        DogApiView()
    }
}
