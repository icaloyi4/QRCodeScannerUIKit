//
//  TransactionModel.swift
//  qrcodereader
//
//  Created by Rizky Haris Risaldi on 06/08/23.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let transactionModel = try? JSONDecoder().decode(TransactionModel.self, from: jsonData)


// MARK: - TransactionModel
struct TransactionModel: Codable {
    var transactionHistory: [TransactionHistory]?

    enum CodingKeys: String, CodingKey {
        case transactionHistory = "transaction_history"
    }
}

// MARK: - TransactionHistory
struct TransactionHistory: Codable {
    var id: String?
    var bank, merchant: String?
    var value: Int?
}
