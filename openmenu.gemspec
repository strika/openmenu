# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "openmenu"
  s.version = "0.3.0"
  s.platform = Gem::Platform::RUBY
  s.authors = ["Nebojsa Stricevic"]
  s.email = ["nebojsa.stricevic@gmail.com"]
  s.homepage = "http://github.com/strika/openmenu"
  s.summary = %q{OpenMenu mapper.}
  s.description = %q{OpenMenu mapper.}

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("happymapper", ">= 0.4.0")
  s.add_development_dependency("rake", ">= 10.0.3")
end
