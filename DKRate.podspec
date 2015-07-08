Pod::Spec.new do |s|
  s.name = "DKRate"
  s.version = "0.0.1"
  s.summary = "iOS library, that shows rating view and helps to promote your app."
  s.homepage = "https://github.com/wade0n/DKRate"
  s.license = { :type => 'MIT', :file => 'LICENSE'}
  s.author = { "Dmitrii Kalashnikov" => "mr.dmitriikalashnikov@gmail.com" }
  s.source = {
      :git => "https://github.com/wade0n/DKRate.git",
      :tag => s.version.to_s
    }

  s.ios.deployment_target = '7.0'

  s.default_subspec = 'core'

  s.subspec 'core' do |c|
    c.requires_arc = true
    c.source_files = 'core/Source/*'
    c.resources = 'core/Resource/*'
    c.dependency  'StarRatingView'
    c.dependency  'CXAlertView'
    c.dependency  'iRate'
    c.dependency  'Chivy'
  end

end

