namespace :os do
  task :linux => :environment do
    copy :linux
  end
  task :osx => :environment do
    copy :osx
  end
end

def copy os
  `cp vendor_cd/#{os}/libchartdir.so vendor`
end