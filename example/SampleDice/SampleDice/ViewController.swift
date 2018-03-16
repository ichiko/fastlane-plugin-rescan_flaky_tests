//
//  ViewController.swift
//  SampleDice
//
//  Created by ichiko on 2018/03/14.
//  Copyright © 2018年 ichiko_revjune. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var outputLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        outputLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickThrow(_ sender: UIButton) {
        let random = arc4random_uniform(6) + 1
        outputLabel.text = String(random)
    }

}

