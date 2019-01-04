require 'serverspec'

# Required by serverspec
set :backend, :exec

jenkins_url = 'http://localhost:8888/'
jenkins_user = 'admin_ffate'
jenkins_pass = 'admin_ffate'

describe service('jenkins') do  
  it { should be_enabled   }
  it { should be_running   }
end  

describe file('/var/lib/jenkins/config.xml') do
  it { should be_readable }
end

describe process("java") do
  its(:user) { should eq "jenkins" }
  its(:args) { should match /-jar \/usr\/share\/jenkins\/jenkins.war/ }
end

describe port(8888) do
  it { should be_listening }
end

## ERROR: This command is requesting the deprecated -remoting mode. See https://jenkins.io/redirect/cli-command-requires-channel
## This mode is disabled on the server side for new installations of 2.54+ and 2.46.2
#describe command("java -jar /opt/jenkins-cli.jar -s #{jenkins_url} login --username #{jenkins_user} --password #{jenkins_pass}"), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
#  its(:exit_status) { should eq 0 }
#end
#describe command("java -jar /opt/jenkins-cli.jar -s #{jenkins_url} version --username #{jenkins_user} --password #{jenkins_pass}"), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
#  its(:stdout) { should match /2\.\d+/ }
#  its(:exit_status) { should eq 0 }
#end
#describe command("java -jar /opt/jenkins-cli.jar -s #{jenkins_url} list-plugins --username #{jenkins_user} --password #{jenkins_pass}"), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
#  its(:stdout) { should match /rebuild/ }
#  its(:stdout) { should match /parameterized-trigger/ }
#  its(:exit_status) { should eq 0 }
#end
#
#describe command("java -jar /opt/jenkins-cli.jar -s #{jenkins_url}jenkins version --username #{jenkins_user} --password #{jenkins_pass}"), :if => os[:family] == 'ubuntu' && os[:release] == '14.04' do
#  its(:exit_status) { should eq 0 }
#end
#describe command("java -jar /opt/jenkins-cli.jar -s #{jenkins_url}jenkins list-plugins --username #{jenkins_user} --password #{jenkins_pass}"), :if => os[:family] == 'ubuntu' && os[:release] == '14.04' do
#  its(:stdout) { should match /rebuild/ }
#  its(:stdout) { should match /parameterized-trigger/ }
#  its(:exit_status) { should eq 0 }
#end

describe file('/var/log/jenkins/jenkins.log') do
  it { should be_readable }
## can have 'SEVERE: I/O error in channel HTTP full-duplex channel'
#  its(:content) { should_not match /SEVERE: / }
#  its(:content) { should_not match /WARNING: Could not intialize the host network interface on nullbecause of an error:/ }
  its(:content) { should_not match /WARNING: CLI authentication failure/ }
  its(:content) { should_not match /WARNING: Failed to run script file/ }
  its(:content) { should_not match /INFO: CLI login attempt failed/ }
end


