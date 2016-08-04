Pod::Spec.new do |s|
  s.name         = 'AFNetworking'
  s.version      = '<#Project Version#>'
  s.license      = '<#License#>'
  s.homepage     = '<#Homepage URL#>'
  s.authors      = '<#Author Name#>': '<#Author Email#>'
  s.summary      = '<#Summary (Up to 140 characters#>'

  s.platform     =  :ios, '<#iOS Platform#>'
  s.source       =  git: '<#Github Repo URL#>', :tag => s.version
  s.source_files = '<#Resources#>'
  s.frameworks   =  '<#Required Frameworks#>'
  s.requires_arc = true
  
# Pod Dependencies
  s.dependencies =	pod 'AFNetworking'
  s.dependencies =	pod 'Masonry'
  s.dependencies =	pod 'MOBFoundation_IDFA'
  s.dependencies =	pod 'SMSSDK'
  s.dependencies =	pod 'ReactiveCocoa', '2.0'

end