//
//  ContentView.swift
//  TicTacToe
//
//  Created by P.M. Student on 1/26/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("Tic Tac Toe")
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
struct Home : View {
    
    //Number of moves
    
    @State var moves: [String] = Array(repeating: "", count: 9)
    
    //Identifies current player
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    
    var body: some View {
        VStack {
            
            LazyVGrid(columns: Array (repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                
                ForEach(0..<9, id: \.self) { index in
                    
                    ZStack {
                        Color.purple
                        
                        Color.red
                            .opacity(moves[index] == "" ? 1 : 0)
                        Text (moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.red)
                    }
                    
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(30)
                    .rotation3DEffect(
                        .init(degrees: moves [index] != "" ? 1802 : 0),
                        axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/,
                        anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                        anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                        perspective: 1.0
                    )
                    
                    .onTapGesture(perform : {
                        withAnimation(Animation.easeIn(duration: 0.5)) {
                            
                            if moves[index] == "" {
                                
                                moves[index] = isPlaying ? "X" : "O"
                                isPlaying.toggle()
                            }
                        }
                    })
                    
                }
                
            }
            .padding()
            
            
        }
        .onChange(of: moves, perform: { value in
            checkWinner()
        })
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text("Winner"), message: Text(msg), dismissButton: .destructive(Text( "Play Again"), action: {
                
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
                
            }))
        })
    }
    
    //Used to calculate width.
    
    func getWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width - (30 + 30)
        
        return width / 3
    }
    
    func checkWinner() {
        
        if checkMoves(player: "X") {
            msg = "Player X Won"
            gameOver.toggle()
        }
        
         else if checkMoves(player: "O") {
            msg = "Player X Won"
            gameOver.toggle()
        } else {
            let status = moves.contains {(value)-> Bool in
                return value == ""
                
            }
            if !status {
                msg = "Game Over Tied"
                gameOver.toggle()
            }
            
        }
    }
    
    func checkMoves(player: String) -> Bool {
        for contestants in stride(from: 0, to: 9, by: 3){
            if moves[contestants] == player &&
                moves[contestants+1] == player &&
                moves[contestants+2] == player {
                
                return true
                
            }
        }
        
        //func checkMoves(player: String) -> Bool {
        
        for contestants in 0...2 {
            
            if moves[contestants] == player &&
                moves[contestants+3] == player &&
                moves[contestants+6] == player {
                
                return true
                
            }
        }
        if moves[0] == player && moves[4] == player && moves[8] == player {
            
            return true
            
        }
        if moves[2] == player && moves[4] == player && moves[6] == player {
            
            return true
            
        }
        
        return false
        
        
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

