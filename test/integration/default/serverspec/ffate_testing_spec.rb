require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

describe file('/artifacts/testdisk-ntfs/bodyfile') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /0\|C:\/\$MFT \(\$FILE_NAME\)\|0-48-3\|/ }
end
describe file('/artifacts/testdisk-ntfs/bulk_extractor_disk/windirs.txt') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /System Volume Information/ }
end
describe file('/artifacts/testdisk-ntfs/foremost/audit.txt') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /FILES EXTRACTED/ }
  its(:content) { should match /Foremost finished at/ }
end
describe file('/artifacts/testdisk-ntfs/fs-timeline.csv') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /Date,Size,Type,Mode,UID,GID,Meta,File Name/ }
  its(:content) { should match /Thu Oct 23 2003 02:57:40,2000,m...,r\/rrwxrwxrwx,0,0,36-128-3,"C:\/file-n-4.dat"/ }
end
describe file('/artifacts/testdisk-ntfs/plaso.dump') do
  it { should be_file }
  its(:size) { should > 0 }
end
describe file('/artifacts/testdisk-ntfs/sorter/index.html') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /sorter output/ }
end
describe file('/artifacts/testdisk-ntfs/supertimeline.csv') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /NTFS Content Modification Time/ }
end
describe file('/artifacts/testdisk-ntfs/testdisk-ntfs.blkls') do
  it { should be_file }
  its(:size) { should > 0 }
end


describe file('/artifacts/testdisk-ext3/bodyfile') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /0\|\/lost\+found|11/ }
end
describe file('/artifacts/testdisk-ext3/bulk_extractor_disk/report.xml') do
  it { should be_file }
  its(:size) { should > 0 }
end
describe file('/artifacts/testdisk-ext3/foremost/audit.txt') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /FILES EXTRACTED/ }
  its(:content) { should match /Foremost finished at/ }
end
describe file('/artifacts/testdisk-ext3/fs-timeline.csv') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /Date,Size,Type,Mode,UID,GID,Meta,File Name/ }
  its(:content) { should match /Xxx Xxx 00 0000 00:00:00,12288,...b,d\/drwx------,0,0,11,/ }
end
describe file('/artifacts/testdisk-ext3/plaso.dump') do
  it { should be_file }
  its(:size) { should > 0 }
end
describe file('/artifacts/testdisk-ext3/sorter/index.html') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /sorter output/ }
end
describe file('/artifacts/testdisk-ext3/supertimeline.csv') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /\/lost\+found,TSK:\/lost\+found Type: directory/ }
end
describe file('/artifacts/testdisk-ext3/testdisk-ext3.blkls') do
  it { should be_file }
  its(:size) { should > 0 }
end


describe file('/artifacts/testdisk-hfs/bodyfile') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /0\|\/.Trashes\|19\|/ }
end
describe file('/artifacts/testdisk-hfs/bulk_extractor_disk/report.xml') do
  it { should be_file }
  its(:size) { should > 0 }
end
describe file('/artifacts/testdisk-hfs/bulk_extractor_disk/email.txt') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /AOU3JL@Rc.BS/ }
end
describe file('/artifacts/testdisk-hfs/foremost/audit.txt') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /FILES EXTRACTED/ }
  its(:content) { should match /Foremost finished at/ }
end
describe file('/artifacts/testdisk-hfs/fs-timeline.csv') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /Date,Size,Type,Mode,UID,GID,Meta,File Name/ }
  its(:content) { should match /Sun Jan 09 2005 09:56:19,0,macb,d\/d-wx-wx-wt,99,99,19,/ }
end
describe file('/artifacts/testdisk-hfs/plaso.dump') do
  it { should be_file }
  its(:size) { should > 0 }
end
describe file('/artifacts/testdisk-hfs/sorter/index.html') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /sorter output/ }
end
describe file('/artifacts/testdisk-hfs/supertimeline.csv') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /HFS_DETECT crtime,crtime,-,,\/\^\^\^\^HFS\+ Private Data/ }
end
describe file('/artifacts/testdisk-hfs/testdisk-hfs.blkls') do
  it { should be_file }
#  its(:size) { should > 0 }
end


describe file('/artifacts/testmemory-win2k3/pslist_output') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /wpabaln.exe/ }
end
describe file('/artifacts/testmemory-win2k3/sockets_output') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /PID\s+Port\s+Proto\s+Protocol\s+Address\s+Create Time/ }
  its(:content) { should match /127.0.0.1/ }
end
describe file('/artifacts/testmemory-win2k3/timeliner_bodyfile_output') do
  it { should be_file }
  its(:size) { should > 0 }
  its(:content) { should match /WS2_32.dll Process: services.exe/ }
end


