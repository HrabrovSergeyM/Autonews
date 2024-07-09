//
//  LocalFileManager.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    
    private init() { }
    
    func saveImageData(data: Data, imageName: String, folderName: String) {
        createFolderIfNeeded(folderName: folderName)
        
        guard let url = getURLForImageData(imageName: imageName, folderName: folderName) else {
            Logger.shared.log("Failed to get URL for image data. Image name: \(imageName)", level: .error)
            return
        }
        
        do {
            try data.write(to: url)
        } catch let error {
            Logger.shared.log("Error saving image data. Image name: \(imageName). Error: \(error.localizedDescription)", level: .error)
        }
    }
    
    func getImageData(imageName: String, folderName: String) -> Data? {
        guard
            let url = getURLForImageData(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else {
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let error {
            Logger.shared.log("Error retrieving image data. Image name: \(imageName). Error: \(error.localizedDescription)", level: .error)
            return nil
        }
    }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        createFolderIfNeeded(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else {
            Logger.shared.log("Failed to get image data or URL. Image name: \(imageName)", level: .error)
            return
        }
        
        do {
            try data.write(to: url)
        } catch let error {
            Logger.shared.log("Error saving image. Image name: \(imageName). Error: \(error.localizedDescription)", level: .error)
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else {
            Logger.shared.log("Image not found. Image name: \(imageName)", level: .warning)
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            Logger.shared.log("Failed to get URL for folder. Folder name: \(folderName)", level: .error)
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                Logger.shared.log("Error creating directory. Folder name: \(folderName). Error: \(error.localizedDescription)", level: .error)
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            Logger.shared.log("Failed to get URL for caches directory", level: .error)
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            Logger.shared.log("Failed to get URL for folder. Folder name: \(folderName)", level: .error)
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
    private func getURLForFile(fileName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            Logger.shared.log("Failed to get URL for caches directory", level: .error)
            return nil
        }
        return url.appendingPathComponent(fileName + ".json")
    }
    
    private func getURLForImageData(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            Logger.shared.log("Failed to get URL for folder. Folder name: \(folderName)", level: .error)
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
