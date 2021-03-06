//
//  PopoverView.swift
//  CustomToolbarPopovers
//
//  Created by nakamura motoki on 2022/02/21.
//

import SwiftUI

// Creating Extention for popover...
extension View{
    func toolBarPopover<Content: View>(show: Binding<Bool>, placement: Placement = .leading, @ViewBuilder content: @escaping() -> Content) -> some View{
        
        // selfは自分自身のViewのこと = Popoverのことを指す
        // selfにモディファイアをかける事でPopoverのレイアウトを変更することが出来る。
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack{
                    if show.wrappedValue{
                        content()
                            .padding()
                        // Popoverの背景色
                            .background(
                                Color.white
                                // Popoverの形は独自のカスタムシェイプの作成をしているPopOverArrowShapeを指定する
                                    .clipShape(PopOverArrowShape(placment: placement))
                            )// .background
                        // Shadows...
                        // Popoverの周りに影をつける
                            .shadow(color: Color.primary.opacity(0.05), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.primary.opacity(0.05), radius: 5, x: -5, y: -5)
                        // ポップアップの左右に余白を空ける
                            .padding(.horizontal, 35)
                        // Moving from top...
                        // Approx Top Nav Bar Height...
                        // Popoverの位置を指定
                            .offset(y: 55)
                            .offset(x: placement == .leading ? -20 : 20)
                    }
                }// ZStack
                //HomeViewで.toolBarPopoverを呼び出す時に
                // .toolBarPopover(show: $show, placement:)で指定したのが.leadingなら.topLeadingに
                // .trailingなら.topTrailingにPopoverを表示する
                , alignment: placement == .leading ? .topLeading : .topTrailing
            )// .overlay
    }
}// extention View

// Placement...

enum Placement{
    case leading
    case trailing
}

// Custom Arrow Shape...
// Popoverの形を作るShape型の構造体
// カスタムシェイプを作成する
// カスタムシェイプは、Shapeプロトコルを実装した構造体を作成し、pathというメソッドを実装します。
struct PopOverArrowShape: Shape{
    // Popoverの一を管理する変数
    var placment: Placement
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            
            let pt1 = CGPoint(x: 0, y: 0)
            let pt2 = CGPoint(x: rect.width, y: 0)
            let pt3 = CGPoint(x: rect.width, y: rect.height)
            let pt4 = CGPoint(x: 0, y: rect.height)
            
            // Drawing Arcs with radius...
            path.move(to: pt4)
            
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 15)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 15)
            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 15)
            path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 15)
            
            // Arrow...
            path.move(to: pt1)
            // Popoverを吹き出しのようにする。
            path.addLine(to: CGPoint(x: placment == .leading ? 10 : rect.width - 10, y: 0))
            path.addLine(to: CGPoint(x: placment == .leading ? 15 : rect.width - 15,  y: 0))
            path.addLine(to: CGPoint(x: placment == .leading ? 25 : rect.width - 25,  y: -15))
            path.addLine(to: CGPoint(x: placment == .leading ? 40 : rect.width - 40,  y: 0))
        }
    }
}

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
