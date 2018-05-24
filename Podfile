# Uncomment this line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

#Swift Lint
pod 'SwiftLint'

def common_pods
  pod 'XCGLogger'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'SwiftyJSON'
  pod 'Kingfisher'
end

def test_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'Telegraph' do
  common_pods
end

target 'TelegraphTests' do
  inherit! :search_paths
  common_pods
  test_pods
end

# after pod install, override default configs for schemes or targets specified
debug_schemes = ['Debug']
swift_4_pods = ['RxCocoa','RxSwift','RxSwiftExt','XCGLogger']

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if not swift_4_pods.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
        target.build_configurations.each do |config|
          if debug_schemes.include? config.name
            # enable faster compilation by building only the active arch for debug schemes
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
            config.build_settings['ENABLE_TESTABILITY'] = 'YES'
          end
        end
    end
end
