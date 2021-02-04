//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Fabio Tiberio on 18/01/21.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder!
    
    // MARK: Called when the app is loaded into memory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(recordingState: false)
    }
    
    // MARK: Called right before performing the segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue setup
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recorderAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recorderAudioURL
        }
    }
    
    // MARK: Audio Functions
    
    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in Progress"
        configureUI(recordingState: true)

        //Initialize the recording session
        //We retrieve the information about the path in which the app should store the new file
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        //We setup the audio session which is basically an abstraction of the hardware that we use to record and playback sounds
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        //Setup the audio recorder
        //Note that audioRecorder.record() calls implicitly the prepareToAudio method
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        recordingLabel.text = "Tap to Record"
        configureUI(recordingState: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: AVAudioRecorderDelegate Functions Implementation
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }
    
    // MARK: UI Functions
    
    func configureUI(recordingState:Bool) {
        switch (recordingState) {
        case true:
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        case false:
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
        }
    }
}

