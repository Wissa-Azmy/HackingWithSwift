//
//  ViewController.swift
//  Project6b
//
//  Created by TwoStraws on 15/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()

		let label1 = createLabel(withString: "THESE", bgColor: UIColor.red)

		let label2 = createLabel(withString: "ARE", bgColor: UIColor.cyan)

		let label3 = createLabel(withString: "SOME", bgColor: UIColor.yellow)

		let label4 = createLabel(withString: "AWESOME", bgColor: UIColor.green)

		let label5 = createLabel(withString: "LABELS", bgColor: UIColor.orange)

		view.addSubview(label1)
		view.addSubview(label2)
		view.addSubview(label3)
		view.addSubview(label4)
		view.addSubview(label5)

//		let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]

//		for label in viewsDictionary.keys {
//			view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//		}

//		let metrics = ["labelHeight": 88]
//		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
        
        layout(labels: [label1, label2, label3, label4, label5])
	}
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    private func createLabel(withString text: String, bgColor color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = color
        label.text = text
        
        return label
    }
    
    
    private func layout(labels: [UILabel]){
        var previous: UILabel?
        
        for label in labels {
            //            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 0
                ).isActive = true
            label.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: 0
                ).isActive = true
            
            //            label.heightAnchor.constraint(equalToConstant: (view.frame.height/5) - 10).isActive = true
            label.heightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.heightAnchor,
                multiplier: 0.2, constant: -10
                ).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(
                    equalTo: previous.bottomAnchor,
                    constant: 10
                    ).isActive = true
            }
            
            previous = label
        }
    }
}

