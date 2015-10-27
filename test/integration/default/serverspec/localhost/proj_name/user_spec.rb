require 'spec_helper'

describe user('proj_name') do
  it { should exist }
  it { should have_home_directory '/home/proj_name' }
  it { should have_login_shell '/bin/bash' }
end
