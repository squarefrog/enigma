#!/usr/bin/env ruby

# Copyright (c) 2016 Paul Williamson
# http://github.com/squarefrog/enigma
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#

# This script creates a JSON mapping of an Enigma machine motor. To use this script,
# pass in arguments like the example below:
#
# $ ruby enigma_rotor.rb --name I --turnover Q --mapping EKMFLGDQVZNTOWYHXUSPAIBRCJ

require 'json'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: enigma_rotor.rb [options]"

  opts.on("-m", "--mapping MAPPINGTEXT", "The alphabetical mapping for the rotor, e.g. EKMFLGDQVZNTOWYHXUSPAIBRCJ") do |m|
    options[:mapping] = m.upcase
  end

  opts.on("-n", "--name ROTORNAME", "The roman numeral of the rotor, e.g. IV") do |n|
    options[:name] = n.upcase
  end

  opts.on("-t", "--turnover NOTCHLETTER", "The turnover notch letter, e.g. rotor I is Q") do |t|
    options[:turnover] = t.upcase
  end
end.parse!

def verify_input(options)
  verify_mapping(options[:mapping])
  verify_rotor_name(options[:name])
  verify_turnover_notch(options[:turnover])
end

def verify_mapping(mapping)
  if mapping == nil
    raise "Mapping is required"
  end

  unless mapping.length == 26
    raise "Mapping has invalid length: got #{mapping.length}, expected 26"
  end

  unless mapping[/[a-zA-Z]+/]
    raise "Mapping should only contain letters"
  end
end

def verify_rotor_name(name)
  if name == nil
    raise "Rotor name should be supplied"
  end
end

def verify_turnover_notch(notch)
  if notch == nil
    raise "Turnover notch character should be supplied"
  end

  unless notch.length == 1 || notch.length == 2
    raise "Turnover notch should be a single character or double characters for rotors VI, VII, and VIII"
  end

  unless notch[/[a-zA-Z]+/]
    raise "Turnover notch should only contain letters"
  end
end

def parse_mapping(options)
  mapping = []
  options[:mapping].each_char.with_index do |char, index|
    char_index = char.ord - 65
    mapping << char_index
  end
  mapping
end

def turnover_number(notches)
  turnovers = []
  notches.each_char do |char|
    turnovers << char.ord - 65
  end
  turnovers
end

def create_mapping(options)
  verify_input(options)
  rotor_name = options[:name]
  mapping = parse_mapping(options)
  turnover_numbers = turnover_number(options[:turnover])
  mapping_hash = {
    "rotor_name" => rotor_name,
    "mapping" => mapping,
    "turnover" => turnover_numbers
  }
end

puts create_mapping(options).to_json

