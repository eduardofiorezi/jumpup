module Jumpup::BundlerCommand
  class << self

    def install_with_clean_env
      Bundler.with_clean_env do
        sh 'bundle install --quiet'
      end
    end

  end
end
