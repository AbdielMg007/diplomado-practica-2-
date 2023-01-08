//
//  Helper.swift
//  proyecto2ios
//
//  Created by Abdiel Mg on 28/12/22.
//

import Foundation
import UIKit


func validateText(text : String) -> Bool{
    if (text.trimmingCharacters(in: .whitespaces).isEmpty){
        return false
    }
    else{
        return true
    }
}

