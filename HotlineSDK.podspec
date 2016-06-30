
Pod::Spec.new do |s|

  s.name         = "HotlineSDK"
  s.version      = "1.1.1"
  s.summary      = "Hotline - iOS SDK - In-app support and engagement done right"
  s.description  = <<-DESC
                   Hotline enables businesses and app owners to engage, retain and sell more to their mobile app users by powering novel support and engagement features in these apps.
                   DESC
  s.homepage     = "http://www.hotline.io"
  s.license = { :type => 'Commercial', :text => 'See http://www.hotline.io/terms' } 
  s.author             = { "Freshdesk" => "support@hotline.io" }
  s.social_media_url   = "https://twitter.com/gethotline"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/freshdesk/hotline-ios.git", :tag => "v#{s.version}" }
  s.source_files  = "HotlineSDK/*.{h,m}"
  s.preserve_paths = "HotlineSDK/*"
  s.resources = "HotlineSDK/HLResources.bundle", "HotlineSDK/KonotorModels.bundle", "HotlineSDK/HLLocalization.bundle"
  s.ios.vendored_library = "HotlineSDK/libFDHotlineSDK.a"
  s.frameworks = "Foundation", "AVFoundation", "AudioToolbox", "CoreMedia", "CoreData", "ImageIO", "SystemConfiguration"
  s.xcconfig       = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/HotlineSDK"' }
  s.requires_arc = true

end
