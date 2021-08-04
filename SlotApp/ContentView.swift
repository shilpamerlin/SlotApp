//
//  ContentView.swift
//  SlotApp
//
//  Created by Shilpa Joy on 2021-08-03.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple", "star", "cherry"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var credits = 1000
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
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
                
                VStack {
                    HStack {
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[3]], background: $backgrounds[3])
                        
                        CardView(symbol: $symbols[numbers[4]], background: $backgrounds[4])
                        
                        CardView(symbol: $symbols[numbers[5]], background: $backgrounds[5])
                            
                        
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[6]], background: $backgrounds[6])
                        
                        CardView(symbol: $symbols[numbers[7]], background: $backgrounds[7])
                        
                        CardView(symbol: $symbols[numbers[8]], background: $backgrounds[8])
                            
                        
                        Spacer()
                    }
                }
                Spacer()
                HStack {
                    VStack {
                        Button(action: {
                            processCardResults(isMax: false)
                            
                        }, label: {
                            Text("Spin Middle")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 28)
                                .background(Color.pink)
                                .cornerRadius(20)
                        })
                        Text("\(betAmount) credits")
                            .padding(.top, 10)
                            .font(.footnote)
                    }
                    VStack {
                        Button(action: {
                            
                            processCardResults(isMax: true)
                            
                        }, label: {
                            Text("Spin All")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 38)
                                .background(Color.pink)
                                .cornerRadius(20)
                        })
                        Text("\(betAmount * 5) credits")
                            .padding(.top, 10)
                            .font(.footnote)
                    }
                    
                }
               
                Spacer()
            }
           
        }
    }
    func processCardResults(isMax: Bool = false) {
    
        self.backgrounds = self.backgrounds.map { _ in
            Color.white
        }
        if isMax {
            self.numbers = self.numbers.map { _ in
                Int.random(in: 0...symbols.count - 1)
                }
        } else {
            self.numbers[3] = Int.random(in: 0...symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...symbols.count - 1)
        }
        //check winnings
        processWin(isMax: isMax)
       
    }
    
    func processWin(isMax: Bool = false) {
        
        var matches = 0
        
        if isMax { //true then spin all
            
            //Top row
            if indexIsMatch(0, 1, 2){
            matches += 1
            }
            //middle row
            if indexIsMatch(3, 4, 5) {
            matches += 1
            }
            //bottom row
            if indexIsMatch(6, 7, 8){
            matches += 1
            }
            
            //Diagonal top right to bottom left
            if indexIsMatch(2, 4, 6){
            matches += 1
            }
            //Diagonal top left to bottom right
            if indexIsMatch(0, 4, 8){
            matches += 1
            }
            
        } else { //is Max false spin middle row
            
            //Check winnings for middle row
            if self.numbers[3] == self.numbers[4] &&
                self.numbers[4] == self.numbers[5] {
                    matches += 1
                self.backgrounds[3] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[5] = Color.green
            }
        }
        
        //check matches and distribute credits
        if matches > 0 {
            self.credits += matches * betAmount * 2
        } else if !isMax {
            self.credits -= betAmount
        } else {
            self.credits -= betAmount * 25
        }
    }
    
    func indexIsMatch(_ index1: Int, _ index2: Int, _ index3: Int) -> Bool {
        
        if self.numbers[index1] == self.numbers[index2] &&
            self.numbers[index2] == self.numbers[index3] {
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            return true
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
