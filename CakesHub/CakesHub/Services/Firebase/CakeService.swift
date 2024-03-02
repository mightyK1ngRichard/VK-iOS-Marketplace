//
//  CakeService.swift
//  CakesHub
//
//  Created by Dmitriy Permyakov on 27.12.2023.
//

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI

// MARK: - CakeServiceProtocol

protocol CakeServiceProtocol {
//    func getCakesList(completion: @escaping CHMResultBlock<[ProductModel], APIError>)
    func createCake(userID: String, cake: ProductRequest, completion: @escaping (Error?) -> Void)
}

// MARK: - CakeService

final class CakeService {

    static var shared = CakeService()
    private let firestore = Firestore.firestore()
    private let storage = Storage.storage()

    private init() {}
}

// MARK: - Methods

extension CakeService: CakeServiceProtocol {

    /// Cake creation
    /// - Parameters:
    ///   - userID: user document id
    ///   - cakeModel: cake info
    ///   - completion: creation result
    func createCake(userID: String, cake: ProductRequest, completion: @escaping (Error?) -> Void) {
        let dispatchGroup = DispatchGroup()

        var images: [String] = []
        switch cake.images {
        case let .images(uiImages):
            uiImages.forEach { image in
                dispatchGroup.enter()
                createImage(
                    image: image,
                    directoryName: "cake/\(userID)/\(cake.productName)",
                    imageName: generateUniqueFileName(userID: userID)
                ) { result in
                    switch result {
                    case .success(let url):
                        asyncMain {
                            images.append(url)
                        }
                        dispatchGroup.leave()
                    case .failure(let error):
                        print(error)
                        dispatchGroup.leave()
                    }
                }
            }
        case let .url(urls):
            images = urls.toStringArray
        case .clear:
            break
        }

        dispatchGroup.notify(queue: .main) {
            Logger.log(message: images)
            self.firestore
                .collection(FirestoreCollections.products.rawValue)
                .addDocument(
                    data: cake.mapperToDictionaty(userID: userID, images: images),
                    completion: completion
                )
        }
    }

    /// Image creation
    /// - Parameters:
    ///   - image: image
    ///   - directoryName: name of directory
    ///   - imageName: image name
    ///   - completion: image url
    private func createImage(
        image: UIImage?,
        directoryName: String,
        imageName: String,
        completion: @escaping CHMResultBlock<String, APIError>
    ) {
        guard let image else {
            completion(.failure(.badParameters))
            return
        }
        let storageRef = storage.reference().child("images/\(directoryName)/\(imageName).jpg")
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            completion(.failure(.badParameters))
            return
        }
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error {
                asyncMain { completion(.failure(.error(error))) }
                return
            }
            guard !metadata.isNil else {
                asyncMain { completion(.failure(.dataIsNil)) }
                return
            }

            storageRef.downloadURL { url, error in
                if let error {
                    asyncMain { completion(.failure(.error(error))) }
                    return
                }

                if let imageUrl = url?.absoluteString {
                    asyncMain { completion(.success(imageUrl)) }
                }
            }
        }
    }
}

// MARK: - Helper

/// Generation unique name for cake image
/// - Parameter userID: seller uid
/// - Returns: file name
private func generateUniqueFileName(userID: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd_HHmmssSSS"

    let currentDateTime = Date()
    let formattedDate = dateFormatter.string(from: currentDateTime)

    let uniqueFileName = "photo_\(userID)_\(formattedDate)"

    return uniqueFileName
}
