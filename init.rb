require 'redmine'
require_dependency 'acquaint_hook_listener'

Redmine::Plugin.register :uplugin do
  name 'Uplugin plugin'
  author 'Nick'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url ''
  author_url ''
end
