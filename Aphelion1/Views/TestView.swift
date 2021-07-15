//
//  TestView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/16.
//

import SwiftUI

struct TestView: View {
    let originalText = "PT3M50S"
    
    var body: some View {
        Text(getYTDuration(durationString: originalText))
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}


