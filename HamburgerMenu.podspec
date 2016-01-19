#
# Be sure to run `pod lib lint HamburgerMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "HamburgerMenu"
  s.version          = "1.0.2"
  s.summary          = "An Elegant UITabBarController Subclass."
  s.description      = "An Elegant UITabBarController Subclass that makes it easy to add a HamburgerMenu to your project."

  s.homepage         = "https://github.com/tannernelson/hamburger-menu"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Tanner Nelson" => "tannernelson@gmail.com" }
  s.source           = { :git => "https://github.com/tannernelson/hamburger-menu.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/the_teet'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'HamburgerMenu' => ['Pod/Assets/*.png']
  }

  s.dependency 'HamburgerButton', '~> 1.0'
end
