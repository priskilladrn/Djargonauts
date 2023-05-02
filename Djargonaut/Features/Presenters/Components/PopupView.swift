//
//  PopupView.swift
//  Djargonaut
//
//  Created by Wita Dewisari Tasya on 28/04/23.
//

import SwiftUI

struct PopupView: View {
    @Binding var isPresented: Bool
        
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Color.black.opacity(0.4)
                        .onTapGesture {
                                isPresented = false
                        }
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        SliderView()
                        .padding()
                    }
                    .frame(width: geometry.size.width * 0.9,
                           height: geometry.size.height * 0.9)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                }
            }
    }
}

// Ini kalau buat show pakai button
// Ubah isPresentednya
struct ShowPopupView: View {
    @State var isPresented = false
        
        var body: some View {
            VStack {
                Button("Show Popup") {
                    isPresented = true
                }
            }
            .sheet(isPresented: $isPresented) {
                PopupView(isPresented: $isPresented)
            }
        }
    }


struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        ShowPopupView()
    }
}
