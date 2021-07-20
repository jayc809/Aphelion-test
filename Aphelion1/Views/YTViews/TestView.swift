//
//  TestView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/19.
//

import SwiftUI

struct TestView: View {
    
    @State var searchedCount = 0
    let infoVStackX = Constants.screenWidth * 0.29

    var body: some View {
        GeometryReader { geometry in
            YTView()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
