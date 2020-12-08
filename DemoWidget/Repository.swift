//
//  Repository.swift
//  DemoWidget
//
//  Created by Bùi Xuân Huy on 07/12/2020.
//

class Repository {
    static let shared = Repository()
    
    func fakeData() -> [MyPet] {
        return [MyPet(name: "Xu 1", photo: #imageLiteral(resourceName: "IMG_7893")),
                MyPet(name: "Xu 2", photo: #imageLiteral(resourceName: "IMG_7892")),
                MyPet(name: "Xu 3", photo: #imageLiteral(resourceName: "IMG_7891"))]
    }
}


