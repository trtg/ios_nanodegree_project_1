//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by sebastian ortiz on 3/9/15.
//  Copyright (c) 2015 sebortiz. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
       playAudioWithVariablePitch(1000)
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
//        
       var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
//        
        audioEngine.connect(audioPlayerNode,to:changePitchEffect,format:nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode,format:nil)

        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
   
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5;
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5;
        audioPlayer.play()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        println(receivedAudio.title)
//        if var fullPath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            println(fullPath)
//            
//            var error: NSError? = nil
//            println(NSURL(fileURLWithPath: fullPath))
//            
//            println(audioPlayer)
//            
//        }else{
//            println("filepath was empty");
//        }
        //The segue grabs a handle to this class
        //and sets the value of receivedAudio that way
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error:nil)
        audioPlayer.enableRate = true;
        
        audioEngine = AVAudioEngine()
        audioFile =  AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
