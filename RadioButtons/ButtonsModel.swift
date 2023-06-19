//
//  ButtonsModel.swift
//  RadioButtons
//
//  Created by yeowongu on 2023/06/19.
//

import Foundation
import Combine

class ButtonsModel: ObservableObject {
    
    enum selection {
        case select     // 선택됨
        case deselect   // 해제됨
    }
    
    var dataSubject = PassthroughSubject<selection, Never>()
}
