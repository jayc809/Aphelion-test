//
//  Notes.swift
//  Aphelion
//
//  Created by Jay on 2021/6/21.
//

//---------------------------------------------------------------------------------------------------------------------------------------

//Clip
//Group {
//    Image(systemName: "circle.fill")
//        .position(x: test.x, y: test.y - clipOffset)
//}
//.frame(width: 300, height: 300)
//.border(Color.blue)
//.clipped()
//.position(x: Constants.halfScreenWidth, y: Constants.halfScreenHeight + clipOffset)
//.onAppear{
//    withAnimation(.linear(duration: 3)){
//        test.x = 500
//    }
//}

//Tap
//.gesture(tap)
//
//var tap: some Gesture {
//    DragGesture(minimumDistance: 0, coordinateSpace: .global).onEnded { _ in
//        code
//    }
//}


//Offset line
//var offsetX: CGFloat {
//    // b = a * tan(angle)
//    let a = lineHeight / 2
//    return a * CGFloat(tan(angle.radians))
//}
//var offsetY: CGFloat {
//    return -lineHeight / 2
//}

//Dark mode
//<key>UIUserInterfaceStyle</key>
//<string>Dark</string>

//VGrid settings layout
//struct GameSettingsViewGrid: View {
//
//    var width: CGFloat
//    var fontSize: CGFloat
//
//    var body: some View {
//
//        let gridLayout = [GridItem(.fixed(width * 0.4)), GridItem(.fixed(width * 0.6))]
//        let maxFrame = width * 0.4
//        let gridSpacing = fontSize * 0.8
//        let leadingPadding = fontSize * 0.45
//
//        ScrollView(showsIndicators: false) {
//
//            Text("Gameplay")
//                .font(Font.system(size: fontSize * 1.25))
//                .padding(.top, 10)
//            LazyVGrid(columns: gridLayout, alignment: .leading, spacing: gridSpacing) {
//
//                Text("Difficulty")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    DifficultyButton(fontSize: fontSize)
//                        .frame(width: maxFrame)
//                }
//
//                Text("Note Speed")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    TileSpeedStepper(width: fontSize * 5, height: fontSize + 2, spacing: fontSize * 0.6)
//                        .padding(.vertical, -1)
//                        .frame(width: maxFrame)
//                }
//
//                Text("Slide Notes")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    SlideNoteButton(fontSize: fontSize)
//                        .frame(width: maxFrame)
//                }
//
//                Text("Divine Boost")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    DivineBoostButton(fontSize: fontSize)
//                        .frame(width: maxFrame)
//                }
//            }
//
//            Text("Visuals")
//                .font(Font.system(size: fontSize * 1.25))
//                .padding(.top, 20)
//            LazyVGrid(columns: gridLayout, alignment: .leading, spacing: gridSpacing) {
//
//                Text("Note Theme")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    TileThemeButton(height: fontSize + 5)
//                        .padding(.vertical, -2.5)
//                        .frame(width: maxFrame)
//                        .offset(y: 1.5)
//                }
//
//                Text("Animation Quality")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    AnimationQualityButton(fontSize: fontSize)
//                        .frame(width: maxFrame)
//                }
//
//                Text("Animation Offset")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    AnimationOffsetStepper(width: fontSize * 5, height: fontSize + 2, spacing: fontSize * 0.15)
//                        .frame(width: maxFrame)
//                }
//
//                Text("Background")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    GameBackgroundButton(fontSize: fontSize)
//                        .frame(width: maxFrame)
//                }
//
//                Text("Brightness & Saturation")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    BrightnessAndSaturationButton(arrowWidth: width * 0.05)
//                        .frame(width: maxFrame)
//                }
//            }
//
//            Text("Sounds")
//                .font(Font.system(size: fontSize * 1.25))
//                .padding(.top, 20)
//            LazyVGrid(columns: gridLayout, alignment: .leading, spacing: gridSpacing) {
//
//                Text("Sound Effects")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    SoundEffectsButton(fontSize: fontSize)
//                        .frame(width: maxFrame)
//                }
//
//                Text("Audio Offset")
//                    .font(Font.system(size: fontSize))
//                    .padding(.leading, leadingPadding)
//                HStack {
//                    Spacer()
//                    AudioOffsetStepper(width: fontSize * 5, height: fontSize + 2, spacing: fontSize * 0.15)
//                        .frame(width: maxFrame)
//                }
//            }
//
//        }
//        .frame(width: width)
//    }
//}
//
//
