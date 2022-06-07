//
//  Data.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 05/06/2022.
//

import SwiftUI
import RealmSwift

class RealmManager: ObservableObject {
    
    private(set) var localRealm: Realm?
    @Published private(set) var intervals: [Interval] = []
    
    init() {
        openRealm()
        getIntervals()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 3) // Might need migration block if updating schema...
            
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch  {
            print("Error opening realm! \(error)")
        }
    }
    func addInterval(title: String){
        if let localRealm = localRealm {
            do {
                try localRealm.write{
                    let newItem = Interval(value: ["title": title])
                    localRealm.add(newItem)
                    getIntervals()
                    print("New Item added to Realm \(newItem)")
                    
                }
            } catch  {
                print("Error adding item to realm \(error)")
            }
        }
    }
    
    func getIntervals() {
        if let localRealm = localRealm {
            let allIntervals = localRealm.objects(Interval.self).sorted(byKeyPath: "title")
            intervals = []
            allIntervals.forEach { interval in
                intervals.append(interval)
            }
        }
    }
    func updateInterval(id: ObjectId, active: Bool) {
        if let localRealm = localRealm {
            do {
                let intervalToUpdate = localRealm.objects(Interval.self).filter(NSPredicate(format: "id == %@", id))
                guard !intervalToUpdate.isEmpty else { return }
                
                try localRealm.write{
                    intervalToUpdate[0].active = active
                    getIntervals()
                    print("Updated task with id: \(id). Active status: \(active)")
                }
            } catch  {
                print("Error updating interval \(id) to realm: \(error)")
            }
        }
    }
    
    func deleteInterval(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let intervalToDelete = localRealm.objects(Interval.self).filter(NSPredicate(format: "id == %@", id))
                guard !intervalToDelete.isEmpty else { return }
                try localRealm.write{
                    localRealm.delete(intervalToDelete)
                    getIntervals()
                    print("Deleted interval with id: \(id).")
                }
            } catch {
                print("Error deleting interval with id: \(id). \(error)")
            }
        }
    }
}

class Interval: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var active = true
    @Persisted var dynamic = 0
    @Persisted var tempo = 0
    @Persisted var articulation = 0
    
    var dynamicToDisplay: String {
        get {
            switch dynamic {
            case 0:
                return "mf"
            case 1:
                return "pp"
            case 2:
                return "ff"
            default:
                return "error!"
            }
        }
    }
    var tempoToDisplay: String {
        get {
            switch tempo {
            case 0:
                return "Moderato"
            case 1:
                return "Adagie"
            case 2:
                return "Presto"
            default:
                return "error!"
            }
        }
    }
    var articulationToDisplay: String {
        get {
            switch articulation {
            case 0:
                return "Normal"
            case 1:
                return "Legato"
            case 2:
                return "Staccato"
            default:
                return "error!"
            }
        }
    }
    // best solution for setting and retrieving characteristics?
    
}

class Schedule: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var intervalId: ObjectId
}

//class PracticeList: Object {
//    @Persisted var items = RealmSwift.List<PracticeItem>()
//}
