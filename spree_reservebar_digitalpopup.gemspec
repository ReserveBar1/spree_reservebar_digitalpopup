Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_reservebar_digitalpopup'
  s.version     = '0.0.1'
  s.summary     = 'Digital Popup stores for reservebar.com'

  s.author        = 'Jason Knebel'
  s.email         = 'jknebel@reservebar.com'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = false
end
