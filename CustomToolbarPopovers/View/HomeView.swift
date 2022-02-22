//
//  HomeView.swift
//  CustomToolbarPopovers
//
//  Created by nakamura motoki on 2022/02/21.
//

import SwiftUI

struct HomeView: View {
    
    // Upadatin Popover Views...
    @State private var graphicalDate: Bool = false
    // Pickerの表示有無を管理する状態変数
    @State private var showPicker: Bool = false
    // Popoverの表示有無を管理する状態変数
    @State private var show: Bool = false
    
    var body: some View {
        NavigationView{
            // 二つのToggleを並べる
            List{
                Toggle(isOn: $showPicker){
                    Text("Show Picker")
                }
                
                Toggle(isOn: $graphicalDate){
                    Text("Show Graphical Date Picker")
                }
            }// List
            .navigationTitle("Popovers")
            // ToolBar...
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        withAnimation{
                            // Popoverの表示非表示を切り替える
                            show.toggle()
                        }
                    }label: {
                        Image(systemName: "slider.horizontal.below.square.fill.and.square")
                    }// Button
                }// ToolbarItem
            }// .toolbar
        }// NavigationView
        // Popoverを表示
        // Popoverを表示する位置を placement: で指定する。
        // .leadingなら左、.trailingなら右に表示
        .toolBarPopover(show: $show, placement: .trailing){
            // Showing dynamic usage...
            // Toggleを使って、trueにした場合はボタンをタップした時に、Pickerを表示する
            // Toggleを使って、falseにした場合はボタンをタップした時に、Pickerを非表示にする
            if showPicker{
                Picker("", selection: .constant("sss")){
                    // Textと1から10までの数字を表示する
                    ForEach(1...10, id: \.self){index in
                        Text("Hello\(index)")
                            .tag(index)
                    }
                }
                .labelsHidden()
                .pickerStyle(.wheel)
            }
            // showPickerがfalseの時
            else{
                // graphicalDateがtrueの時はDatePickerを.datePickerStyle(.graphical)で表示する。
                if graphicalDate{
                    // Popover View...
                    // 引数の.constant(Date())で現在の日付と時刻を表示する
                    DatePicker("",selection: .constant(Date()))
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                // graphicalDateがfalseの時はDatePickerを.datePickerStyle(.compact)で表示する。
                else{
                    // Popover View...
                    DatePicker("",selection: .constant(Date()))
                        .datePickerStyle(.compact)
                        .labelsHidden()
                }
            }
        }// .toolBarPopover
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
