import CoreData
import UIKit

protocol CoreDataManagerDelegate: UIViewController {
    func didUpdateData()
}

class CoreDataManager<T: NSManagedObject> {
    var items: [T] = []
    
    weak var delegate: CoreDataManagerDelegate?
    
    private let context: NSManagedObjectContext = Constant.appDelegate.persistentContainer.viewContext
    
    var globalPredicates: [NSPredicate]?
    
    private func fetch(_ request: NSFetchRequest<T>) -> [T] {
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return []
        }
    }
    
    func loadData(predicates: [NSPredicate]? = [], type:NSCompoundPredicate.LogicalType = .and, sortDescriptors: [NSSortDescriptor]? = nil) {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        
        if let predicates = predicates {
            if let globalPredicates = globalPredicates {
                fetchRequest.predicate = NSCompoundPredicate(type: type, subpredicates: predicates + globalPredicates)
            }
            else {
                fetchRequest.predicate = NSCompoundPredicate(type: type, subpredicates: predicates)
            }
        } else if let globalPredicates = globalPredicates {
            fetchRequest.predicate = NSCompoundPredicate(type: type, subpredicates: globalPredicates)
        }
        
        if let sortDescriptors = sortDescriptors {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        items = fetch(fetchRequest)
        
        delegate?.didUpdateData()
    }
    
    func saveAndLoadContext() {
        Constant.appDelegate.saveContext()
        
        loadData()
    }
    
    func delete(_ item: T) {
        context.delete(item)
        
        saveAndLoadContext()
    }
    
    func createEntity() -> T {
        return T(context: context)
    }
}
