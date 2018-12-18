Pod::Spec.new do |s|

  s.name         = "Vatosawa"
  s.version      = "0.1.6"
  s.summary      = "API pod for CE Broker"
  s.description  = "API pod for share between condorlabs projects"

  s.homepage     = "http://condorlabs.io"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "" => "" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/cebroker/Vatosawa.git", :tag => "#{s.version}" }
  s.source_files  = "Vatosawa"
  s.exclude_files = "Classes/Exclude"
  s.swift_version = "4.0"
 
  s.dependency 'Alamofire'
  s.dependency 'RxSwift'
  s.dependency 'KeychainAccess'
end
