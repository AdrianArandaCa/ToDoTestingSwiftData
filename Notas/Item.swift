//
//  Item.swift
//  Notas
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
