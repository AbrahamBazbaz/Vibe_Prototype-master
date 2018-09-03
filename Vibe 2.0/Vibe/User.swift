//
//  CurrentUser.swift
//  FriendRequest
//
//  Created by Abey Bazbaz on 8/7/18.
//

import Foundation

class User
{
	var id: String
	//var name: String
	var email: String
	//var profileImageUrl: String
	
	init(userEmail: String, userID: String)
	{
		self.id = userID
		self.email = userEmail
		//		self.name = dictionary["name"] as? String ?? ""
		//		self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
	}
	
}
