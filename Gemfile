source 'https://rubygems.org'

# Static site generator.
gem 'nanoc', '~> 4.11'

# About `:nanoc` group, see <https://nanoc.ws/doc/cli/#bundler-integration>.
group :nanoc do
  # Required for `nanoc live` command.
  gem 'nanoc-live'
  gem 'adsf'
end

# Required by `relativize_paths` filter.
gem 'nokogiri', '~> 1'

# Required by page templates.
gem 'slim'

# Required by `sass` filter.
gem 'sass'

# Required by `pygmentsrb` filter and `pygments` highlighter for asciidoctor.
gem 'pygments.rb'

# Required for tags system.
gem 'rgl', '~> 0.5.3'

# Required for `Nanoc::Helpers::XMLSitemap`.
gem 'builder'

# Required for validations.
gem 'w3c_validators'
