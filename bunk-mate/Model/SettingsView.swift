//
//  SettingsView.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 22/07/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = ChangeAppIconViewModel()

    var body: some View {
        VStack {
            Text("Like the app? Consider rating it on the App Store")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct CheckboxView: View {
    let isSelected: Bool

    private var image: Image {
        let imageName = isSelected ? "icon-checked" : "icon-unchecked"
        return Image(systemName: imageName)
    }

    var body: some View {
        image
    }
}
