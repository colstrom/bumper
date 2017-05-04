#!/usr/bin/env ruby

require 'git'
require 'semver'

version = SemVer.parse Git.open(Dir.pwd).describe('HEAD', tags: true, abbrev: 0)

ARGF.each do |bump|
  case bump.chomp!
  when 'MAJOR'
    version.major = version.major.next
    version.minor = 0
    version.patch = 0
  when 'MINOR'
    version.minor = version.minor.next
    version.patch = 0
  when 'PATCH'
    version.patch = version.patch.next
  else
    STDERR.puts "Ignored unknown target: #{bump}"
  end
  puts version
end

puts version
