//
//  CoreDataMAnager.swift
//  BSShop
//
//  Created by User on 20.08.2021.
//

protocol CoreDataManagerProtocol {
    func saveData(array: [Product])
    func getData( complession: @escaping ([CoreDataModel]) -> Void)
    func resetAllData()
}

import UIKit
import CoreData
class CoreDataManager: CoreDataManagerProtocol {

    static let shared = CoreDataManager()
    weak var appdelegate = UIApplication.shared.delegate as? AppDelegate
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveData(array: [Product]) {
        let entity = ProductEntity(context: context)
        for item in array {
            entity.article = item.article
            entity.descripsion = item.description
            entity.imageUrl = item.mainImage
            entity.name = item.name
            entity.price = item.price
        }
        do {
            try? context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func getData( complession: @escaping ([CoreDataModel]) -> Void) {
        var arrayOfDataFromCoredata = [CoreDataModel]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print(result.count)
            for data in result as! [NSManagedObject] {
                guard   let article = data.value(forKey: "article") as? String else {return}
                guard   let descripsion = data.value(forKey: "descripsion") as? String else {return}
                guard let imageUrl = data.value(forKey: "imageUrl") as? String else {return}
                guard let name = data.value(forKey: "name") as? String else {return}
                guard let price = data.value(forKey: "price") as? String else {return}
                let currentData = CoreDataModel(article: article,
                                                descripsion: descripsion,
                                                imageUrl: imageUrl,
                                                name: name,
                                                price: price)
                arrayOfDataFromCoredata.append(currentData)
                complession(arrayOfDataFromCoredata)
            }
        } catch {
            print("Fetching data Failed")
        }
    }
    private init() {
    }
    
    func resetAllData() {
            let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            do
            {
                try context.execute(deleteRequest)
                try context.save()
            }
            catch
            {
              print(error.localizedDescription)
            }
        }
}
