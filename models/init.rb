# encoding: utf-8

require_relative 'question'
require_relative 'tag'

Sequel.extension :core_extensions
DB.extension(:pagination)