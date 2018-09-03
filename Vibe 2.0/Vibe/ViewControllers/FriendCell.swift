//
//  FriendCell.swift
//  Vibe
//
//  Created by Abey Bazbaz on 9/2/18.
//  Copyright © 2018 Allan Frederick. All rights reserved.
//

import Foundation
import UIKit

class FriendCell: UITableViewCell {

	var message: String?
	
	var messageView : UITextView = {
		var textView = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.isScrollEnabled = false
		return textView
	}()
	
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?)
	{
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.addSubview(messageView)
		
		messageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		if let message = message {
			messageView.text = message
		}
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
