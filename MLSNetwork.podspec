
Pod::Spec.new do |s|
  s.name         = "MLSNetwork"
  s.version      = "1.0.3"
  s.summary      = "模块化网络中心"
  s.description  = <<-DESC
                    基于YTKNewotk 二次封装，一款健壮的，可强自定义的网络库
                   DESC

  s.homepage     = "https://www.minlison.cn"
  s.license      = "MIT"
  s.author             = { "Minlison" => "yuanhang.1991@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Minlison/MLSNetwork.git", :tag => "v#{s.version}" }
  s.documentation_url = "https://minlison.cn/article/mlsnetwork"
  s.static_framework = true
  s.requires_arc = true
  s.default_subspec = 'Core'
  s.subspec 'Core' do |ss|
    ss.source_files  = "Classes/Core/**/*.{h,m}", "Classes/*.h"
    ss.public_header_files = "Classes/Core/**/*.h", "Classes/*.h"
    ss.frameworks = 'CFNetwork'
    ss.dependency "AFNetworking", "~> 3.2.1"
  end
  s.subspec 'RAC' do |ss|
    ss.source_files  = "Classes/RAC/**/*.{h,m}"
    ss.public_header_files = "Classes/RAC/**/*.h"
    ss.dependency "ReactiveObjC", "~> 3.1.0"
    ss.dependency "MLSNetwork/Core"
  end
  s.subspec 'Coobjc' do |ss|
    ss.source_files  = "Classes/coobjc/**/*.{h,m}"
    ss.public_header_files = "Classes/coobjc/**/*.h"
    ss.dependency "coobjc", "~> 1.2.0"
    ss.dependency "MLSNetwork/Core"
  end
end
