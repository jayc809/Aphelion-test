//
//  PauseMenu.swift
//  Aphelion
//
//  Created by Jay on 2021/6/30.
//

import SwiftUI

struct PauseMenu: View {
    
    @State var tileTheme = false //false - beat, true - regular
    
    var body: some View {
        ZStack {
            
            Image("PauseMenu")
                .resizable()
            
            VStack {
                
                VStack {
                    
                    HStack {
                        
                        Text("Tile Theme")
                            .font(.custom(Constants.fontNormal, size: 15))
                        
                        Toggle(isOn: $tileTheme, label: {})
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Resume")
                                .font(.custom(Constants.fontNormal, size: 20))
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Leave Game")
                                .font(.custom(Constants.fontNormal, size: 20))
                                //.padding()
                                //.border(Color.white)
                        })
                        
                    }
                    
                }
                .frame(width: Constants.screenWidth * 0.6 - 100)
                .padding()
                
            }
            .onChange(of: tileTheme, perform: { value in
                if value == false {
                    tileType = "Beat"
                }
                else {
                    tileType = "Regular"
                }
            })
            
        }
        .frame(width: Constants.screenWidth * 0.6, height: Constants.screenHeight * 0.4)
        .foregroundColor(.white)
    }
}

struct PauseMenu_Previews: PreviewProvider {
    static var previews: some View {
        return PauseMenu().previewLayout(.fixed(width: Constants.screenWidth, height: Constants.screenHeight))
    }
}
