require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/contrib/rubyforgepublisher'
require 'fileutils'                                     

# Added 07/2008 newgem <<<
require 'config/requirements'
require 'config/hoe' # setup Hoe + all gem configuration
        
Dir['tasks/**/*.rake'].each { |rake| load rake }           
# <<<                          
