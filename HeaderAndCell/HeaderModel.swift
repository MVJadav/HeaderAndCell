//
//  HeaderModel.swift
//  TestDemo
//
//  Created by MV Jadav on 16/08/17.
//  Copyright © 2017 MV Jadav. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class HeaderSection<T: Mappable>: Mappable {
    
    var Title: String?
    var Row: [T]?
    
    init?() {
        
    }
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        Title      <- map["Title"]
        Row       <- map["Row"]
    }
}

class Row: Mappable {
    
    var title                : String? = ""
    
    required init(){
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        title       <- map["title"]
    }
    
}
