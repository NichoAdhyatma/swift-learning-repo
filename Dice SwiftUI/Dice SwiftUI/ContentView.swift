//
//  ContentView.swift
//  Dice SwiftUI
//
//  Created by nicho@mac on 31/01/25.
//

import SwiftUI

struct ContentView: View {
    @State var leftDice: Int = 1
    @State var rightDice: Int = 1
    var body: some View {
        ZStack {
            Image("background").resizable().ignoresSafeArea(.all)
          
            VStack() {
                Image("diceeLogo")
                
                Spacer()
                
                HStack(spacing: 10) {
                    DiceView(side: leftDice)
                    DiceView(side: rightDice)
                }.padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    print("Roll")
                    leftDice = Int.random(in: 1...6)
                    rightDice = Int.random(in: 1...6)
                }, label: {
                    Text("Roll")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                        .padding(.vertical, 10)
                        .background(Color.red)
                        .cornerRadius(10)
                })
                
            }
        }
    }
}

#Preview {
    ContentView()
}

struct DiceView: View {
    let side: Int
    
    var body: some View {
        Image("dice\(side)").resizable().aspectRatio(1,contentMode: .fit).padding(.all)
    }
}
