//
//  DatabaseHelper.swift
//  WiseChat GPT
//
//  Created by Md Murad Hossain on 9/3/23.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper {
    
    static var shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
//    func getAllItem() {
//        do {
//            historyArray = try context!.fetch(MessageItemList.fetchRequest())
//        }
//        catch {
//            print("Error")
//        }
//    }
    
    func createItem(question: String, answer: String) {
        let newItem = MessageItemList(context: context!)
        newItem.question = question
        newItem.answer = answer
        newItem.createdAt = Date()
        var date = "\(newItem.createdAt!)"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EE, dd MMMM yyyy   h:mm:ss a"
        let datee = dateFormatterGet.date(from:  date)
        date = dateFormatterPrint.string(from: datee ?? Date())
        
        do {
            try context!.save()
           // getAllItem()
        }
        catch {
            // Error
        }
    }
    
    func deleteItem(item: MessageItemList) {
        context!.delete(item)
        
        do {
            try context!.save()
        }
        catch {
            // Error
        }
    }
}
