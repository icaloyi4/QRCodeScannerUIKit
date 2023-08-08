//
//  BackButton.swift
//  qrcodereader
//
//  Created by Rizky Haris Risaldi on 06/08/23.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var title : String?
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack {
                Image(systemName: "chevron.left") // BackButton Imag
                    .foregroundColor(.black)
                Text((title ?? "")) //translated Back button title
            }
        }
        
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
