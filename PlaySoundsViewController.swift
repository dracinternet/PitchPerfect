//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Eduardo Lozano Gálvez on 14/04/15.
//  Copyright (c) 2015 Drac Internet. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var recivedAudio: RecordedAudio!

    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: recivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true

        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func prepareForPlayback(rate: Float, time: NSTimeInterval) {
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = time
    }
    
    @IBAction func SlowPlayback(sender: UIButton) {
        resetAudioEngine()
        prepareForPlayback(0.7, time: 0)
        audioPlayer!.play()
    }

    @IBAction func FastPlayback(sender: UIButton) {
        resetAudioEngine()
        prepareForPlayback(1.8, time: 0)
        audioPlayer!.play()
    }
    

    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }

    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        resetAudioEngine()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func StopPlayback(sender: UIButton) {
        audioPlayer.stop()
    }
    
    func resetAudioEngine () {
        audioEngine.stop()
        audioEngine.reset()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}








