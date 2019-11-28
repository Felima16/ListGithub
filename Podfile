# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ListGithub' do
  inherit! :search_paths
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ListGithub
#
#  target 'ListGithubTests' do
#    inherit! :search_paths
#    # Pods for testing
#  end
#
#  target 'ListGithubUITests' do
#    # Pods for testing
#  end
  
  abstract_target 'Tests' do
    target "ListGithubTests"
    target "ListGithubUITests"

    pod 'Quick'
    pod 'Nimble'
    pod 'Nimble-Snapshots'
    pod 'Mockingjay'
  end

end
