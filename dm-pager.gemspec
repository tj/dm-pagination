# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-pager}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["TJ Holowaychuk"]
  s.date = %q{2009-12-19}
  s.description = %q{DataMapper Pagination}
  s.email = %q{tj@vision-media.ca}
  s.extra_rdoc_files = ["lib/dm-pager.rb", "lib/dm-pager/defaults.rb", "lib/dm-pager/helpers.rb", "lib/dm-pager/helpers/rails.rb", "lib/dm-pager/pager.rb", "lib/dm-pager/pagination.rb", "lib/dm-pager/version.rb", "tasks/docs.rake", "tasks/gemspec.rake", "tasks/spec.rake"]
  s.files = ["History.md", "Manifest", "Rakefile", "Readme.md", "dm-pager.gemspec", "examples/pager.rb", "lib/dm-pager.rb", "lib/dm-pager/defaults.rb", "lib/dm-pager/helpers.rb", "lib/dm-pager/helpers/rails.rb", "lib/dm-pager/pager.rb", "lib/dm-pager/pagination.rb", "lib/dm-pager/version.rb", "spec/integration/rails_helper_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/unit/pager_spec.rb", "spec/unit/pagination_spec.rb", "tasks/docs.rake", "tasks/gemspec.rake", "tasks/spec.rake"]
  s.homepage = %q{http://github.com/visionmedia/dm-pagination}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Dm-pager", "--main", "Readme.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{dm-pager}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{DataMapper Pagination}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dm-core>, [">= 0.10.1"])
      s.add_runtime_dependency(%q<dm-aggregates>, [">= 0.10.1"])
    else
      s.add_dependency(%q<dm-core>, [">= 0.10.1"])
      s.add_dependency(%q<dm-aggregates>, [">= 0.10.1"])
    end
  else
    s.add_dependency(%q<dm-core>, [">= 0.10.1"])
    s.add_dependency(%q<dm-aggregates>, [">= 0.10.1"])
  end
end
