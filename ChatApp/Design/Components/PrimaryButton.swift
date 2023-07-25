//
//  PrimaryButton.swift
//  ChatApp
//
//  Created by Gwinyai Nyatsoka on 22/7/2023.
//

import Foundation
import UIKit

class PrimaryButton: UIButton {
    
    init(frame: CGRect, test: String = "") {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    func initSubviews() {
        backgroundColor = UIColor(named: "secondary")
    }
    
    func setTitle(text: String) {
        setAttributedTitle(NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
    }
    
}
