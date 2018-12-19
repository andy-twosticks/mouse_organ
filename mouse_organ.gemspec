lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mouse_organ'

Gem::Specification.new do |spec|
  spec.name          = "mouse_organ"
  spec.version       = MouseOrgan::VERSION
  spec.authors       = ["Andy Jones"]
  spec.email         = ["andy.jones@twosticksconsulting.co.uk"]
  spec.summary       = %q|Tiny state machine|
  spec.description   = <<-DESC.gsub(/^\s+/, "")
    A tiny mixin to turn a class into a state machine.
  DESC

  spec.homepage      = "https://bitbucket.org/andy-twosticks/mouse_organ"
  spec.license       = "MIT"

  spec.files         = `hg status -macn0`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.extra_rdoc_files = spec.files.grep(%r{^md/})

  #spec.add_runtime_dependency "devnull",    '~>0.1'
  #spec.add_runtime_dependency "octothorpe", '~>0.4'

end
