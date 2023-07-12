//
//  CoinImageService.swift
//  Crypto Tracking
//
//  Created by M.Huzaifa on 6/28/23.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    let coin: CoinModel
    
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_image"
    private let coinName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinName = coin.id
        
        getImage()
    }
    func getImage() {
        if let savedImage = fileManager.getImage(imageName: coinName, folderName: folderName) {
            self.image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard
                    let self = self,
                    let downloadedImage = returnedImage else { return }
                
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.coinName, folderName: self.folderName)
                
            })
    }
}
