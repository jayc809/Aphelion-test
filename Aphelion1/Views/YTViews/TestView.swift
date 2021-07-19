//
//  TestView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/19.
//

import SwiftUI

struct TestView: View {
    
    var body: some View {
        
        let gridLayout = [GridItem(.flexible())]
        
        ScrollView(showsIndicators: false) {
            
            LazyVGrid(columns: gridLayout, alignment: .leading) {
                
                
                
            }
        }
    }
}
struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
