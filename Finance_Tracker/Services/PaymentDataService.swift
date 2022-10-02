//
//  TranscationDataService.swift
//  Finance_Tracker
//
//  Created by Milton Liu on 2022/7/19.
//

import Foundation
import CoreData

class PaymentDataService: ObservableObject {
    @Published var payments: [Payment] = []
    
    private let container: NSPersistentContainer
    private let containerName: String = "Main"
    private let entityName: String = "Payment"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load core data. \(error)")
            }
            
            self.loadingData()
        }
    }
    
    func addNewPayment(type: Int64, icon: String, name: String, amount: Double, date: Date) {
        let entity = Payment(context: container.viewContext)
        entity.id = UUID().uuidString
        entity.type = type
        
        if type == 0 {
            entity.amount = -amount
        } else {
            entity.amount = amount
        }
        entity.icon = icon
        entity.name = name
        entity.date = date
        applyChanges()
    }
    
    func delete(entity: Payment) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    func updatePaymentDetail(payment: Payment, type: Int64, icon: String, name: String, amount: Double, date: Date) {
        
        guard let currentSelection = payments.first(where: { $0.id == payment.id }) else {
            return
        }
        
        currentSelection.type = type
        currentSelection.id = UUID().uuidString
        
        if type == 0 {
            currentSelection.amount = -amount
        } else {
            currentSelection.amount = amount
        }
        
        currentSelection.icon = icon
        currentSelection.name = name
        currentSelection.date = date
        
        applyChanges()
    }
    
    
    private func loadingData() {
        let request = NSFetchRequest<Payment>(entityName: entityName)
        do {
            payments = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching core data. \(error)")
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core data. \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        loadingData()
    }
}
