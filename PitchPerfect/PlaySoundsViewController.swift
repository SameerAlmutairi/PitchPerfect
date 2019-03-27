//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Sameer Almutairi on 27/03/2019.
//  Copyright © 2019 Sameer Almutairi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var recordedAudioURL: URL!
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
//    myButton.imageView?.contentMode = .scaleAspectFit
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case
            slow = 0,
            fast = 1,
            highPitch = 2,
            lowPitch = 3,
            echo = 4,
            reverb = 5
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        slowButton.imageView?.contentMode = .scaleAspectFit
        fastButton.imageView?.contentMode = .scaleAspectFit
        highPitchButton.imageView?.contentMode = .scaleAspectFit
        lowPitchButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
//        slowButton.imageView?.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton){
        switch (ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .highPitch:
                playSound(pitch: 1000)
            case .lowPitch:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopSoundForButton(_ sender: AnyObject){
        stopAudio()
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
