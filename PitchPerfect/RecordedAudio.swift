//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Eduardo Lozano Gálvez on 25/04/15.
//  Copyright (c) 2015 Drac Internet. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {

    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}