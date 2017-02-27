
require 'serverspec'

# Required by serverspec
set :backend, :exec

describe command('/usr/local/share/env-rekall/bin/pip freeze') do
#  its(:stdout) { should match /wheel/ }
  its(:stdout) { should match /ipython/ }
  its(:stdout) { should match /efilter/ }
  its(:stdout) { should match /pytsk3/ }
  its(:stdout) { should match /pyaff4/ }
  its(:stdout) { should match /rekall/ }
  its(:stdout) { should match /rekall-yara/ }
  its(:stdout) { should match /six/ }
end
#describe file('/usr/local/bin/rekall') do
describe file('/usr/local/share/env-rekall/bin/rekall') do
  it { should exist }
  it { should be_executable }
end
describe command('/usr/local/share/env-rekall/bin/rekall --version') do
  its(:stdout) { should match /This is Rekall Version/ }
end
describe command('/usr/local/bin/rekall --version') do
  its(:stdout) { should match /This is Rekall Version/ }
end

