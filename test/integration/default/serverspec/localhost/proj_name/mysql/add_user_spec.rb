require 'spec_helper'

mysql_command="mysql -uproj_name -pproj_name -Nse "

describe 'mysql user' do
  context command("#{mysql_command} 'SHOW GRANTS' | grep 'ALL PRIVILEGES'") do
    its(:stdout) { should match /ALL PRIVILEGES/ }
  end
end
