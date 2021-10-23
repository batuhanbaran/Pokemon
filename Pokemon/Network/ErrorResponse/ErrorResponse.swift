//
//  ErrorResponse.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 20.10.2021.
//

import Foundation

enum ErrorResponse: Error {
    case decode(String)
    case notFound(String)
    case unauthorized(String)
}
