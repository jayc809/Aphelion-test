//
//  TestScroll.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/9.
//

import SwiftUI

struct ScrollTest: View {
    
    var array = 0...50
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 20) {
                    ForEach(array, id:\.self) { i in
                        ZStack {
                            Image("PauseMenu")
                                .resizable()
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("item \(i)")
                                    .font(Font.system(size: 15))
                                    .lineLimit(1)
                            }
                            .frame(width: Constants.screenWidth * 0.4 - 40, alignment: .leading)
                        
                        }
                        .foregroundColor(.white)
                        .frame(width: Constants.screenWidth * 0.4, height: 70)
                        .rotationEffect(Angle(degrees: -10))
                    }
                }
            }
        }
        .rotationEffect(Angle(degrees: 10))
    }
}

struct TestScroll_Previews: PreviewProvider {
    static var previews: some View {
        ScrollTest()
    }
}
