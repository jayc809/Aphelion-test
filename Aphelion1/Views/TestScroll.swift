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


struct PickerTest: View {
    
    @State var selected = 0
    var array = 0...10
    
    var body: some View {
        Picker("Picker", selection: $selected) {
            ForEach(array, id: \.self) { i in
                Text(String(i))
                    .tag(i)
                    .scaleEffect(selected == i ? 1.5 : 1)
            }
        }
    }
}

struct ScrollTest1: View {
    //This will hold your selected item
    @State var selected: Int? = nil
    var body: some View {
        HStack{
            VStack{
                Text("current item:")
                if selected != nil{
                    Text("Item \(selected!)")
                }else{
                    Text("none")
                }
            }
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(0..<20) { i in
                            VStack{
                                Text("item \(i)")
                                    .onTapGesture {
                                        selected = i
                                        //If you set the anchor to .center it will center the list if it can. The top half does not move.
                                        proxy.scrollTo(i, anchor: .center)
                                    }
                                    //The id tell the proxy where to go
                                    .id(i)
                                    .padding()
                            }
                            .border(Color.white)
                            //Since your example has the selected item with a red background I made a conditional here
                            .background(selected == i ? Color.red :  Color.clear)
                            .scaleEffect(selected == i ? 1.5 : 1)
                        }
                    }
                }.onAppear(){
                    if selected != nil{
                        proxy.scrollTo(selected!, anchor: .center)
                    }
                }
            }
            
        }
        
    }
}

struct TestScroll_Previews: PreviewProvider {
    static var previews: some View {
        ScrollTest()
    }
}
