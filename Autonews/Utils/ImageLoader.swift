//
//  ImageLoader.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var imageData: Data?
    
    private var cancellables = Set<AnyCancellable>()
    private let networkingService: NetworkingServiceProtocol
    
    init(networkingService: NetworkingServiceProtocol = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    func loadImage(from url: String, imageName: String, folderName: String) {
        if let cachedImageData = LocalFileManager.instance.getImageData(imageName: imageName, folderName: folderName) {
            self.imageData = cachedImageData
        } else {
            downloadImage(from: url, imageName: imageName, folderName: folderName)
        }
    }
    
    private func downloadImage(from urlString: String, imageName: String, folderName: String) {
        guard let url = URL(string: urlString) else {
            Logger.shared.log("Invalid URL: \(urlString)", level: .error)
            return
        }
        
        networkingService.get(url: url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    Logger.shared.log("Error downloading image: \(error.localizedDescription)", level: .error)
                }
            } receiveValue: { [weak self] data in
                self?.imageData = data
                LocalFileManager.instance.saveImageData(data: data, imageName: imageName, folderName: folderName)
            }
            .store(in: &cancellables)
    }
}
