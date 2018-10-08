Pod::Spec.new do |s|

  s.name         = "Vatosawa"
  s.version      = "0.0.2"
  s.summary      = "API pod for CE Broker"
  s.description  = "API pod for share between condorlabs projects"

  s.homepage     = "http://condorlabs.io"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "" => "" }
  s.platform     = :ios, "12.0"
  s.source       = { :git => "https://github.com/cebroker/Vatosawa.git", :tag => "0.0.2 }
  #s.source       = { :path => '.' }
  s.source_files  = "Vatosawa"
  s.exclude_files = "Classes/Exclude"
  s.swift_version = "4.0" 

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  s.dependency 'Alamofire'
  s.dependency 'RxSwift'
end
