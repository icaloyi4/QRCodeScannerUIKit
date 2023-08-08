//
//  DefaultView.swift
//  qrcodereader
//
//  Created by Rizky Haris Risaldi on 06/08/23.
//

import SwiftUI

struct DefaultView: View {
    var route : String?
    var body: some View {
        Text("\(route ?? "Example" ) tidak ditemukan")
    }
}

struct DefaultView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DefaultView()
        }
        
    }
}
