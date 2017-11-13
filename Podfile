source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'
inhibit_all_warnings!

target :GSDownloadDemo do
  pod 'AFNetworking'
  pod 'SVProgressHUD', :git => 'https://github.com/SVProgressHUD/SVProgressHUD.git'
  pod 'ReactiveObjC'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts #{target.name}
  end
end

