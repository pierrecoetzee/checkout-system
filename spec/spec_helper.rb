require 'rspec'
ROOT_DIR = "#{__dir__}/.." unless defined?(ROOT_DIR)
Bundler.require :test

$LOAD_PATH.unshift("#{ROOT_DIR}/lib",__dir__)