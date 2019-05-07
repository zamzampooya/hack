//
//  Document.swift
//  EQMM
//
//  Created by Zamzam Farzamipooya on 07/05/2019.
//  Copyright © 2019 Zamzam Farzamipooya. All rights reserved.
//

import Foundation

class OrderLine: Codable {
    var name: String?
    var numberOfItems: String?
    var price: Double?
    public init(name: String?,numberOfItems: String?,price: Double? ) {
        self.name = name
        self.numberOfItems = numberOfItems
        self.price = price
    }

}

class History: Codable {
    var date: String?
    var comment: String?
    var state: HistoryState?
    public init(date: String?,comment: String?,state: HistoryState? ) {
        self.date = date
        self.comment = comment
        self.state = state
    }
}

class Document: Codable{
    var id: Int?
    var customer: String?
    var state: DocumentState?
    var description: String?
    var total: Float?
    var discount: Float?
    var orderlines: [OrderLine]?
    var history: [History]?
    var date: String?
    var totalVat: Float?
    public init() {}
    
    public init(id: Int?, customer: String?,state: DocumentState?, description: String?,total: Float?, discount: Float?, orderlines: [OrderLine]?, history: [History]?, date: String?, totalVat: Float?) {
        self.id = id
        self.customer = customer
        self.state = state
        self.description = description
        self.total = total
        self.discount = discount
        self.orderlines = orderlines
        self.history = history
        self.date = date
        self.totalVat = totalVat
        
    }

}

enum DocumentState: String, Codable {
    case quote
    case invoice
    case order
    func preferedText() -> String {
        switch self {
        case .quote:
            return "Quote no."
        case .invoice:
            return "Invoice no."
        case .order:
            return "Order no."
        }
    }
}

enum HistoryState: String, Codable{
    case quoteSent
    case quoteSeen
    case quoteAccepted
    case orderSent
    case orderSeen
    case invoiceSent
    func preferedText() -> String {
        switch self {
        case .quoteSent:
            return "Quote Sent"
        case .quoteSeen:
            return "Quote Seen"
        case .quoteAccepted:
            return "Quote Accepted"
        case .orderSent:
            return "Order Sent"
        case .orderSeen:
            return "Order Seen"
        case .invoiceSent:
            return "Invoice Sent"
        }
    }

}

class MockData: NSObject {
    static let shared = MockData()
    var documents = [Document(id: 10065, customer: "Finlandia", state: DocumentState(rawValue: "quote"), description: "", total: 50, discount: 0, orderlines: nil, history: [History(date: "06.05.2019", comment: nil, state: HistoryState(rawValue: "quoteSent"))], date: nil, totalVat: 300),
                                                    Document(id: 10066, customer: "Fazer", state: DocumentState(rawValue: "quote"), description: "", total: 90, discount: 0, orderlines: nil, history: [History(date: "07.05.2019", comment: nil, state: HistoryState(rawValue: "quoteSent"))], date: nil, totalVat: 300)]
}
