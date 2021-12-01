#!/usr/bin/env rake
# frozen_string_literal: true

desc 'Run solution for given day'
task :run, [:number_of_day] do |_task, args|
  require 'bundler/setup'
  Bundler.require

  number_of_day = args.number_of_day.to_i
  number_of_day = "0#{number_of_day}" if number_of_day < 10

  require_relative "solution/day_#{number_of_day}/main"
end
