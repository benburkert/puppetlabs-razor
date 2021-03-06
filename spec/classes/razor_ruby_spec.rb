require 'spec_helper'

describe 'razor::ruby', :type => :class do

  ['Debian', 'Redhat'].each do |osfamily|
    context "on #{osfamily} operatingsystems" do
      let(:facts) do
        { :osfamily => osfamily }
      end
      it {
        should contain_package('make')
        should contain_package('gcc')
        should include_class('ruby')
      }
      it {
        [ 'base62', 'bson', 'bson_ext', 'colored',
          'daemons', 'json', 'logger', 'macaddr', 'mongo',
          'net-ssh', 'require_all', 'syntax', 'uuid'
        ].each do |pkg|
          should contain_package(pkg).with(
            :ensure   => 'present',
            :provider => 'gem',
            :require  => [ 'Class[Ruby]', 'Class[Ruby::Dev]', 'Package[make]', 'Package[gcc]' ]
          )
        end
      }
    end
  end
end
