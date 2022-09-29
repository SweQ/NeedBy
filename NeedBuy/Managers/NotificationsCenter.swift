//
//  NotificationsCenter.swift
//  NeedBuy
//
//  Created by alexKoro on 20.09.22.
//

import Foundation
import UserNotifications

class NotificationsCenter{
    static let shared = NotificationsCenter()
    private let center = UNUserNotificationCenter.current()
    
    private init() { }
    
    func addNotification(with purchase: Purchase) {
        guard let date = purchase.date else { return }
        let purchasesOnDate = CoreDataManager.share.downloadPurchases(with: date)
        let countPurchases = purchasesOnDate.count
        if purchasesOnDate.count > 0 {
            deleteNotification(with: date.shortStringDate())
        }
        authorization {
            self.createNotification(with: date, message: "\(Words.todayYouHavePurchases.value()): \(countPurchases)", countPurchases: countPurchases)
        }
        
    }
    
    private func createNotification(with date: Date, message: String, countPurchases: Int) {
        let content = UNMutableNotificationContent()
        content.title = "NeedBuy"
        content.body = message
        content.badge = countPurchases as NSNumber
        
        let dateComponents = createDateComnponents(hour: 14, minutes:0)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: date.shortStringDate(), content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
    }
    
    private func createDateComnponents(hour: Int, minutes: Int) -> DateComponents {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date.now)
        dateComponents.hour = hour
        dateComponents.minute = minutes
        
        return dateComponents
    }
    
    func removeNotification(for purchase: Purchase) {
        guard let date = purchase.date else { return }
        let purchasesOnDate = CoreDataManager.share.downloadPurchases(with: date)
        let remainderCountPurchases = purchasesOnDate.count - 1
        deleteNotification(with: date.shortStringDate())
        
        if remainderCountPurchases > 0 {
            createNotification(
                with: date,
                message: "\(Words.todayYouHavePurchases): \(remainderCountPurchases)",
                countPurchases: remainderCountPurchases
            )
        }
    }
    
    private func deleteNotification(with identifier: String) {
        center.removeDeliveredNotifications(withIdentifiers: [identifier])
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    private func authorization(handler: @escaping ()->()){
        center.requestAuthorization(options: [.sound, .alert, .badge]) { allow, error in
            if allow {
                handler()
            } else if let error = error{
                print(error.localizedDescription)
            }
        }
    }
}
