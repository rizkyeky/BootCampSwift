//
//  SignInFloatingPanel.swift
//  CinemaTix
//
//  Created by Eky on 07/11/23.
//

import Foundation
import FloatingPanel

class SignInFloatingPanelLayout: FloatingPanelLayout {
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.4, edge: .bottom, referenceGuide: .safeArea),
    ]
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        if state == FloatingPanelState.half {
            return 0.64
        } else {
            return 0
        }
    }
}
