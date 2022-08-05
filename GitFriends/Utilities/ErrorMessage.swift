//
//  ErrorMessage.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 8/4/22.
//

import Foundation

// Raw value = all cases conform to one type
// Associated value = each case can have a different type

// Need to conform to String + Error to be of Result Failure Type 
enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server is invalid. Please try again."
}
