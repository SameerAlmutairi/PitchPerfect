//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Sameer Almutairi on 26/03/2019.
//  Copyright © 2019 Sameer Almutairi. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func recordAudio(_ sender: Any) {
//        recordingLabel.text = "Recording In Progress"
//        stopRecordingButton.isEnabled = true
//        recordButton.isEnabled = false
        configuringUI(true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()

    }
    

    func configuringUI(_ isRecording: Bool = false){
        recordingLabel.text = isRecording ? "Recording In Progress": "Tap to Record"
        stopRecordingButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
//        if isRecording == true {
//            recordingLabel.text = "Recording In Progress"
//            stopRecordingButton.isEnabled = true
//            recordButton.isEnabled = false
//        } else {
//            recordingLabel.text = "Tap to Record"
//            recordButton.isEnabled = true
//            stopRecordingButton.isEnabled = false
//        }
    }
    
    @IBAction func stopRecording(_ sender: Any) {
//        recordingLabel.text = "Tap to Record"
//        recordButton.isEnabled = true
//        stopRecordingButton.isEnabled = false
        configuringUI(false)
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)

    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)

        } else {
            print("recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

