//
//  ContentView.swift
//  SlotApp
//
//  Created by Shilpa Joy on 2021-08-03.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple", "star", "cherry"]
    @State private var numbers = [0, 2, 0]
    @State private var credits = 1000
    @State private var backgrounds = [Color.white, Color.white, Color.white]
    private var betAmount = 5
    var body: some View {
        
        ZStack {
            
        //Background
            
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                //title
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("SwiftUI Slots")
                        .bold()
                        .foregroundColor(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }.scaleEffect(2)
                
                Spacer()
                //credit counter
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all,10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                Spacer()
                //Cards
                HStack {
                    Spacer()
                    
                    CardView(symbol: $symbols[numbers[0]], background: $backgrounds[0])
                    
                    CardView(symbol: $symbols[numbers[1]], background: $backgrounds[1])
                    
                    CardView(symbol: $symbols[numbers[2]], background: $backgrounds[2])
                        
                    
                    Spacer()
                }
                Spacer()
                //Button
                Button(action: {
                    
                    /*self.backgrounds[0] = Color.white
                    self.backgrounds[0] = Color.white
                    self.backgrounds[0] = Color.white*/
            //MARK:- Mapping array elements
                    self.backgrounds = self.backgrounds.map { _ in
                        Color.white
                    }
                    //Change the images
                    
                    self.numbers = self.numbers.map { _ in
                        Int.random(in: 0...symbols.count - 1)
                    }
                   /* self.numbers[0] = Int.random(in: 0...symbols.count - 1)*/
                    
                    
                    
                    //Check winnings
                    if self.numbers[0] == self.numbers[1] &&
                        self.numbers[1] == self.numbers[2] {
                            
                        //won
                        self.credits += self.betAmount * 10
                        /*self.backgrounds[0] = Color.green
                        self.backgrounds[1] = Color.green
                        self.backgrounds[2] = Color.green*/
                        self.backgrounds = self.backgrounds.map({ _ in
                            Color.green
                        })
                    } else {
                        self.credits -= self.betAmount
                    }
                    
                }, label: {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .padding([.leading, .trailing], 30)
                        .background(Color.pink)
                        .cornerRadius(20)
                })
                Spacer()
            }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
