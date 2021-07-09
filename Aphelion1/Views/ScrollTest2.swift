//
//  ScrollTest2.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/9.
//

import SwiftUI

// Data model
struct Item: Identifiable {
    let id = UUID()
    
    var value: Int
    // Other properties...
    var loc: CGRect = .zero
}

struct TestScroll2: View {
    @State private var ruler: CGFloat!
    
    @State private var items = (0..<10).map { Item(value: $0) }
    @State private var centredItem: Item!
    
    var body: some View {
        HStack {
            if let item = centredItem {
                Text("\(item.value)")
            }
            
            HStack(spacing: -6) {
                Rectangle()
                    .frame(height: 1)
                    .measureLoc { loc in
                        ruler = (loc.minY + loc.maxY) / 2
                    }
                
                Image(systemName: "powerplug.fill")
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                            Text("\(item.value)")
                                .padding()
                                .frame(width: 80, height: 80)
                                .background(centredItem != nil &&
                                            centredItem.id == item.id ? Color.yellow : Color.white)
                                .border(Color.blue)
                                .measureLoc { loc in
                                    
                                    items[index].loc = loc
                                    
                                    if let ruler = ruler {
                                        if item.loc.maxY >= ruler && item.loc.minY <= ruler {
                                            withAnimation(.easeOut) {
                                                centredItem = item
                                            }
                                        }
                                        
                                        // Move outsides
                                        if ruler <= items.first!.loc.minY ||
                                            ruler >= items.last!.loc.maxY {
                                            withAnimation(.easeOut) {
                                                centredItem = nil
                                            }
                                        }
                                    }
                                }
                        }
                    }
                    // Extra space above and below
                    .padding(.vertical, ruler)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LocKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

extension View {
    func measureLoc(_ perform: @escaping (CGRect) ->()) -> some View {
        overlay(GeometryReader { geo in
            Color.clear
                .preference(key: LocKey.self, value: geo.frame(in: .global))
        }.onPreferenceChange(LocKey.self, perform: perform))
    }
}

struct ScrollTest2_Previews: PreviewProvider {
    static var previews: some View {
        TestScroll2()
    }
}
