//
//  HomeView.swift
//  CustomToolbarPopovers
//
//  Created by nakamura motoki on 2022/02/21.
//

import SwiftUI

struct HomeView: View {
    
    // Upadatin Popover Views...
    @State var graphicalDate: Bool = false
    @State var showPicker: Bool = false
    
    @State var show: Bool = false
    var body: some View {
        NavigationView{
            
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
                            show.toggle()
                        }
                    }label: {
                        Image(systemName: "slider.horizontal.below.square.fill.and.square")
                    }// Button
                }// ToolbarItem
            }// .toolbar
        }// NavigationView
        .toolBarPopover(show: $show, placement: .trailing){
            
            // Showing dynamic usage...
            if showPicker{
                Picker("", selection: .constant("")){
                    ForEach(1...10, id: \.self){index in
                        Text("Hello\(index)")
                            .tag(index)
                    }
                }
                .labelsHidden()
                .pickerStyle(.wheel)
                
            }
            else{
                if graphicalDate{
                    // Popover View...
                    DatePicker("",selection: .constant(Date()))
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }else{
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
