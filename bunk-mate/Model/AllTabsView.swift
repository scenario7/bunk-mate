//
//  AllTabsView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 13/07/23.
//

import SwiftUI

struct AllTabsView: View {
    var body: some View {
        TabView{
            HomeScreen()
        }
    }
}

struct AllTabsView_Previews: PreviewProvider {
    static var previews: some View {
        AllTabsView()
    }
}
