Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "T-AlamofireCustom"
s.summary = "T-AlamofireCustom is network manager."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "[Thien Pham" => "thienphamios@gmail.com" }

# For example,
# s.author = { "Joshua Greene" => "jrg.developer@gmail.com" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/thienpham234/T-AlamofireCustom"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/thienpham234/T-AlamofireCustom.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"
s.dependency 'ReachabilitySwift', '~> 3' #3
s.dependency 'PKHUD', '~> 4.2' #4.2.1
s.dependency 'Alamofire', '~> 4.4' #4.4.0
s.dependency 'AlamofireObjectMapper', '~> 4.1' #4.1.0
s.dependency 'AlamofireImage', '~> 3.2' #3.2.0
s.dependency 'AlamofireNetworkActivityIndicator', '~> 2.1' #2.1.0
s.dependency 'SwiftyJSON', '~> 3.1' #3.1.4
s.dependency 'CryptoSwift', '~> 0.6' #0.6.8
# 8
s.source_files = "T-AlamofireCustom/**/*.{swift}"

end
