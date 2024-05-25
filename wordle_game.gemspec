# wordle_game.gemspec
Gem::Specification.new do |spec|
    spec.name          = "wordle_game"
    spec.version       = "0.1.0"
    spec.authors       = ["Egor Pavlov Nikita Kolomytsev"]
    spec.email         = ["lokwer321@gmail.com nkolomytsev10@gmail.com"]
    spec.summary       = %q{A Ruby library for playing a Wordle-like game.}
    spec.description   = %q{This library allows you to play a Wordle-like game with customizable word lengths.}
    spec.homepage      = "https://github.com/lok70/Ruble"
    spec.license       = "MIT"
  
    spec.files         = Dir.glob("lib/**/*.rb") + Dir.glob("spec/**/*.rb") + ["README.md"]
    spec.require_paths = ["lib"]
  
    spec.add_dependency "rspec"
  end
  