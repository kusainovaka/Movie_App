//
//  Extension.swift
//  MovieApp
//
//  Created by Kamila Kusainova on 18.11.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import Foundation

extension String {
    mutating func insert(string: String,int: Int) {
        self.insert(contentsOf: string, at:string.index(string.startIndex, offsetBy: int) )
    }
}

extension UserDefaults {
    func setAccessTime(time: Double, name: String) {
        setValue(time, forKey: name)
    }
    
    func getAccessTime(name: String) -> Double {
        return double(forKey: name)
    }
}
