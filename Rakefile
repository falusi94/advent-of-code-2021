#!/usr/bin/env rake
# frozen_string_literal: true

desc 'Run solution for given day'
task :run, [:number_of_day, :number_of_part] do |_task, args|
  require 'bundler/setup'
  Bundler.require

  number_of_day = args.number_of_day.to_i
  number_of_day = "0#{number_of_day}" if number_of_day < 10
  path          = "solution/day_#{number_of_day}/main"

  if args.number_of_part
    require_relative "#{path}_#{args.number_of_part}"
  elsif File.exist?("#{path}.rb")
    require_relative path
  else
    require_relative "#{path}_1"
    require_relative "#{path}_2"
  end
end
