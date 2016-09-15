//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mike Huffaker on 9/11/16.
//  Copyright © 2016 Mike Huffaker. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController
{
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var darthvaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum ButtonType: Int { case Slow = 0,
                                Fast = 1,
                                Chipmunk = 2,
                                Vader = 3,
                                Echo = 4,
                                Reverb = 5 }
    
    // MHH - Handle user button press - option value of the GUI buttonm that
    //       was pressed maps up to the values in the ButtonType ENUM
    @IBAction func playSoundForButton( sender: UIButton )
    {
        print( "PlaySoundsViewController: Play Sound Button Pressed" )
        
        switch( ButtonType ( rawValue: sender.tag )! )
        {
            case .Slow:
                playSound( rate: 0.5 )
            case .Fast:
                playSound( rate: 1.5 )
            case .Chipmunk:
                playSound( pitch: 1000 )
            case .Vader:
                playSound( pitch: -1000 )
            case .Echo:
                playSound( echo: true )
            case .Reverb:
                playSound( reverb: true )
        }
        
        configureUI( .Playing )
    }
    
    // MHH - Handle user stop button press
    @IBAction func stopButtonPressed( sender: AnyObject )
    {
        print( "PlaySoundsViewController: Stop Audio Button Pressed" )
        stopAudio()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print( "PlaySoundsViewController: PlaySoundsViewController did load" )

        // MHH - Added per forum post to stop crash, setupAudio() must have to be
        // called before any playback can occur
        setupAudio()
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
