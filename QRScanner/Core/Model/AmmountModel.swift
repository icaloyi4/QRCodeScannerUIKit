//
//  AmmountModel.swift
//  qrcodereader
//
//  Created by Rizky Haris Risaldi on 06/08/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// let ammountModel = try? JSONDecoder().decode(AmmountModel.self, from: jsonData)

import Foundation

// MARK: - AmmountModel
struct AmmountModel: Codable {
    var userAmmount: Int?

    enum CodingKeys: String, CodingKey {
        case userAmmount = "user_ammount"
    }
}
