//
//  TestView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/19.
//

import SwiftUI

struct TestView: View {
    
    @State var searchedCount = 0

    var body: some View {
        VStack {
            Spacer()
            SearchBarElement(searchedCount: $searchedCount, width: 300, fontSize: 20, offset: 0)
            Spacer()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
