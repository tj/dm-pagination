
$:.unshift 'lib'
require 'dm-is-paginated'
require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new "dm-is-paginated", DataMapper::Is::Paginated::VERSION do |p|
  p.author = "TJ Holowaychuk"
  p.email = "tj@vision-media.ca"
  p.summary = "DataMapper Pagination"
  p.url = "http://github.com/visionmedia/dm-is-paginated"
  p.runtime_dependencies = ['dm-core >=0.10.1']
end

Dir['tasks/**/*.rake'].sort.each { |f| load f }