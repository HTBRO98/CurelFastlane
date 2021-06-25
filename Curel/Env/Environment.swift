//
//  File.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/06/25.
//

import Foundation

class Environment {
    
    enum FlaverType {
        case develop
        case staging
        case production
    }
    
    enum BuildType {
        case debug
        case release
    }
    
    static func getFlavertype() -> FlaverType {
        #if DEVELOP_DEBUG
        return .develop
        #elseif DEVELOP_REALSE
        return .develop
        #elseif STAGING_DEBUG
        return .staging
        #elseif STAGING_RELEASE
        return .staging
        #elseif PRODUCTION_DEBUG
        return .production
        #elseif PRODUCTION_RELEASE
        return .production
        #endif
    }
    
    static func getBuildType() -> BuildType {
        #if DEVELOP_DEBUG
        return .debug
        #elseif DEVELOP_RELEASE
        return .release
        #elseif STAGING_DEBUG
        return .debug
        #elseif STAGING_RELEASE
        return .release
        #elseif PRODUCTION_DEBUG
        return .debug
        #elseif PRODUCTION_RELEASE
        return .release
        #endif
    }
    
}
