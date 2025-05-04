//
//  DraftViewModel.swift
//  iOSSea
//
//  Created by makrowave on 04/05/2025.
//

import Foundation
import SwiftUI
import CoreData
class DraftViewModel : ObservableObject {
    let context = PersistenceController.shared.container.viewContext
    @Published var drafts: [Draft] = []
    
    init() {
        fetchDrafts()
    }
    
    func delete(at offsets: IndexSet) -> Void {
        let draftsToDelete = offsets.map { drafts[$0] }
        context.performAndWait {
            do {
                for draft in draftsToDelete {
                    let savedDraft = context.object(with: draft.id!) as! SavedDraft
                    context.delete(savedDraft)
                }
                try context.save()
                print("Draft deletion successful")
            } catch {
                print("Draft delete error: \(error)")
            }
            
        }
        
        drafts.remove(atOffsets: offsets)
        fetchDrafts()
    }
    
    func fetchDrafts() -> Void {
        let request: NSFetchRequest<SavedDraft> = SavedDraft.fetchRequest()
        
        do {
            let savedDrafts = try context.fetch(request)
            drafts = savedDrafts.map { Draft(from: $0) }
        } catch {
            print("Drafts fetch error: \(error)")
        }
    }
    
    func getLayers(for draft: Draft) -> [Layer] {
        let request: NSFetchRequest<SavedLayer> = SavedLayer.fetchRequest()
        
        request.predicate = NSPredicate(format: "toDraft == %@", draft.id!)

        do {
            let savedLayers = try context.fetch(request)
            let sortedLayers = savedLayers.sorted { $0.order < $1.order }
            return sortedLayers.map { Layer(name: $0.name!, image: UIImage(data: $0.layer!)!) }
        } catch {
            print("Failed to fetch layers for draft: \(error)")
            return []
        }
    }
    
    func saveDraft(draft: Draft, layers: [Layer]) {
        // Transaction
        context.performAndWait {
            do {
                // If exists change date and image, delete layers else create new, save layers
                if let objectId = draft.id {
                    // Get draft
                    let oldDraft = context.object(with: objectId) as! SavedDraft
                    oldDraft.lastChange = Date()
                    oldDraft.image = draft.image.pngData()  // Save as PNG
                    // Delete layers
                    let oldLayersRequest: NSFetchRequest<SavedLayer> = SavedLayer.fetchRequest()
                    oldLayersRequest.predicate = NSPredicate(format: "toDraft == %@", oldDraft)
                    let oldLayers = try context.fetch(oldLayersRequest)
                    for layer in oldLayers {
                        context.delete(layer)
                    }
                    // Save layers
                    for (index, layer) in layers.enumerated() {
                        let savedLayer = SavedLayer(context: context)
                        savedLayer.toDraft = oldDraft
                        savedLayer.layer = layer.image.pngData()
                        savedLayer.name = layer.name
                        savedLayer.active = layer.active
                        savedLayer.order = Int16(index)
                    }
                } else {
                    let newDraft = SavedDraft(context: context)
                    newDraft.lastChange = Date()
                    newDraft.image = draft.image.pngData()  // Save as PNG
                    // Save layers
                    for (index, layer) in layers.enumerated() {
                        let savedLayer = SavedLayer(context: context)
                        savedLayer.toDraft = newDraft
                        savedLayer.layer = layer.image.pngData()
                        savedLayer.name = layer.name
                        savedLayer.active = layer.active
                        savedLayer.order = Int16(index)
                    }
                }
                // Commit
                try context.save()

            } catch {
                print("Saving draft failed: \(error)")
                context.rollback()
            }
        }
        fetchDrafts()
    }

}
