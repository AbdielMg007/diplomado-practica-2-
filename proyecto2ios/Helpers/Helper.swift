//
//  Helper.swift
//  proyecto2ios
//
//  Created by Abdiel Mg on 28/12/22.
//

import Foundation
import UIKit


func validateText(text : String?) -> Bool {
  guard let text: String = text else { return false }
  return !(text.trimmingCharacters(in: .whitespaces).isEmpty)
}

