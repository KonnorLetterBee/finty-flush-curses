$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

name = "finty"
require "#{name}/version"

Gem::Specification.new name, FintyFlush::VERSION do |s|
  s.summary = "Play Finty Flush using Curses"
  s.email = ""
  s.homepage = ""
  s.authors = ["Konnor Nicolau"]
  s.executables = [name]
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
  s.add_runtime_dependency "dispel"
end

