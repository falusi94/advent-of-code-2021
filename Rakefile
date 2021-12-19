#!/usr/bin/env rake
# frozen_string_literal: true

module Helpers
  def self.pad_day(day) = day.to_i < 10 ? "0#{day}" : day

  def self.boot
    require 'bundler/setup'
    Bundler.require
  end
end

desc 'Run solution for given day'
task :run, [:number_of_day, :number_of_part] do |_task, args|
  Helpers.boot

  number_of_day = Helpers.pad_day(args.number_of_day)
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

desc 'Bootstrap new day'
task :add_day, [:number_of_day] do |_task, args|
  require 'fileutils'

  number_of_day = Helpers.pad_day(args.number_of_day)
  dir_path      = "solution/day_#{number_of_day}"

  FileUtils.mkdir(dir_path) unless File.exist?(dir_path)
  FileUtils.touch("#{dir_path}/input.txt")
  FileUtils.touch("#{dir_path}/main_1.rb")
  FileUtils.touch("#{dir_path}/main_2.rb")
end
