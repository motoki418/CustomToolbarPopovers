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
        }// NavigationView
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
