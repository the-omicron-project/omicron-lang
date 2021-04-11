#!/usr/bin/env crystal

require "./omicron/runner"

if ARGV.size > 1
  puts "USAGE: omicron [file]"
  exit(1)
elsif ARGV.size == 1
  Omicron::Runner.run_file(ARGV[0])
else
  Omicron::Runner.run_prompt
end
