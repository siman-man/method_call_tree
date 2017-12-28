lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "method_call_tree/version"

Gem::Specification.new do |spec|
  spec.name          = "method_call_tree"
  spec.version       = MethodCallTree::VERSION
  spec.authors       = ["Shuichi Tamayose"]
  spec.email         = ["tmshuichi@gmail.com"]

  spec.summary       = %q{method call tree}
  spec.description   = %q{method call tree}
  spec.homepage      = "https://github.com/siman-man/method_call_tree"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
