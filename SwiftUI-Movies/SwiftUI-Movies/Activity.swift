//
//  Activity.swift
//  SwiftUI-Movies
//
//  Created by Ben Scheirman on 3/23/20.
//  Copyright © 2020 NSScreencast. All rights reserved.
//

import SwiftUI
import UIKit

struct Activity : UIViewRepresentable {

    let style: UIActivityIndicatorView.Style
    @Binding var isAnimating: Bool

    init(style: UIActivityIndicatorView.Style = .medium, isAnimating: Binding<Bool>) {
        self.style = style
        self._isAnimating = isAnimating
    }

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.hidesWhenStopped = true
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
