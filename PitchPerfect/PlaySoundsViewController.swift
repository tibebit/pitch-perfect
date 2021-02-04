//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Fabio Tiberio on 03/02/21.
//

import UIKit

class PlaySoundsViewController: UIViewController {
    
    var recorderAudioURL : URL!
    
    @IBOutlet weak var snailButton : UIButton!
    @IBOutlet weak var rabbitButton : UIButton!
    @IBOutlet weak var chipmunkButton : UIButton!
    @IBOutlet weak var vaderButton : UIButton!
    @IBOutlet weak var echoButton : UIButton!
    @IBOutlet weak var reverbButton : UIButton!
    @IBOutlet weak var stopButton : UIButton!
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Sound Button Pressed")
    }
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
