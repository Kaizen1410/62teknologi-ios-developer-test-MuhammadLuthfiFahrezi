//
//  ContentView.swift
//  testproject
//
//  Created by Muhammad Luthfi Fahrezi on 29/07/23.
//

import Foundation
import SwiftUI

struct ContentView : View {
    private var data:  [Int] = Array(1...6)
    private let colors: [Color] = [.yellow, .blue, .green]
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body : some View {
        NavigationStack {
            ZStack {
                Color.blue.edgesIgnoringSafeArea(.all)
                    .navigationTitle("Main Menu")

                ScrollView {
                    LazyVGrid(columns: adaptiveColumns, spacing: 25) {

                        NavigationLink(destination: GuessGenderView(), label: {
                            ZStack{
                                Circle()
                                    .foregroundColor(Color.yellow)
                                VStack{
                                    Text("Guess Gender")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })

                        NavigationLink(destination: IpInfoView(), label:{
                            ZStack{
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.green)
                                    .cornerRadius(30)
                                VStack{
                                    Text("IP Info")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })

                        NavigationLink(destination: JokeApiView(), label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.green)
                                    .cornerRadius(30)
                                VStack{
                                    Text("Jokes Collection")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })


                        NavigationLink(destination: CatFactView(), label: {
                            ZStack{
                                Circle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.yellow)
                                    .cornerRadius(30)
                                VStack{
                                    Text("Cat Facts")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })


                        NavigationLink(destination: GuessAgeView(), label: {
                            ZStack{
                                Circle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.yellow)
                                    .cornerRadius(30)
                                VStack{
                                    Text("Guess Age")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })

                        NavigationLink(destination: DogApiView(), label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.green)
                                    .cornerRadius(30)
                                VStack{
                                    Text("Dog Photo Collection")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })
                    }
                }
                .padding()
                .navigationTitle("Main Menu")
                .navigationBarBackButtonHidden()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
