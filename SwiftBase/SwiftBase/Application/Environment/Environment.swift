//
//  Environment.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain

public enum Environment {
  public static var shared: EnvironmentType = {
    #if PRODUCTION
      return ProductionEnvironment()
    #elseif STAGING
      return StagingEnvironment()
    #elseif WORKFLOW
      return WorkflowEnvironment()
    #elseif DEMO
      return DemoEnvironment()
    #elseif DEVELOPMENT
      return DevelopmentEnvironment()
    #else
      fatalError("Bad end point")
    #endif
  }()
}
