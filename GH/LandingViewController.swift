//
//  ViewController.swift
//  GH
//
//  Created by Adam Reed on 12/9/18.
//  Copyright © 2018 rdConcepts. All rights reserved.
//

import UIKit

class LandingViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Goofhead", for: indexPath)
        return cell
    }

}

