Pod::Spec.new do |spec|
  spec.name         = "VI_Vahan_Flow_POD"
  spec.version      = "1.0.1"
  spec.summary      = "Demo Pod for Vahan API"
  spec.description  = "This pod provides functions to interact with Vahan API."
  spec.homepage     = "https://github.com/darshitvehicleinfo/VI_Vahan_Flow_POD"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "VI Vahan" => "viVahan@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.swift_version = "5.0"

  spec.source       = { :git => "https://github.com/darshitvehicleinfo/VI_Vahan_Flow_POD.git", :tag => spec.version.to_s }

spec.source_files = 'VI_Vahan_Flow_POD/Source Code/Vahan Files/**/*.{swift}'

  spec.dependency "Alamofire"
  spec.dependency "SwiftyJSON"
  spec.dependency "CryptoSwift"
end
