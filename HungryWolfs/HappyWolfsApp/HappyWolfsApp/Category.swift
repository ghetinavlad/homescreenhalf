//
//  Category.swift
//  Category
//
//  Created by Wolfpack Digital on 04.08.2021.
//

import Foundation

struct Category :  Codable{
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
}

struct Categories: Codable {
  var categories: [Category]
}
