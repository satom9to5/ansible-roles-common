require 'spec_helper'

describe 'MySQL install' do
  context package('mysql') do
    it { should be_installed }
  end

  context package('mysql-server') do
    it { should be_installed }
  end

  context package('mysql-devel') do
    it { should be_installed }
  end

  context package('MySQL-python') do
    it { should be_installed }
  end

  context service('mysqld') do
    it { should be_enabled }
    it { should be_running }
  end

  context port(3306) do
    it { should be_listening }
  end
end
