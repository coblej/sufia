# -*- encoding: utf-8 -*-
version = File.read(File.expand_path("../SUFIA_VERSION",__FILE__)).strip

Gem::Specification.new do |gem|
  gem.authors       = ["Justin Coyne"]
  gem.email         = ["justin.coyne@yourmediashelf.com"]
  gem.description   = %q{Sufia is a Rails engine for creating a self-deposit institutional repository}
  gem.summary       = %q{Sufia was extracted from ScholarSphere developed by Penn State University}
  gem.homepage      = "http://github.com/projecthydra/sufia"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sufia"
  gem.require_paths = ["lib"]
  gem.version       = version
  gem.license       = 'APACHE2'

  gem.add_dependency 'sufia-models', version
  gem.add_dependency 'blacklight_advanced_search', '~> 5.0'
  gem.add_dependency 'blacklight', '~> 5.0'
  gem.add_dependency 'tinymce-rails', '~> 4.0.19'
  gem.add_dependency 'tinymce-rails-imageupload', '~> 4.0.16.beta'

  # sass-rails is typically generated into the app's gemfile by `rails new`
  # In rails 3 it's put into the "assets" group and thus not available to the
  # app. Blacklight 5.2 requires bootstrap-sass which requires (but does not
  # declare a dependency on) sass-rails
  gem.add_dependency 'sass-rails'

  gem.add_dependency 'hydra-batch-edit', '>= 1.1.1', '< 2.0.0'
  gem.add_dependency 'browse-everything', '>= 0.4.0'

  gem.add_dependency 'daemons', '1.1.9'
  gem.add_dependency 'mail_form'
  gem.add_dependency 'rails_autolink', '~> 1.1.0'
  gem.add_dependency 'yaml_db', '0.2.3'
  gem.add_dependency 'font-awesome-sass-rails', '~> 3.0'
end
