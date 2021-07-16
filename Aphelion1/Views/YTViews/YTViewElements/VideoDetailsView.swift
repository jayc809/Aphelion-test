//
//  VideoDetailsVideo.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/16.
//

import SwiftUI

struct VideoDetailsView: View {
    
    var title: String
    var channel: String
    var duration: String
    var published: String
    var description: String
    var width: CGFloat
    var fontSize: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Track - \(title)")
                .font(Font.system(size: fontSize))
                .padding(.vertical, 10)
            Text("Artist - \(channel)")
                .font(Font.system(size: fontSize))
                .padding(.vertical, 10)
            Text("Duration - \(duration)")
                .font(Font.system(size: fontSize))
                .padding(.vertical, 10)
            Text("Published - \(published)")
                .font(Font.system(size: fontSize))
                .padding(.vertical, 10)
            ScrollView {
                Text("Description - \(description)")
                    .font(Font.system(size: fontSize))
            }
        }
        .frame(width: width)
    }
}

struct VideoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailsView(title: "GHOST / 星街すいせい(official)", channel: "Suisei Channel", duration: "4:42", published: "Apr 13, 2021", description: "「GHOST」作詞：星街すいせい 作曲：佐藤厚仁(Dream Monster) 編曲：佐藤厚仁(Dream Monster) Electric Guitar,Acoustic Guitar：佐藤厚仁(Dream Monster) Electric Bass：森本練 Drums：北村望 映像：mokoppe 歌詞デザイン：紋", width: 300, fontSize: 20)
    }
}
